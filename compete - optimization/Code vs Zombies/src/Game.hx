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

	public static function executeRound( ashTargetX:Int, ashTargetY:Int, frameDataset:FrameDataset ) {
		final movedZombies = [];
		for( zombie in frameDataset.zombies ) {
			final closestHuman = getClosestHumanId( zombie.xNext, zombie.yNext, frameDataset.ashX, frameDataset.ashY, frameDataset.humans );
			final closestPositionX = closestHuman == -1 ? frameDataset.ashX : frameDataset.humans[closestHuman].x;
			final closestPositionY = closestHuman == -1 ? frameDataset.ashY : frameDataset.humans[closestHuman].y;
			
			final dx = closestPositionX - zombie.xNext;
			final dy = closestPositionY - zombie.yNext;
			final scaleFactor = getStepFactor( dx, dy, ZOMBIE_STEP );

			final xNext = move( zombie.xNext, dx, scaleFactor );
			final yNext = move( zombie.yNext, dy, scaleFactor );
			
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
		
		final dx = ashTargetX - frameDataset.ashX;
		final dy = ashTargetY - frameDataset.ashY;
		final scaleFactor = getStepFactor( dx, dy, ASH_STEP );

		final ashX = move( frameDataset.ashX, dx, scaleFactor );
		final ashY = move( frameDataset.ashY, dy, scaleFactor );
		
		final killCheckedZombies:Array<ZombieDataset> = [];
		for( i in 0...movedZombies.length ) {
			final zombie = movedZombies[i];
			final isZombieKilled = checkZombieKill( ashX, ashY, zombie );
			if( isZombieKilled ) {
				killCheckedZombies[i] = {
					id: zombie.id,
					isExisting: false,
					x: zombie.x,
					y: zombie.y,
					xNext: zombie.xNext,
					yNext: zombie.yNext
				}
			} else {
				killCheckedZombies[i] = zombie;
			}
		}
		
		final killCheckedHumans = [];
		for( i in 0...frameDataset.humans.length ) killCheckedHumans[i] = killHumanIfInRange( frameDataset.humans[i], killCheckedZombies );

		final nextFrame:FrameDataset = {
			ashX: ashX,
			ashY: ashY,
			humans: killCheckedHumans,
			zombies: killCheckedZombies
		}

		return nextFrame;
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

	public static function checkZombieKill( ashX:Int, ashY:Int, zombieDataset:ZombieDataset ) {
		if( !zombieDataset.isExisting ) return false;
		
		final distanceZombie = distance( ashX, ashY, zombieDataset.x, zombieDataset.y );
		if( distanceZombie <= ASH_RANGE ) trace( 'ash kills zombie ${zombieDataset.id}' );
		return distanceZombie <= ASH_RANGE;
		
	}

	public static function killHumanIfInRange( humanDataset:HumanDataset, zombieDatasets:Array<ZombieDataset> ) {
		if( !humanDataset.isAlive ) return humanDataset;
		
		for( zombie in zombieDatasets ) {
			if( zombie.isExisting ) {
				final isHumanKilled = humanDataset.x == zombie.xNext && humanDataset.y == zombie.yNext;
				if( isHumanKilled ) {
					trace( 'zombie ${zombie.id} kills human ${humanDataset.id}' );
					final killedHuman:HumanDataset = {
						id: humanDataset.id,
						isAlive: false,
						x: humanDataset.x,
						y: humanDataset.y
					}
					return killedHuman;
				}
			}
		}
		return humanDataset;		
	}

	static inline function getStepFactor( dx:Int, dy:Int, max:Int ) {
		final dLength = length( dx, dy );
		final scaleFactor = dLength > max ? max / dLength : 1;
		return scaleFactor;
	}

	static inline function move( v:Int, dv:Int, scaleFactor:Float ) return floor( v + dv * scaleFactor );

}