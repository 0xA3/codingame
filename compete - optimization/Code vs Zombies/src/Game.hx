import Math.floor;
import data.FrameDataset;
import data.HumanDataset;
import data.Vec2;
import data.ZombieDataset;
import xa3.MathUtils.distance;
import xa3.MathUtils.distanceSq;
import xa3.MathUtils.length;

class Game {
	static inline var ASH_RANGE = 2000;
	static inline var ASH_STEP = 1000;
	static inline var ZOMBIE_STEP = 400;
	
	public static function executeRound( ashTarget:Vec2, frameDataset:FrameDataset ) {
		final movedZombies = [];
		for( zombie in frameDataset.zombies ) {
			final closestPosition = getClosestPosition( zombie.positionNext, frameDataset.ash, frameDataset.humans );
			final positionNext = move( zombie.positionNext, closestPosition, ZOMBIE_STEP );
			final movedZombie:ZombieDataset = {
				id: zombie.id,
				isExisting: zombie.isExisting,
				position: zombie.positionNext,
				positionNext: positionNext
			}
			movedZombies[zombie.id] = movedZombie;
		}
		
		final ashPosition = move( frameDataset.ash, ashTarget, ASH_STEP );
		
		final deadAliveZombies = [];
		for( zombie in movedZombies ) {
			deadAliveZombies[zombie.id] = killZombieIfInRange( ashPosition, zombie );
		}
		
		final deadAliveHumans = [];
		for( human in frameDataset.humans ) deadAliveHumans[human.id] = killHumanIfInRange( human, deadAliveZombies );

		final nextFrame:FrameDataset = {
			ash: ashPosition,
			humans: deadAliveHumans,
			zombies: deadAliveZombies
		}

		return nextFrame;
	}

	static function getClosestPosition( pos:Vec2, ashPosition:Vec2, humans:Array<HumanDataset> ) {
		var minDistanceSq = distanceSq( pos.x, pos.y, ashPosition.x, ashPosition.y );
		var closestPosition = ashPosition;
		for( human in humans ) {
			if( human.isAlive )	{
				final humanDistanceSq = distanceSq( pos.x, pos.y, human.position.x, human.position.y );
				if( humanDistanceSq < minDistanceSq ) {
					minDistanceSq = humanDistanceSq;
					closestPosition = human.position;
				}
			}
		}
		return closestPosition;		
	}

	public static function killZombieIfInRange( ashPosition:Vec2, zombieDataset:ZombieDataset ) {
		if( !zombieDataset.isExisting ) return zombieDataset;
		
		final distanceZombie = distance( ashPosition.x, ashPosition.y, zombieDataset.position.x, zombieDataset.position.y );
		
		final zombieIsExisting = distanceZombie > ASH_RANGE;
		if( !zombieIsExisting ) trace( 'ash kills zombie ${zombieDataset.id}' );
		
		final zombie:ZombieDataset = {
			id: zombieDataset.id,
			isExisting: zombieIsExisting,
			position: zombieDataset.position,
			positionNext: zombieDataset.positionNext
		}
		return zombie;
	}

	public static function killHumanIfInRange( humanDataset:HumanDataset, zombieDatasets:Array<ZombieDataset> ) {
		if( !humanDataset.isAlive ) return humanDataset;
		
		var isAlive = true;
		for( zombie in zombieDatasets ) {
			if( zombie.isExisting ) {
				final zombieKills = humanDataset.position.x == zombie.position.x && humanDataset.position.y == zombie.position.y;
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
			position: humanDataset.position
		}
		return human;
	}

	static function move( pos:Vec2, target:Vec2, max:Int ) {
		final dx = target.x - pos.x;
		final dy = target.y - pos.y;

		final dLength = length( dx, dy );
		final scaleFactor = dLength > max ? max / dLength : 1;
		
		final xNext = floor( pos.x + dx * scaleFactor );
		final yNext = floor( pos.y + dy * scaleFactor );

		final nextPos:Vec2 = { x: xNext, y: yNext };

		return nextPos;
	}

}