package agent;

import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import game.Config;
import game.GameEntity;
import game.Hero;
import game.Mob;
import game.Player;
import game.Vector;

using Lambda;
using xa3.MathUtils;

class Agent3 implements IAgent {
	
	var me:Player;
	var opp:Player;
	public var players:Array<Player>;
	
	var mobMap:Map<Int, Mob> = [];
	public var mobs:Array<Mob> = [];

	final actions = [];
	
	var turn = -1;
	var agentId = "";
	var spentMana = 0;

	public function new() { }
	
	public function init( inputLines:Array<String> ) {
		// trace( 'init agent $agentId\n' + inputLines.join( "\n" ) );
		final inputs = inputLines[0].split(' ');
		final myBaseX = parseInt( inputs[0] );
		final myBaseY = parseInt( inputs[1] );
		final herosPerPlayer = parseInt( inputLines[1] ); // Always 3
		
		final oppBaseX = Config.MAP_WIDTH - myBaseX;
		final oppBaseY = Config.MAP_HEIGHT - myBaseY;

		me = new Player( 0, "me", myBaseX, myBaseY );
		opp = new Player( 1, "opponent", oppBaseX, oppBaseY );
		players = [me, opp];
		
		var id = 0;
		for( player in players ) for( i in 0...herosPerPlayer ) player.addHero( new Hero( id++, i, new Vector( 0, 0 ), player, 0 ));
	}
	
	public function setInputs( inputLines:Array<String> ) {
		// trace( 'setInputs agent $agentId\n' + inputLines.join( "\n" ));
		mobMap.clear();
		
		var player0HeroIndex = 0;
		var player1HeroIndex = 0;
		var line = 0;
		for( i in 0...players.length ) { //two integers baseHealth and mana for the remaining health and mana for both players
			var inputs = inputLines[line++].split(' ');
			players[i].baseHealth = parseInt( inputs[0] ); // Your base health
			players[i].mana = parseInt( inputs[1] ); // Spend ten mana to cast a spell
		}
		final entityCount = parseInt( inputLines[line++] ); // Amount of heros and monsters you can see
		for( _ in 0...entityCount ) {
			var inputs = inputLines[line++].split(' ');
			final id = parseInt( inputs[0] ); // Unique identifier
			final type = parseInt( inputs[1] ); // 0=monster, 1=your hero, 2=opponent hero
			final x = parseInt( inputs[2] ); // Position of this entity
			final y = parseInt( inputs[3] );
			final shieldLife = parseInt( inputs[4] ); // Count down until shield spell fades
			final isControlled = inputs[5] == "1"; // Equals 1 when this entity is under a control spell
			final health = parseInt( inputs[6] ); // Remaining health of this monster
			final vx = parseInt( inputs[7] ); // Trajectory of this monster
			final vy = parseInt( inputs[8] );
			final isNearBase = inputs[9] == "1"; // 0=monster with no target yet, 1=monster targeting a base
			final threatFor = parseInt( inputs[10] ); // Given this monster's trajectory, is it a threat to 1=your base, 2=your opponent's base, 0=neither
			
			switch type {
				case 0: // Mob
					final mob = new Mob( id, new Vector( x, y ), health );
					mob.shieldDuration = shieldLife;
					mob.isUnderControlSpell = isControlled;
					mob.health = health;
					mob.velocity.x = vx;
					mob.velocity.y = vy;
					mob.isNearBase = isNearBase;
					mob.threatFor = threatFor;
					mobMap.set( id, mob );
					// if( agentId != "" ) trace( '$turn $agentId new mob $shieldLife $isControlled $health $vx $vy $isNearBase $isControlled' );
				
				case 1: // my Hero
					final player = players[0];
					final hero = player.heros[player0HeroIndex++];
					hero.position.x = x;
					hero.position.y = y;
				
				case 2: // opponent Hero
					final player = players[1];
					final hero = player.heros[player1HeroIndex++];
					hero.position.x = x;
					hero.position.y = y;
			}
		}
		
		
		for( id => mob in mobMap ) {
			// final symmetricMobId = id % 2 == 0 ? id + 1 : id - 1;
			// if( !mobMap.exists( symmetricMobId )) {
			// 	final mirrorMob = mob.createMirrorMob( symmetricMobId );
			// 	if( turn == 18 ) trace( 'copy $id to $symmetricMobId' );
			// 	mobMap.set( symmetricMobId, mirrorMob );
			// }
		}
		mobs = [for( mob in mobMap ) mob];
		if( turn == 18 ) trace( '$turn ' + [for( mob in mobMap ) '${mob.id} ${mob.position}'].join(" ") );
	}
	
