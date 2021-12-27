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
	static var fibonnacci = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144];

	public static inline function setMutFrameDataset( fd:FrameDataset, mfd:MutFrameDataset ) {
		mfd.ashX = fd.ashX;
		mfd.ashY = fd.ashY;
		mfd.humans.splice( 0, mfd.humans.length );
		mfd.zombies.splice( 0, mfd.zombies.length );
		for( i in 0...fd.humans.length ) {
			final human = fd.humans[i];
			mfd.humans[i] = {
				id: human.id,
				isAlive: human.isAlive,
				x: human.x,
				y: human.y
			}
		}
		for( i in 0...fd.zombies.length ) {
			final zombie = fd.zombies[i];
			mfd.zombies[i] = {
				id: zombie.id,
				isUndead: zombie.isUndead,
				x: zombie.x,
				y: zombie.y,
				xNext: zombie.xNext,
				yNext: zombie.yNext
			}
		}
	}

	public static function executeRound( ashTargetX:Int, ashTargetY:Int, frameDataset:MutFrameDataset ) {
		for( zombie in frameDataset.zombies ) moveZombie( zombie );
		moveAsh( ashTargetX, ashTargetY, frameDataset );
		destroyZombies( frameDataset );
		killHumans( frameDataset );

		for( zombie in frameDataset.zombies ) {
			final closestHumanId = getClosestHumanId( zombie.xNext, zombie.yNext, frameDataset.ashX, frameDataset.ashY, frameDataset.humans );
			final closestHumanX = closestHumanId == -1 ? frameDataset.ashX : frameDataset.humans[closestHumanId].x;
			final closestHumanY = closestHumanId == -1 ? frameDataset.ashY : frameDataset.humans[closestHumanId].y;
			
			final dx = closestHumanX - zombie.xNext;
			final dy = closestHumanY - zombie.yNext;
			final scaleFactor = getStepFactor( dx, dy, ZOMBIE_STEP );

			zombie.xNext = move( zombie.xNext, dx, scaleFactor );
			zombie.yNext = move( zombie.yNext, dy, scaleFactor );
		}
	}

	static inline function moveZombie( zombie:MutZombieDataset ) {
		zombie.x = zombie.xNext;
		zombie.y = zombie.yNext;
	}

	static inline function moveAsh( ashTargetX:Int, ashTargetY:Int, frameDataset:MutFrameDataset ) {
		final dx = ashTargetX - frameDataset.ashX;
		final dy = ashTargetY - frameDataset.ashY;
		final scaleFactor = getStepFactor( dx, dy, ASH_STEP );

		frameDataset.ashX = move( frameDataset.ashX, dx, scaleFactor );
		frameDataset.ashY = move( frameDataset.ashY, dy, scaleFactor );
	}

	static inline function destroyZombies( frameDataset:MutFrameDataset ) {
		for( zombie in frameDataset.zombies ) {
			if( zombie.isUndead ) {
				final isZombieKilled = checkZombieKill( frameDataset.ashX, frameDataset.ashY, zombie );
				if( isZombieKilled ) zombie.isUndead = false;
			}
		}
	}

	static inline function killHumans( frameDataset:MutFrameDataset ) {
		for( human in frameDataset.humans ) {
			if( human.isAlive ) {
				final isHumanKilled = checkHumanKill( human, frameDataset.zombies );
				if( isHumanKilled ) human.isAlive = false;
			}
		}
	}
	
	public static inline function calculateScore( remainingHumans:Int, killedZombies:Int ) {
		var score = 0;
		for( i in 0...killedZombies ) {
			final fib = i == 0 ? 1 : fibonnacci[i + 2];
			score += remainingHumans * remainingHumans * 10 * fib;
			// trace( 'zombie $i  fib $fib  score + ${remainingHumans * remainingHumans * 10 * fib}' );
		}
		return score;
	}

	static inline function getClosestHumanId( x:Int, y:Int, ashX:Int, ashY:Int, humans:Array<HumanDataset> ) {
		var minDistanceSq = distanceSq( x, y, ashX, ashY );
		// trace( 'zombie $x:$y  ashDistance ${Math.sqrt( minDistanceSq )}' );
		var closestHumanId = -1;
		for( i in 0...humans.length ) {
			final human = humans[i];
			if( human.isAlive )	{
				final humanDistanceSq = distanceSq( x, y, human.x, human.y );
				// trace( 'human $i distance ${Math.sqrt( humanDistanceSq)}' );
				if( humanDistanceSq < minDistanceSq ) {
					minDistanceSq = humanDistanceSq;
					closestHumanId = i;
				}
			}
		}
		return closestHumanId;		
	}

	public static inline function checkZombieKill( ashX:Int, ashY:Int, zombieDataset:MutZombieDataset ) {
		final distanceZombie = distance( ashX, ashY, zombieDataset.x, zombieDataset.y );
		// if( distanceZombie <= ASH_RANGE ) trace( 'ash kills zombie ${zombieDataset.id}' );
		return distanceZombie <= ASH_RANGE;
	}

	public static function checkHumanKill( humanDataset:MutHumanDataset, zombieDatasets:Array<ZombieDataset> ) {
		for( zombie in zombieDatasets ) {
			if( zombie.isUndead && humanDataset.x == zombie.x && humanDataset.y == zombie.y ) return true;
		}
		return false;		
	}

	static inline function getStepFactor( dx:Int, dy:Int, max:Int ) {
		final dLength = length( dx, dy );
		final scaleFactor = dLength > max ? max / dLength : 1;
		return scaleFactor;
	}

	static inline function move( v:Int, dv:Int, scaleFactor:Float ) return v + floor( dv * scaleFactor );

}