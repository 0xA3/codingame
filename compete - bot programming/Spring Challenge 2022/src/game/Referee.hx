package game;

import Std.int;
import Std.parseInt;
import agent.Agent;
import game.action.Action;
import game.action.ActionException;
import game.action.ActionType;
import gameengine.core.GameManager;
import haxe.Exception;
import haxe.Timer;
import tink.core.Signal;
import view.Attack;
import view.BaseAttack;
import view.Coord;
import view.EntityData;
import view.FrameViewData;
import view.SpellUse;
import xa3.MTRandom;

using Lambda;
using StringTools;
using xa3.MapUtils;

class Referee {
	
	public static final TYPE_MY_HERO = 0;
	public static final TYPE_ENEMY_HERO = 1;
	public static final TYPE_MOB = 2;
	public static final INPUT_TYPE_MOB = 0;
	public static final INPUT_TYPE_MY_HERO = 1;
	public static final INPUT_TYPE_ENEMY_HERO = 2;
	
	public var frameDataset(default, null):Signal<FrameViewData>;
	var frameDatasetTrigger:SignalTrigger<FrameViewData>;

	final gameManager:GameManager;
	final corners:Array<Vector>;
	final agentMe:Agent;
	final agentOpp:Agent;
	final agents:Array<Agent>;
	
	var gameSummaryManager:GameSummaryManager;


	var turn:Int;
	var scores:Array<Array<Int>> = [];
	var completes:Array<Array<String>> = [];

	var playerCount:Int;
	
	var allHeros:Array<Hero> = [];
	var allMobs:Array<Mob> = [];
	var mobRemovals:Array<Mob> = [];
	var mobSpawner:MobSpawner;
	var newEntities:Array<GameEntity> = [];
	var attacks:Array<Attack> = [];
	var spellUses:Array<SpellUse> = [];
	var baseAttacks:Array<BaseAttack> = [];
	var intentMap:Map<ActionType, Array<Hero>> = [];
	var positionKeyMap:Map<haxe.ds.ObjectMap<Vector, Bool>, Float> = [];
	
	var startDirections = [new Vector( 1, 1 ).normalize(), new Vector( -1, -1 ).normalize()];
	var basePositions:Array<Vector> = [];
	var allEntities:()->Array<GameEntity>;

	var timer:haxe.Timer;

	final actionTypes = [MOVE, WIND, SHIELD, CONTROL, IDLE];
	final symmetryOrigin = new Vector( Config.MAP_WIDTH / 2, Config.MAP_HEIGHT / 2 );

	public static var entityId = 0;

	public function new( gameManager:GameManager, corners:Array<Vector>, agentMe:Agent, agentOpp:Agent ) {
		this.gameManager = gameManager;
		this.corners = corners;
		this.agentMe = agentMe;
		this.agentOpp = agentOpp;
		
		agents = [agentMe, agentOpp];
		
		allEntities = () -> {
			final all:Array<GameEntity> = [];
			for( hero in allHeros) all.push( hero );
			for( mob in allMobs ) all.push( mob );
			return all;
		}
		frameDatasetTrigger = Signal.trigger();
		frameDataset = frameDatasetTrigger.asSignal();
	}

	public function init( currentRepeat:Int ) {

		final seed = currentRepeat;
		gameSummaryManager = new GameSummaryManager();
		
		computeConfiguration();

		MTRandom.initializeRandGenerator( seed );

		mobSpawner = new MobSpawner(
			Config.MOB_SPAWN_LOCATIONS,
			Config.MOB_SPAWN_MAX_DIRECTION_DELTA,
			Config.MOB_SPAWN_RATE
		);

		try {
			playerCount = gameManager.getPlayerCount();
			
			for( type in actionTypes ) {
				intentMap.set( type, [] );
			}
			initPlayers();
			
		} catch( e ) {
			trace( "Referee failed to initialize" );
			abort();
		}
	}