	public function process() {
		for( i in 0...me.heros.length ) actions[i] = 'WAIT';
		return actions.join( "\n" );
	}
	
	function printActions() {
		// for( i in 0...3 ) {
		// 	if( actions[i] == null ) throw 'Error in frame $turn: action $i is null';
		// }
		return actions.join( "\n" );
	}

	function control( heroId:Int, unitId:Int, position:Vector, message = "" ) {
		actions[heroId] = 'SPELL CONTROL $unitId $position' + ( message == "" ? message : ' $message' );
		spentMana += Config.SPELL_CONTROL_COST;
	}
	
	function move( heroId:Int, position:Vector, message = "" ) {
		// trace( 'move $heroId $position' );
		actions[heroId] = 'MOVE $position' + ( message == "" ? message : ' $message' );
	}

	function push( heroId:Int, position:Vector, message = "" ) {
		actions[heroId] = 'SPELL WIND $position' + ( message == "" ? message : ' $message' );
		spentMana += Config.SPELL_WIND_COST;
	}
	
	function shield( heroId:Int, unitId:Int, message = "" ) {
		actions[heroId] = 'SPELL SHIELD $unitId' + ( message == "" ? message : ' $message' );
		spentMana += Config.SPELL_PROTECT_COST;
	}

	function wait( heroId:Int, message = "" ) {
		actions[heroId] = 'WAIT' + ( message == "" ? message : ' $message' );
	}

	function mirrorVectors( a:Array<Vector> ) {
		for( v in a ) mirrorVector( v );
	}
	
	function mirrorVector( v:Vector ) {
		v.x = Config.MAP_WIDTH - v.x;
		v.y = Config.MAP_HEIGHT - v.y;
	}
	
	function sortMobsByDistance( mobs:Array<Mob>, pos:Vector ) {
		mobs.sort(( a, b ) -> {
			final da = Vector.fromVectors( a.position, pos ).lengthSquared();
			final db = Vector.fromVectors( b.position, pos ).lengthSquared();
			return int( da - db );
		});
	}

	function sortHerosByDistance( heros:Array<Hero>, pos:Vector ) {
		heros.sort(( a, b ) -> {
			final da = Vector.fromVectors( a.position, pos ).lengthSquared();
			final db = Vector.fromVectors( b.position, pos ).lengthSquared();
			return int( da - db );
		});
	}

	static inline var FRAME = 29;
	
	function pairHerosWithClosestMobs( heros:Array<Hero>, mobs:Array<Mob> ) {
		final combinations = [];
		for( hero in heros ) {
			for( i in 0...mobs.length.min( 2 ) ) {
				final mob = mobs[i];
				combinations.push({ hero: hero, mob: mob, distanceSq: hero.position.distanceSq( mob.position ) });
			}
		}
		combinations.sort(( a, b ) -> int( a.distanceSq - b.distanceSq ));
		// if( turn == FRAME ) for( combination in combinations ) printErr( 'hero ${combination.hero.index}  mob ${combination.mob.id}  distanceSq ${combination.distanceSq}' );
	
		var assignedHeros = [];
		var assignedMobs = [];
		for( combination in combinations ) {
			if( assignedHeros.contains( combination.hero ) || assignedMobs.contains( combination.mob )) continue;
			assignedHeros.push( combination.hero );
			assignedMobs.push( combination.mob );
		}
		
		final pairs:Array<HeroMobPair> = [];
		for( i in 0...assignedHeros.length ) pairs.push({ hero: assignedHeros[i], mob: assignedMobs[i] });
		// for( pair in pairs ) printErr( 'hero ${pair.hero.index} mob ${pair.mob.id}' );
		return pairs;
	}
	
	function getMobsInDistance( hero:Hero, mobs:Array<Mob>, distance:Int ) {
		final mobsInDistance:Array<GameEntity> = [];
		for( mob in mobs ) if( hero.position.distance( mob.position ) < distance ) mobsInDistance.push( mob );
		return mobsInDistance;
	}

	function getNearPosition( pos1:Vector, pos2:Vector, distanceFromPos2:Float ) {
		final h2p = pos2.sub( pos1 ).normalize();
		final nearDistance = pos1.distance( pos2 ) - distanceFromPos2;
		final nearDelta = h2p.mult( nearDistance );
		return pos1.add( nearDelta );
	}
}
