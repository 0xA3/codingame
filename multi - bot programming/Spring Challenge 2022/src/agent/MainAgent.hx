package agent;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import game.Mob;
import game.Vector;

class MainAgent {

	static function main() {
		
		final inputs = [readline(), readline()];
		
		final agent = CurrentAgents.agentMe;
		agent.init( inputs );

		// game loop
		while( true ) {
			agent.mobs.splice( 0, agent.mobs.length );

			var player0HeroIndex = 0;
			var player1HeroIndex = 0;
			for( i in 0...agent.players.length ) { //two integers baseHealth and mana for the remaining health and mana for both players
				var inputs = readline().split(' ');
				agent.players[i].baseHealth = parseInt( inputs[0] ); // Your base health
				agent.players[i].mana = parseInt( inputs[1] ); // Ignore in the first league; Spend ten mana to cast a spell
			}
			final entityCount = parseInt( readline() ); // Amount of heros and monsters you can see
			for( _ in 0...entityCount ) {
				var inputs = readline().split(' ');
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
					agent.mobs.push( mob );

					case 1: // my Hero
						final player = agent.players[0];
						final hero = player.heros[player0HeroIndex++];
						hero.position.x = x;
						hero.position.y = y;
						printErr( 'hero $id position $x $y' );
					case 2: // opponent Hero
						final player = agent.players[1];
						final hero = player.heros[player1HeroIndex++];
						hero.position.x = x;
						hero.position.y = y;
				}
			}
			
			final outputs = agent.process();
			print( outputs );
		}
	}
}