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

class Agent {
	
	var me:Player;
	var opp:Player;
	public var players:Array<Player>;
	public var mobs:Array<Mob> = [];

	final actions = [];
	
	var turn = -1;
	var agentId = "";

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
		mobs.splice( 0, mobs.length );
		
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
					mobs.push( mob );
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
	}
	
	public function process() {
		for( i in 0...me.heros.length ) actions[i] = 'WAIT';
		return actions.join( "\n" );
	}

	function control( hero:Int, unitId:Int, position:Vector, message = "" ) {
		actions[hero] = 'SPELL CONTROL $unitId $position' + ( message == "" ? message : ' $message' );
	}
	
	function move( hero:Int, position:Vector, message = "" ) {
		actions[hero] = 'MOVE $position' + ( message == "" ? message : ' $message' );
	}

	function push( hero:Int, position:Vector, message = "" ) {
		actions[hero] = 'SPELL WIND $position' + ( message == "" ? message : ' $message' );
	}
	
	function shield( hero:Int, unitId:Int, message = "" ) {
		actions[hero] = 'SPELL SHIELD $unitId' + ( message == "" ? message : ' $message' );
	}

	function wait( hero:Int, message = "" ) {
		actions[hero] = 'WAIT' + ( message == "" ? message : ' $message' );
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

	function getMobsInDistance( hero:Hero, mobs:Array<Mob>, distance:Int ) {
		final mobsInDistance:Array<GameEntity> = [];
		for( mob in mobs ) if( hero.position.distance( mob.position ) < distance ) mobsInDistance.push( mob );
		return mobsInDistance;
	}


	function printActions() {
		for( i in 0...3 ) {
			if( actions[i] == null ) throw 'Error in frame $turn: action $i is null';
		}
		return actions.join( "\n" );
	}
}
