package agent;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import game.Mob;
import game.Player;
import game.Vector;

using Lambda;

class Agent {
	
	static final HEROS_PER_PLAYER = 3;

	final me:Player;
	final opp:Player;
	final players:Array<Player>;
	final mobSwarm:MobSwarm;
	
	final typeStartIds = [HEROS_PER_PLAYER * 2, 0, HEROS_PER_PLAYER];
	final actions = [];
	
	public function new( me:Player, opp:Player, mobSwarm:MobSwarm ) {
		this.me = me;
		this.opp = opp;
		players = [me, opp];
		this.mobSwarm = mobSwarm;
	}

	public function giveInputs( inputLines:Array<String> ) {
		var line = 0;
		for( i in 0...players.length ) { //two integers baseHealth and mana for the remaining health and mana for both players
			var inputs = inputLines[line++].split(' ');
			players[i].baseHealth = parseInt( inputs[0] ); // Your base health
			players[i].mana = parseInt( inputs[1] ); // Spend ten mana to cast a spell
		}
		final entityCount = parseInt( inputLines[line++] ); // Amount of heros and monsters you can see
		for( _ in 0...entityCount ) {
			var inputs = inputLines[line].split(' ');
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
				case 0: // Mob
					if( !mobSwarm.mobsMap.exists( entityIndex )) mobSwarm.mobsMap.set( entityIndex, new Mob( new Vector( x, y ), id ));
					final mob = mobSwarm.mobsMap[entityIndex];
					mob.shieldDuration = shieldLife;
					mob.isUnderControlSpell = isControlled;
					mob.health = health;
					mob.speed.x = vx;
					mob.speed.y = vy;
					mob.isNearBase = isNearBase;
					mob.threatFor = threatFor;

				case 1: // my Hero
					final player = players[0];
					final hero = player.heros[entityIndex];
					hero.position.x = x;
					hero.position.y = y;
				case 2: // opponent Hero
					final player = players[1];
					final hero = player.heros[entityIndex];
					hero.position.x = x;
					hero.position.y = y;
			}
		}
	
	}

	public function process() {
		for( i in 0...me.heros.length ) actions[i] = 'WAIT';

		return actions.join( "\n" );
	}
}