	function initPlayers() {
		// Generate heroes
		final spawnOffset = 1600;
		final spaceBetweenHeroes = 400;

		for( i in 0...playerCount ) {
			final player = gameManager.getPlayer( i );
			var vector = ( i < 2 ? new Vector( 1, -1 ) : new Vector( 1, 1 )).normalize();
			if( i % 2 == 1 ) {
				vector = vector.mult( -1 );
			}

			final startPoint = corners[i];

			basePositions.push( startPoint );
			final offsets = [0, 1, -1, 2, -2, 3, -3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			for( j in 0...Config.HEROES_PER_PLAYER ) {
				final offset = offsets[j + ( 1 - Config.HEROES_PER_PLAYER % 2 )];

				var position = vector.mult( offset * ( spaceBetweenHeroes )).add( startPoint ).add( startDirections[i].mult( spawnOffset ))
				.round();
				position = snapToGameZone( position );
				final hero = new Hero( entityId++, j, position, player, startDirections[i].angle() );
				player.addHero( hero );
				allHeros.push( hero );
				newEntities.push( hero );
			}
		}
		
		sendGlobalInfo();
		for( i in 0...gameManager.players.length ) agents[i].init( gameManager.players[i].getInputs() );
	}

	function sendGlobalInfo() {
		for( player in gameManager.getActivePlayers() ) {
			// <baseX> <baseY>
			player.sendInputLine( basePositions[player.index].toString() );
			// <heroesPerPlayer>
			player.sendInputLine( Std.string( Config.HEROES_PER_PLAYER ));
		}
	}

	public function run() {
		turn = 0;
		// while( turn < 2 && !gameManager.gameEnd ) {
		while( !gameManager.gameEnd ) {
			gameTurn( turn++ );
		}
		onEnd();
	}

	public function runWithTimer() {
		turn = 0;
		timer = new Timer( 5 );
		timer.run = nextTurn;
	}

	function nextTurn() {
		if( gameManager.gameEnd ) {
			timer.stop();
			onEnd();
			return;
		}
		gameTurn( turn++ );
	}

	function computeConfiguration() {

		switch gameManager.getLeagueLevel() {
			case 1:
				// Wood 2
				Config.ENABLE_TIE_BREAK = false;
				Config.ENABLE_WIND = false;
				Config.ENABLE_CONTROL = false;
				Config.ENABLE_SHIELD = false;
				Config.ENABLE_FOG = false;
			case 2:
				// Wood 1
				Config.ENABLE_WIND = true;
				Config.ENABLE_CONTROL = false;
				Config.ENABLE_SHIELD = false;
				Config.ENABLE_FOG = true;
		}
	}

	function abort() {
		gameManager.endGame();
	}

	function snapToGameZone( v:Vector ) {
		var snapX = v.x;
		var snapY = v.y;

		if ( snapX < 0 ) snapX = 0;
		if ( snapX >= Config.MAP_WIDTH ) snapX = Config.MAP_WIDTH - 1;
		if ( snapY < 0) snapY = 0;
		if ( snapY >= Config.MAP_HEIGHT ) snapY = Config.MAP_HEIGHT - 1;
		
		return new Vector( snapX, snapY );
	};
	
   /**
	 * Computes the intersection between two segments.
	 *
	 * @param x1
	 *            Starting point of Segment 1
	 * @param y1
	 *            Starting point of Segment 1
	 * @param x2
	 *            Ending point of Segment 1
	 * @param y2
	 *            Ending point of Segment 1
	 * @param x3
	 *            Starting point of Segment 2
	 * @param y3
	 *            Starting point of Segment 2
	 * @param x4
	 *            Ending point of Segment 2
	 * @param y4
	 *            Ending point of Segment 2
	 * @return Vector where the segments intersect, or null if they don't
	 */
	function intersectionCoord( x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, x4:Float, y4:Float ) {
		final d = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
		if( d == 0 ) return null;

		final xi = ((x3 - x4) * (x1 * y2 - y1 * x2) - (x1 - x2) * (x3 * y4 - y3 * x4)) / d;
		final yi = ((y3 - y4) * (x1 * y2 - y1 * x2) - (y1 - y2) * (x3 * y4 - y3 * x4)) / d;

		final p = new Vector( xi, yi );
		if (xi < Math.min(x1, x2) || xi > Math.max(x1, x2)) return null;
		if (xi < Math.min(x3, x4) || xi > Math.max(x3, x4)) return null;
		return p;
	}

	function intersectionVec( a:Vector, b:Vector, a2:Vector, b2:Vector ) {
		return intersectionCoord(
			a.x, a.y, b.x, b.y,
			a2.x, a2.y, b2.x, b2.y
		);
	}

	function gameTurn( turn:Int ) {
		resetGameTurnData();
		
		// Give input to players
		for( i in 0...gameManager.players.length ) {
			final player = gameManager.players[i];
			final agent = agents[i];
			sendGameStateFor( player );
			
			agent.setInputs( player.getInputs());
			player.setOutputs( agent.process().split( "\n" ));
		}
		// Get output from players
		handlePlayerCommands();

		performGameUpdate( turn );
		
		sendCurrentFrameData();

		for( player in gameManager.players ) {
			if( player.baseHealth == 0 ) {
				player.deactivate( "Base destroyed!" );
			}
		}

		if( gameManager.getActivePlayers().length < 2 ) abort();

		// if( repeats == 1 ) {
		// 	final char = Sys.getChar( false );
		// 	trace( char );
		// 	if( char == 27 || char == 3 ) Sys.exit( 0 );
		// }
	}

	function performGameUpdate( turn:Int ) {
		doControl();
		doShield();
		moveHeros();
		final manaGain = performCombat();
		doPush();
		moveMobs();
		shieldDecay();
		spawnNewMobs( turn );
		for( player => amount in manaGain ) player.gainMana( amount );
	}

	function shieldDecay() {
		for( e in allEntities()) if( e.shieldDuration > 0 ) e.shieldDuration--;
	}

	function doPush() {
		final directionMap:Map<GameEntity, Array<Vector>> = [];

		for( hero in intentMap[WIND] ) {
			try {
				if( hero.owner.mana < Config.SPELL_WIND_COST ) throw new ActionException( "Not enough mana" );

				hero.owner.spendMana( Config.SPELL_WIND_COST );
				final push = hero.intent;
				recordSpellUse( hero );

				final enemies = getAllEnemyUnitsAround( hero, Config.SPELL_WIND_RADIUS )
					.filter( enemy -> !enemy.hadActiveShield());
				
				final dir = Vector.fromVectors( hero.position, push.destination ).normalize().mult( Config.SPELL_WIND_DISTANCE );

				for( enemy in enemies ) {
					if( !directionMap.exists( enemy )) directionMap.set( enemy, [] );
					directionMap[enemy].push( dir );
				}
			} catch ( e:ActionException ) {
				gameManager.addToGameSummary( hero.owner.name + " failed a WIND: " + e.message );
			}
		}
		
		positionKeyMap.clear();

		//Calculate sum of pushes
		for( entity => directions in directionMap ) {
			final sum = directions.fold(( v, sum ) -> sum.add( v ), new Vector( 0, 0 ));
			var predictedPosition = entity.position.add( sum ).symmetricTruncate( symmetryOrigin );

			final baseWallIntersection = baseWallIntersection( entity.position, predictedPosition );
			if( entity.type == TYPE_MY_HERO || entity.type == TYPE_ENEMY_HERO || baseWallIntersection != null ) {
				predictedPosition = snapToGameZone( baseWallIntersection == null ? predictedPosition : baseWallIntersection );
			} else if( entity.type == TYPE_MOB && isInBaseAttractionZone( entity.position ) && !isInBaseAttractionZone( predictedPosition )) {
				final pair = new Map<Vector, Bool>();
				pair.set( predictedPosition, true );
				pair.set( predictedPosition.symmetric( symmetryOrigin ), true );

				var randomDouble:Float;
				final existingRandom = positionKeyMap[pair];

				if( existingRandom == null ) {
					randomDouble = MTRandom.quickRand();
					positionKeyMap.set( pair, randomDouble );
				}
				else randomDouble = existingRandom;

				var randomDirection = randomDouble * Math.PI * 2;
				if( existingRandom != null ) randomDirection += Math.PI;

				cast( entity, Mob ).velocity = Vector.fromAngle( randomDirection ).normalize().mult( Config.MOB_MOVE_SPEED );
			}

			entity.pushTo( predictedPosition );
		}
	}

	function recordSpellUse( hero:Hero ) {
		final push = hero.intent;
		final su:SpellUse = {
			hero: hero.id,
			spell: push.type.getName(),
			target: push.target,
			destination: push.destination == null ? null : new Coord( int( push.destination.x ), int( push.destination.y ))
		}
		spellUses.push( su );
	}

	function baseWallIntersection( from:Vector, to:Vector ) {
		final w = Config.MAP_WIDTH - 1;
		final h = Config.MAP_HEIGHT - 1;
		final baseRadius = Config.BASE_ATTRACTION_RADIUS;
		var intersection:Vector = null;
		if( to.y >= h ) intersection = intersectionCoord( from.x, from.y, to.x, to.y, w - baseRadius, h, w, h );
		else if( to.y < 0 ) intersection = intersectionCoord(from.x, from.y, to.x, to.y, 0, 0, baseRadius, 0);

		if( intersection == null ) {
			if( to.x >= w ) intersection = intersectionCoord(from.x, from.y, to.x, to.y, w, h - baseRadius, w, h);
			else if( to.x < 0 ) intersection = intersectionCoord(from.x, from.y, to.x, to.y, 0, 0, 0, baseRadius);
		}
		return intersection != null ? intersection.symmetricTruncate( symmetryOrigin ) : null;
	}

	function isInBaseAttractionZone( v:Vector ) {
		for( basePosition in basePositions ) if( v.inRange( basePosition, Config.BASE_ATTRACTION_RADIUS )) return true;
		return false;
	}

	function doShield() {
		// A protective bubble will appear around target on next turn
		for( hero in intentMap[SHIELD] ) {
			final control = hero.intent;
			try {
				if( hero.owner.mana < Config.SPELL_PROTECT_COST ) {
					throw new ActionException( "Not enough mana" );
				}
				final targeted = allEntities().filter( other -> other.id == control.target )[0];

				if( targeted == null ) throw new ActionException("Could not find entity " + control.target );
				final entity = targeted;
				
				if( heroCanSee( hero, entity )) {
					
					hero.owner.spendMana( Config.SPELL_PROTECT_COST );
					recordSpellUse( hero );
					
					if( !entity.hasActiveShield() ) entity.applyShield();
					else throw new ActionException("Entity " + entity.id + " already has a shield up");
					
				} else {
					if( playerCanSee( hero.owner, entity )) throw new ActionException( "Entity " + entity.id + " is not within range of Hero " + hero.id );
					else throw new ActionException( "Hero " + hero.id + " doesn't know where entity " + entity.id + " is" );
				}
			} catch ( e:ActionException ) {
				gameManager.addToGameSummary( hero.owner.name + " failed a SHIELD: " + e.message );
			}
		}
	}
	
	function doControl() {
		// Incept next action into victim's mind
		for( hero in intentMap[CONTROL] ) {
			final control = hero.intent;
			
			try {
				if( hero.owner.mana < Config.SPELL_PROTECT_COST ) throw new ActionException( "Not enough mana" );
				
				final targeted = allEntities().filter( other -> other.id == control.target )[0];
				
				if( targeted == null ) throw new ActionException("Could not find entity " + control.target );
				final victim = targeted;

				if( heroCanSee( hero, victim )) {
					
					hero.owner.spendMana( Config.SPELL_CONTROL_COST );
					recordSpellUse( hero );

					if( !victim.hasActiveShield() ) victim.applyShield();
					else throw new ActionException("Entity " + victim.id + " already has a shield up");
	
				} else {
					
					if( playerCanSee( hero.owner, victim )) throw new ActionException( "Entity " + victim.id + " is not within range of Hero " + hero.id );
					else throw new ActionException( "Hero " + hero.id + " doesn't know where entity " + victim.id + " is" );
				}
				
			} catch ( e:ActionException ) {
				gameManager.addToGameSummary( hero.owner.name + " failed a CONTROL: " + e.message );
				
			}
		}
	}

	function heroCanSee( hero:Hero, entity:GameEntity ) {
		if( Config.ENABLE_FOG ) return hero.position.inRange( entity.position, Config.HERO_VIEW_RADIUS );
		return true;
	}

	function playerCanSee( player:Player, entity:GameEntity ) {
		if( !insideVisibleMap( entity.position )) return false;
		if( entity.getOwner() == player ) return true;
		if( entity.position.inRange( basePositions[player.index], Config.BASE_VIEW_RADIUS)) return true;
		for( hero in player.heros ) if( heroCanSee( hero, entity )) return true;

		return false;
	}

	function spawnNewMobs( turn:Int ) {
		final newMobs = mobSpawner.update( turn );
		for( mob in newMobs ) allMobs.push( mob );
		for( mob in newMobs ) newEntities.push( mob );
	}

	function moveMobs() {
		for( mob in allMobs ) {
			if( !insideMap( mob.position )) {
				removeMob( mob );
				continue;
			}

			if( !mob.moveCancelled() ) {
				if( !mob.activeControls.isEmpty()) {
					var computedDestination = computeControlResult( mob, Config.MOB_MOVE_SPEED );
					final newVelocity = Vector.fromVectors( mob.position, computedDestination );
					
					final baseWallIntersectionResult = baseWallIntersection( mob.position, computedDestination );
					computedDestination = snapToGameZone( baseWallIntersectionResult == null ? computedDestination : baseWallIntersectionResult );

					mob.position = computedDestination.symmetricTruncate( symmetryOrigin );
					if( !newVelocity.isZero()) mob.velocity = newVelocity.normalize().mult( Config.MOB_MOVE_SPEED ).truncate();
				} else {
					mob.position = mob.position.add( mob.velocity ).symmetricTruncate( symmetryOrigin );
				}
			}

			for( idx in 0...basePositions.length ) {
				final base = basePositions[idx];
				if( mob.position.inRange( base, Config.BASE_RADIUS ) && mob.health > 0 ) {
					removeMob( mob );
					final p = gameManager.getPlayer( idx );
					p.damageBase();
					if( p.baseHealth > 0 ) gameManager.addTooltip( p, "Base attacked!" );

					final a:BaseAttack = {
						player: idx,
						mob: mob.id
					}
					baseAttacks.push( a );
					continue;
				}

				if( mobCanDetectBase( mob, base )) {
					final v = Vector.fromVectors( mob.position, base );
					final distanceToStep = int( Math.min( v.length(), Config.MOB_MOVE_SPEED ));
					mob.velocity = base.sub( mob.position ).normalize().mult( distanceToStep ).truncate();
					gameManager.getPlayer( idx ).spottet.set( mob.id, true );
				
				} else if( mob.position.inRange(base, Config.BASE_ATTRACTION_RADIUS )) {
					var objective = new Vector( 1, 1 );
					if( mob.position.x < 0 || mob.position.y < 0 ) objective = objective.mult( -1 );
					mob.velocity = objective.normalize().mult( Config.MOB_MOVE_SPEED ).truncate();
				}
			}
		}
	}

	function removeMob( mob:Mob ) mobRemovals.push( mob );

	function performCombat() {
		final manaGain:Map<Player, Array<Int>> = [];
		if( allMobs.length == 0 ) return manaGain;
		
		final killedMobs:Map<Mob, Bool> = [];

		//Deal hero damage to mobs
		for( hero in allHeros ) {
			final mobs = getMobsAround( hero, Config.HERO_ATTACK_RANGE, allMobs );
			final mobsHit = new List<Int>();
			final isOutsideBaseRadius = !hero.position.inRange( basePositions[hero.owner.index], Config.BASE_ATTRACTION_RADIUS );

			for( mob in mobs ) {
				mob.hit( Config.HERO_ATTACK_DAMAGE );

				manaGain.compute( hero.owner, ( k, v ) -> {
					if( v == null ){
						return [Config.HERO_ATTACK_DAMAGE, isOutsideBaseRadius ? Config.HERO_ATTACK_DAMAGE : 0];
					} else {
						v[0] += Config.HERO_ATTACK_DAMAGE;
						v[1] += isOutsideBaseRadius ? Config.HERO_ATTACK_DAMAGE : 0;
					}
					return v;
				});

				if( !mob.isAlive() ) killedMobs.set( mob, true );
				mobsHit.add( mob.id );
			}

			if( mobsHit.length > 0 ) {
				final a:Attack = {
					hero: hero.id,
					mobs: mobsHit
				}
			}
		}

		for( mob in killedMobs.keys()) removeMob( mob );

		return manaGain;
	}

	function moveHeros() {
		//Handle hero MOVES
		for( hero in intentMap[MOVE] ) {
			final move = hero.intent;
			hero.position = snapToGameZone( move.destination );
		}
	}

	function handlePlayerCommands() {
		for( player in gameManager.getActivePlayers() ) {
			try {
				handleCommands( player, player.getOutputs());
			} catch( e:Dynamic ) {
				player.deactivate( "Timeout" );
				gameManager.addToGameSummary( player.name + " has not provided " + player.getExpectedOutputLines() + " lines in time" );
			}
		}
	}
		
	/**
	 * Called before player outputs are handled
	 */
	 function resetGameTurnData() {
		// Reset intentions
		for( h in allHeros ) {
			h.intent = Action.IDLE;
			h.message = "";
		}
		for( a in intentMap ) {
			a.splice( 0, a.length );
		}

		// Remove dead mobs
		for( mob in mobRemovals ) {
			allMobs.remove( mob );
		}
		mobRemovals.splice( 0, mobRemovals.length );

		// Reset mobs
		for( mob in allMobs ) mob.reset();

		// Reset view info
		newEntities.splice( 0, newEntities.length );
		attacks.splice( 0, attacks.length );
		spellUses.splice( 0, spellUses.length );
		baseAttacks.splice( 0, baseAttacks.length );
	}

	function getAllEnemyUnitsAround( hero:Hero, range:Int ) {
		return getAllAround( hero, range, allEntities().filter( e -> e.getOwner() != hero.owner ));
	}

	function getAllAround( entity:GameEntity, range:Int, entities:Array<GameEntity >) {
		return entities.filter( other -> other.position.inRange( entity.position, range ));
	}

	function getMobsAround( entity:GameEntity, range:Int, mobs:Array<Mob>) {
		return mobs.filter( other -> other.position.inRange( entity.position, range ));
	}

	function mobCanDetectBase( mob:Mob, base:Vector ) {
		return insideVisibleMap( mob.position ) && mob.position.inRange( base, Config.BASE_ATTRACTION_RADIUS );
	}

	static final PLAYER_WAIT_PATTERN = new EReg(
		"^WAIT"
		+ "\\s*(.+)?"
		+ "\\s*$", ""
	);
	
	static final PLAYER_MOVE_PATTERN = new EReg(
		"^MOVE\\s+(\\d+)\\s+(\\d+)"
		+ "\\s*(.+)?"
		+ "\\s*$", ""
	);

	static final PLAYER_WIND_PATTERN = new EReg(
		"^SPELL\\s+"
		+ "WIND\\s+(\\d+)\\s+(\\d+)"
		+ "\\s*(.+)?"
		+ "\\s*$", ""
	);
	
	static final PLAYER_SHIELD_PATTERN = new EReg(
		"^SPELL\\s+"
		+ "SHIELD\\s+(\\d+)"
		+ "\\s*(.+)?"
		+ "\\s*$", ""
	);
	static final PLAYER_CONTROL_PATTERN = new EReg(
		"^SPELL\\s+"
		+ "CONTROL\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)"
		+ "\\s*(.+)?"
		+ "\\s*$", ""
	);

	static final EXPECTED = Config.ENABLE_WIND || Config.ENABLE_CONTROL || Config.ENABLE_WIND
		? "MOVE <x> <y> | SPELL <spell_command> | WAIT"
		: "MOVE <x> <y> | WAIT";
	
	function handleCommands( player:Player, lines:Array<String> ) {
		var i = 0;
		for( line in lines ) {
			final hero = player.heros[i++];
			if( !hero.activeControls.isEmpty()) {
				final computedDestination = computeControlResult( hero, Config.HERO_MOVE_SPEED );

				final intent = new Action( MOVE );
				intent.forced = true;
				intent.destination = computedDestination.symmetricTruncate( symmetryOrigin );
				hero.activeControls.clear();
				recordIntention( hero, intent );
				hero.message = "";
				continue;
			}
			try {
				// Message
				if( PLAYER_WAIT_PATTERN.match( line )) {
					final message = PLAYER_WAIT_PATTERN.matched( 1 );
					if( message != null ) matchMessage( hero, message );
					continue;
				}
				
				if( PLAYER_MOVE_PATTERN.match( line )) {
					final x = parseInt( PLAYER_MOVE_PATTERN.matched( 1 ));
					final y = parseInt( PLAYER_MOVE_PATTERN.matched( 2 ));
					if( hero.position.x != x || hero.position.y != y ) {
						final intent = new Action( MOVE );
						final speed = Config.HERO_MOVE_SPEED;
						final target = stepTo( hero.position, new Vector( x, y ), speed );
                        
						// Don't use doubles for internal positions else players won't be able to determine state N+1 from state N.
						intent.destination = target.symmetricTruncate( symmetryOrigin );
						recordIntention( hero, intent );
					}
					final message = PLAYER_MOVE_PATTERN.matched( 3 );
					if( message != null ) matchMessage( hero, message );
					continue;
				}

				if( Config.ENABLE_WIND ) {
					if( PLAYER_WIND_PATTERN.match( line )) {
						final x = parseInt( PLAYER_WIND_PATTERN.matched( 1 ));
						final y = parseInt( PLAYER_WIND_PATTERN.matched( 2 ));
						final intent = new Action( WIND );
						intent.destination = new Vector( x, y );
						recordIntention( hero, intent );
						//Message
						final message = PLAYER_WIND_PATTERN.matched( 3 );
						if( message != null ) matchMessage( hero, message );
						continue;
					}
				}

				if( Config.ENABLE_SHIELD ) {
					if( PLAYER_SHIELD_PATTERN.match( line )) {
						final entityId = parseInt( PLAYER_SHIELD_PATTERN.matched( 1 ));
						final intent = new Action( SHIELD );
						intent.target = entityId;
						recordIntention( hero, intent );
						//Message
						final message = PLAYER_SHIELD_PATTERN.matched( 2 );
						if( message != null ) matchMessage( hero, message );
						continue;
					}
				}
				
				if( Config.ENABLE_CONTROL ) {
					if( PLAYER_CONTROL_PATTERN.match( line )) {
						final entityId = parseInt( PLAYER_CONTROL_PATTERN.matched( 1 ));
						final x = parseInt( PLAYER_CONTROL_PATTERN.matched( 2 ));
						final y = parseInt( PLAYER_CONTROL_PATTERN.matched( 3 ));
						final intent = new Action( CONTROL );
						intent.target = entityId;
						intent.destination = new Vector( x, y );
						recordIntention( hero, intent );
						//Message
						final message = PLAYER_CONTROL_PATTERN.matched( 4 );
						if( message != null ) matchMessage( hero, message );
						continue;
					}
				}

				throw new InvalidInputException( EXPECTED, line );
			
			} catch( e:InvalidInputException ) {
				player.deactivate( e.message );
				gameManager.addToGameSummary( "Bad command" );
				return;
			
			} catch( e:Exception ) {
                player.deactivate( new InvalidInputException( EXPECTED, line ).message );
                gameManager.addToGameSummary("Bad command");
                return;
			}
		}
	}

	function computeControlResult( e:GameEntity, moveSpeed:Int ) {
		return e.activeControls.map( v -> stepTo( e.position, v, moveSpeed ))
		.fold(( v, sum ) -> sum.add( v ), new Vector( 0, 0 ))
		.mult( 1.0 / e.activeControls.length );
	}

	function matchMessage( hero:Hero, message:String ) {
		// String characterFilter = "[^\\p{L}\\p{M}\\p{N}\\p{P}\\p{Z}\\p{Cf}\\p{Cs}\\s]";
		// String messageWithoutEmojis = message.replaceAll(characterFilter, "");
		hero.message = message;
	}

	function stepTo( position:Vector, destination:Vector, speed:Int ) {
		final v = Vector.fromVectors( position, destination );
		final target = v.lengthSquared() <= speed * speed ? v : v.normalize().mult( speed );
		return position.add( target );
	}

	function recordIntention( hero:Hero, intent:Action ) {
		hero.intent = intent;
		intentMap.compute( intent.type, ( key, value ) -> {
			if( value == null ) value = new Array<Hero>();
			value.push( hero );
			return value;
		});
	}

	function sendGameStateFor( player:Player ) {
		final entityLines:Array<String> = [];

		final visibleHerosForPlayer = allHeros.filter( hero -> playerCanSee( player, hero ));
		for( hero in visibleHerosForPlayer ) {
			entityLines.push( '${hero.id} ${hero.type == player.index ? INPUT_TYPE_MY_HERO : INPUT_TYPE_ENEMY_HERO} ${hero.position} ${hero.shieldDuration} ${hero.isControlled() ? 1 : 0} -1 -1 -1 -1 -1' );
		}

		final visibleMobsForPlayer = allMobs.filter( mob -> playerCanSee( player, mob ));
		for( mob in visibleMobsForPlayer ) {
			mob.status = getMobStatus( mob );
			entityLines.push( '${mob.id} $INPUT_TYPE_MOB ${mob.position} ${mob.shieldDuration} ${mob.isControlled() ? 1 : 0} ${mob.health} ${mob.velocity} ${mob.status.toStringFor( player )}' );
		}

		// <health> <mana>
		player.sendInputLine( '${player.baseHealth} ${player.mana}' );
		final otherPlayers = gameManager.players.filter( p -> p != player );
		for( p in otherPlayers ) player.sendInputLine( '${p.baseHealth} ${p.mana}' );

		// <entityCount>
		player.sendInputLine( '${entityLines.length}' );
		for( line in entityLines ) {
            //Mobs
            // <id> <type> <x> <y> <shieldLife> <isControlled> <health> <vx> <vy> <state> <target>
            //Heroes
            // <id> <type> <x> <y> <shieldLife> <isControlled> -1 -1 -1 -1 -1
			player.sendInputLine( line );
		}
	}
 
	function getMobStatus( mob:Mob ) {
		if( mob.status == null || !mob.activeControls.isEmpty()) {
			var mobVelocity:Vector;

			if( mob.activeControls.isEmpty()) mobVelocity = mob.velocity;
			else {
				final computedDestination = computeControlResult( mob, Config.MOB_MOVE_SPEED );
				final newVelocity = Vector.fromVectors( mob.position, computedDestination );
				mobVelocity = newVelocity;
			}
			
			if( mobVelocity.isZero()) return new MobStatus( MobStatus.WANDERING, null, 0 );
			else {
				var mobPos = mob.position;
				var turns = 0;
				while( turns < 8000 ) {
					// Am I inside an attraction zone?
					for( idx in 0...basePositions.length ) {
						final base = basePositions[idx];
						if( mobPos.inRange( base, Config.BASE_ATTRACTION_RADIUS )) {
							return new MobStatus( turns == 0 ? MobStatus.ATTACKING : MobStatus.WANDERING, gameManager.getPlayer( idx ), turns );
						}
					}
					// Am I outside the map?
					if( !insideMap( mobPos )) {
						return new MobStatus( MobStatus.WANDERING, null, turns );
					}
					turns++;
					mobPos = mobPos.add( mobVelocity ).symmetricTruncate( symmetryOrigin );
				}
				return new MobStatus( MobStatus.WANDERING, null, 0 );
			}
		}
		
		return mob.status;
	}

	function insideMap( p:Vector ) {
		return p.withinBounds(
			-Config.MAP_LIMIT, -Config.MAP_LIMIT,
			Config.MAP_WIDTH + Config.MAP_LIMIT, Config.MAP_HEIGHT + Config.MAP_LIMIT
		);
	}

	function insideVisibleMap( p:Vector ) {
		return p.withinBounds( 0, 0, Config.MAP_WIDTH, Config.MAP_HEIGHT );
	}

	function onEnd() {
		var tie = false;
		if( gameManager.players.length == 2 ) {
			final a = gameManager.getPlayer( 0 );
			final b = gameManager.getPlayer( 1 );
			if( a.isActive && !b.isActive ) {
				a.score = 1;
				b.score = 0;
			} else if( !a.isActive && b.isActive ) {
				a.score = 0;
				b.score = 1;
			} else if( a.baseHealth != b.baseHealth || !Config.ENABLE_TIE_BREAK ) {
				a.score = a.baseHealth;
				b.score = b.baseHealth;
			} else {
				// Tie breaker
				tie = true;
				a.score = a.manaGainedOutsideOfBase;
				b.score = b.manaGainedOutsideOfBase;
				if( a.manaGainedOutsideOfBase == b.manaGainedOutsideOfBase ) gameManager.addToGameSummary( "Tie!" );
				else {
					final winner = a.manaGainedOutsideOfBase > b.manaGainedOutsideOfBase ? a : b;
					gameManager.addToGameSummary( '${winner.name}  won the game because their heroes gained more mana outside of their base:' );
					gameManager.addToGameSummary( '${a.name}: ${a.manaGainedOutsideOfBase} mana' );
					gameManager.addToGameSummary( '${b.name}: ${b.manaGainedOutsideOfBase} mana' );
				}
			}
		} else {
			for( p in gameManager.players ) p.score = p.baseHealth;
		}
		// endScreenModule.scores = gameManager.players.map( player -> player.score );
	}

	function asViewData( entity:GameEntity ) {
		final res:EntityData = {
			type: entity.type,
			id: entity.id,
			health: entity.type == TYPE_MOB ? cast( entity, Mob ).health : 0
		}
		return res;
	}

	function asCoord( entity:GameEntity ) {
		return new Coord( int( entity.position.x ), int( entity.position.y ));
	}
	
	function sendCurrentFrameData() {
		final positions = [for( entity in allEntities() ) entity.id => asCoord( entity )];
		final messages = [for( h in allHeros ) if( h.message != "" ) h.id => h.message];
		final controlled = allEntities().filter( e -> e.isControlled() ).map( e -> e.id );
		final pushed = allEntities().filter( e -> e.gotPushed() ).map( e -> e.id );
		final shielded = allEntities().filter( e -> e.hadActiveShield() ).map( e -> e.id );
		
		final mana = gameManager.players.map( player -> player.mana );
		final baseHealth = gameManager.players.map( player -> player.baseHealth );
		final mobHealth = [for( mob in allMobs ) mob.id => mob.health];
		
		final spawns = newEntities.map( entity -> asViewData( entity ));

		final dataset:FrameViewData = {
			positions: positions,
			messages: messages,
			controlled: controlled,
			pushed: pushed,
			shielded: shielded,

			mana: mana,
			baseHealth: baseHealth,
			mobHealth: mobHealth,

			spawns: spawns,
			attacks: attacks,
			baseAttacks: baseAttacks,
			spellUses: spellUses
		}
		frameDatasetTrigger.trigger( dataset );
	}

	function getGlobalData() {
		
	}

}
