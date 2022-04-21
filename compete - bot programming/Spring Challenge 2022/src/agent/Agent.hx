package agent;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.string;
import game.Cell;
import game.Config;
import game.Constants;
import game.GameMap;
import game.Monster;
import game.Player;
import haxe.Timer;
import xa3.MTRandom;

using Lambda;

class Agent {
	
	public final me:Player;
	public final opp:Player;
	
	final map:GameMap;
	final baseX:Int;
	final baseY:Int;
	final heroesPerPlayer:Int;

	final actions = [];
	/*
		Startup for submitting the agent to CodinGame
	*/
	static function main() {
		
		final inputs = readline().split(' ');
		final baseX = parseInt( inputs[0] ); // The corner of the map representing your base
		final baseY = parseInt( inputs[1] );
		final herosPerPlayer = parseInt( readline() ); // Always 3
		
		//
		// Add Agent
		//
		final map = new GameMap();
		
		final typeStartIds = [herosPerPlayer * 2, 0, herosPerPlayer];
		final players = [new Player( 1, herosPerPlayer ), new Player( 0, herosPerPlayer )];
		final agent = new Agent0( players[0], players[1], map, baseX, baseY, herosPerPlayer );
		
		var currentFrame = 0;
		// game loop
		while( true ) {
			for( i in 0...players.length ) { //two integers baseHealth and mana for the remaining health and mana for both players
				var inputs = readline().split(' ');
				players[i].health = parseInt( inputs[0] ); // Your base health
				players[i].mana = parseInt( inputs[1] ); // Ignore in the first league; Spend ten mana to cast a spell
			}
			final entityCount = parseInt( readline() ); // Amount of heros and monsters you can see
			for( i in 0...entityCount ) {
				var inputs = readline().split(' ');
				printErr( inputs.join(' '));
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
				
				final entityIndex = id - typeStartIds[type];
				switch type {
					case 0: // Monster
						if( !map.monstersMap.exists( entityIndex )) map.monstersMap.set( entityIndex, new Monster());
						final monster = map.monstersMap[entityIndex];
						monster.id = id;
						monster.x = x;
						monster.y = y;
						monster.shieldLife = shieldLife;
						monster.isControlled = isControlled;
						monster.health = health;
						monster.vx = vx;
						monster.vy = vy;
						monster.isNearBase = isNearBase;
						monster.threatFor = threatFor;
						monster.frame = currentFrame;

					case 1: // my Hero
						final player = players[0];
						final hero = player.heros[entityIndex];
						hero.x = x;
						hero.y = y;
					case 2: // opponent Hero
						final player = players[1];
						final hero = player.heros[entityIndex];
						hero.x = x;
						hero.y = y;
				}
			}
			map.filterOutDeadMonsters( currentFrame );
			
			final outputs = agent.process();
			print( outputs );
			currentFrame++;
		}
	}
	
	/*
		Startup for local referee
	*/
	public function new( me:Player, opp:Player, map:GameMap, baseX:Int, baseY:Int, heroesPerPlayer:Int ) {
		this.me = me;
		this.opp = opp;
		this.map = map;
		this.baseX = baseX;
		this.baseY = baseY;
		this.heroesPerPlayer = heroesPerPlayer;
	}

	public inline function process():String {
		for( i in 0...heroesPerPlayer ) actions[i] = takeAction( i );

		return actions.join( "\n" );
	}
	
	public function takeAction( playerNo:Int ) {
		return 'WAIT';
	}
}
