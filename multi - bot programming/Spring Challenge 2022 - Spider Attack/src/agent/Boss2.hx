package agent;

import Std.int;
import game.Config;
import game.Mob;

class Boss2 extends Agent {

	var postX:Array<Int>;
	var postY:Array<Int>;

	public function new() {
		super();
		agentId = "Boss 2";
	}
	
	override function init( inputLines:Array<String> ) {
		super.init( inputLines );

		final baseX = int( me.basePosition.x );
		final baseY = int( me.basePosition.y );

		postX = baseX == 0 ? [3000, 7000, 5500] : [baseX - 3000, baseX - 7000, baseX - 5500];
		postY = baseY == 0 ? [6500, 1500, 4000] : [baseY - 6500, baseY - 1500, baseY - 4000];
	}

	override function process():String {
		var closestEnemyToBase:Mob = null;
		var minDistToBase:Float = Config.MAP_WIDTH + Config.MAP_HEIGHT;
		for( mob in mobs ) {
			final curDist = mob.position.distance( me.basePosition );
			if( curDist < minDistToBase ) {
				minDistToBase = curDist;
				closestEnemyToBase = mob;
			}
		}

		final nbHerosRoaming = 2;
		
		var windMana = 0;
		for( i in 0...nbHerosRoaming ) {
			final hero = me.heros[i];

			var target:Mob = null;
			var minDist:Float = Config.MAP_WIDTH + Config.MAP_HEIGHT;
			for( mob in mobs ) {
				if( mob == closestEnemyToBase ) continue;
				final curDist = mob.position.distance( hero.position );
				if( curDist < minDist ) {
					minDist = curDist;
					target = mob;
				}
			}
			if( target == null ) actions[i] = 'MOVE ${postX[i]} ${postY[i]}';
			else {
				if( me.mana - windMana >= Config.SPELL_WIND_COST && hero.position.distance( target.position ) < Config.SPELL_WIND_RADIUS ) {
					actions[i] = 'SPELL WIND ${Config.MAP_WIDTH - me.basePosition.x} ${Config.MAP_HEIGHT - me.basePosition.y}';
					windMana += Config.SPELL_WIND_COST;
				} else {
					actions[i] = 'MOVE ${target.position}';
				}
			}
		}

		for( i in nbHerosRoaming...me.heros.length ) {
			final hero = me.heros[i];
			final target = closestEnemyToBase;

			if( target == null || minDistToBase > 5000 ) {
				actions[i] = "WAIT";
			} else {
				if( me.mana - windMana >= Config.SPELL_WIND_COST && hero.position.distance( target.position ) < Config.SPELL_WIND_RADIUS ) {
					actions[i] = 'SPELL WIND ${Config.MAP_WIDTH - me.basePosition.x} ${Config.MAP_HEIGHT - me.basePosition.y}';
					windMana += Config.SPELL_WIND_COST;
				} else {
					actions[i] = 'MOVE ${target.position}';
				}
			}
		}
		// trace( '${me.name}\n' + actions.join( "\n" ));
		turn++;
		
		return actions.join( "\n" );
	}
}

