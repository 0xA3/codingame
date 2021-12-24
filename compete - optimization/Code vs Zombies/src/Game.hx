import Math.floor;
import data.FrameDataset;
import data.HumanDataset;
import data.ZombieDataset;
import xa3.MathUtils.distance;
import xa3.MathUtils.distanceSq;
import xa3.MathUtils.length;

class Game {
	static inline var ASH_RANGE = 2000;
	static inline var ASH_STEP = 1000;
	static inline var ZOMBIE_STEP = 400;
	
	public static function executeRound( ashTargetX:Int, ashTargetY:Int, frameDataset:FrameDataset ) {
		final movedZombies = [];
		for( zombie in frameDataset.zombies ) {
			final closestHuman = getClosestHuman( zombie.xNext, zombie.yNext, frameDataset.ash.x, frameDataset.ash.y, frameDataset.humans );
			final closestPositionX = closestHuman == -1 ? frameDataset.ash.x : frameDataset.humans[closestHuman].x;
			final closestPositionY = closestHuman == -1 ? frameDataset.ash.y : frameDataset.humans[closestHuman].y;
			
			final dx = closestPositionX - zombie.xNext;
			final dy = closestPositionY - zombie.yNext;
			final scaleFactor = getScaleFactor( dx, dy, ZOMBIE_STEP );

			final xNext = move( zombie.xNext, dx, scaleFactor );
			final yNext = move( zombie.yNext, dy, scaleFactor );
			
			// final positionNext = move( zombie.xNext, zombie.yNext, closestPositionX, closestPositionY, ZOMBIE_STEP );
			final movedZombie:ZombieDataset = {
				id: zombie.id,
				isExisting: zombie.isExisting,
				x: zombie.xNext,
				y: zombie.yNext,
				xNext: xNext,
				yNext: yNext
			}
			movedZombies[zombie.id] = movedZombie;
		}
		
		final dx = ashTargetX - frameDataset.ash.x;
		final dy = ashTargetY - frameDataset.ash.y;
		final scaleFactor = getScaleFactor( dx, dy, ASH_STEP );

		final ashX = move( frameDataset.ash.x, dx, scaleFactor );
		final ashY = move( frameDataset.ash.y, dy, scaleFactor );
		// final ashPosition = move( frameDataset.ash.x, frameDataset.ash.y, ashTargetX, ashTargetY, ASH_STEP );
		
		final deadAliveZombies = [];
		for( zombie in movedZombies ) {
			deadAliveZombies[zombie.id] = killZombieIfInRange( ashX, ashY, zombie );
		}
		
		final deadAliveHumans = [];
		for( human in frameDataset.humans ) deadAliveHumans[human.id] = killHumanIfInRange( human, deadAliveZombies );

		final nextFrame:FrameDataset = {
			ash: { x: ashX, y: ashY },
			humans: deadAliveHumans,
			zombies: deadAliveZombies
		}

		return nextFrame;
	}

	static function getClosestHuman( x:Int, y:Int, ashX:Int, ashY:Int, humans:Array<HumanDataset> ) {
		var minDistanceSq = distanceSq( x, y, ashX, ashY );
		var closestHuman = -1;
		for( i in 0...humans.length ) {
			final human = humans[i];
			if( human.isAlive )	{
				final humanDistanceSq = distanceSq( x, y, human.x, human.y );
				if( humanDistanceSq < minDistanceSq ) {
					minDistanceSq = humanDistanceSq;
					closestHuman = i;
				}
			}
		}
		return closestHuman;		
	}

	public static function killZombieIfInRange( ashX:Int, ashY:Int, zombieDataset:ZombieDataset ) {
		if( !zombieDataset.isExisting ) return zombieDataset;
		
		final distanceZombie = distance( ashX, ashY, zombieDataset.x, zombieDataset.y );
		
		final zombieIsExisting = distanceZombie > ASH_RANGE;
		if( !zombieIsExisting ) trace( 'ash kills zombie ${zombieDataset.id}' );
		
		final zombie:ZombieDataset = {
			id: zombieDataset.id,
			isExisting: zombieIsExisting,
			x: zombieDataset.x,
			y: zombieDataset.y,
			xNext: zombieDataset.xNext,
			yNext: zombieDataset.yNext
		}
		return zombie;
	}

	public static function killHumanIfInRange( humanDataset:HumanDataset, zombieDatasets:Array<ZombieDataset> ) {
		if( !humanDataset.isAlive ) return humanDataset;
		
		var isAlive = true;
		for( zombie in zombieDatasets ) {
			if( zombie.isExisting ) {
				final zombieKills = humanDataset.x == zombie.x && humanDataset.y == zombie.y;
				if( zombieKills ) {
					trace( 'zombie ${zombie.id} kills human ${humanDataset.id}' );
					isAlive = false;
					break;
				}
			}
		}
		
		final human:HumanDataset = {
			id: humanDataset.id,
			isAlive: isAlive,
			x: humanDataset.x,
			y: humanDataset.y
		}
		return human;
	}

	static inline function getScaleFactor( dx:Int, dy:Int, max:Int ) {
		final dLength = length( dx, dy );
		final scaleFactor = dLength > max ? max / dLength : 1;
		return scaleFactor;
	}

	static inline function move( v:Int, dv:Int, scaleFactor:Float ) return floor( v + dv * scaleFactor );

	// static function move( x:Int, y:Int, targetX:Int, targetY:Int, max:Int ) {
	// 	final dx = targetX - x;
	// 	final dy = targetY - y;

	// 	final dLength = length( dx, dy );
	// 	final scaleFactor = dLength > max ? max / dLength : 1;
		
	// 	final xNext = floor( x + dx * scaleFactor );
	// 	final yNext = floor( y + dy * scaleFactor );

	// 	final nextPos = { x: xNext, y: yNext };

	// 	return nextPos;
	// }

}