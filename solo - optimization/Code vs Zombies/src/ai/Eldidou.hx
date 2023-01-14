package ai;

import data.FrameDataset;
import data.Strategy;
import data.ZombieDataset;
import haxe.Timer;
import xa3.MathUtils;

using Lambda;

class Eldidou implements Ai {
	
	static inline var WIDTH = 16000;
	static inline var HEIGHT = 9000;

	static var emptyStrategy:Strategy = { positions: [], zombieIds: [] };

	static var emptyMutFrameDataset:MutFrameDataset = {
		ashX: 0,
		ashY: 0,
		humans: [],
		zombies: []
	};

	var bestScore = 0;
	var bestStrategy:Strategy;
	var targetCounter = 0;
	var currentFrame = 0;

	public function new() {}

	public function reset() {
		targetCounter = 0;
		currentFrame = 0;
		bestScore = 0;
		bestStrategy = emptyStrategy;
}

	public function process( frameDataset:FrameDataset ) {
		final timeout = currentFrame == 0 ? 0.98 : 0.08;
		final endTime = Timer.stamp() + 0.97;
		if( currentFrame == 0 ) {
			// find strategy
			var strategyCounter = 0;
			while( Timer.stamp() < endTime ) {
			// for( _ in 0...1000 ) {
				final strategy = randomStrategy( frameDataset.ashX, frameDataset.ashY, frameDataset.zombies );
				// final strategy = testStrategy();
				final score = simulateStrategy( frameDataset, strategy );
				if( score > bestScore ) {
					bestScore = score;
					bestStrategy = strategy;
				}
				strategyCounter++;
				// trace( 'strategy positions ${strategy.positions} zombieIds ${strategy.zombieIds} Score $score' );
			}
			// trace( '$strategyCounter bestStrategy positions ${bestStrategy.positions} zombieIds ${bestStrategy.zombieIds} Score $bestScore' );
		}

		final positions = bestStrategy.positions;
		final zombieIds = bestStrategy.zombieIds;
		var ashTargetX = -1;
		var ashTargetY = -1;
		
		if( targetCounter < positions.length ) {
			ashTargetX = positions[targetCounter][0];
			ashTargetY = positions[targetCounter][1];
			// trace( '$currentFrame go from ${frameDataset.ashX}:${frameDataset.ashY} to position ${ashTargetX}:${ashTargetY}' );
			// if( frameDataset.ashX == ashTargetX && frameDataset.ashY == ashTargetY ) targetCounter++;
			if( MathUtils.distanceSq( frameDataset.ashX, frameDataset.ashY, ashTargetX, ashTargetY ) < Game.ASH_STEP_SQ ) targetCounter++;
		} else {
			final zombie = getNextZombie( zombieIds, positions.length, frameDataset.zombies );
			ashTargetX = zombie.xNext;
			ashTargetY = zombie.yNext;
			// trace( '$currentFrame go from ${frameDataset.ashX}:${frameDataset.ashY} to zombie ${zombie.id} ${ashTargetX}:${ashTargetY}' );
		}
		currentFrame++;
		
		return '$ashTargetX $ashTargetY';
	}
	
	function getNextZombie( zombieIds:Array<Int>, positionsLength:Int, zombies:Array<ZombieDataset> ) {
		final start = targetCounter - positionsLength;
		final end = zombieIds.length;
		for( i in start...end ) {
			final zombieId = zombieIds[i];
			for( zombie in zombies ) {
				if( zombie.id == zombieId && zombie.isUndead ) return zombie;
			}
			targetCounter++;
		}
		throw( 'Error: no next zombie  start $start  end $end targetCounter $targetCounter' );
	}

	inline function randomStrategy( ashX:Int, ashY:Int, zombies:Array<ZombieDataset> ) {
		final positions = [];
		for( _ in 0...Std.random( 3 )) {
			final x = Std.random( WIDTH );
			final y = Std.random( HEIGHT );
			positions.push([ x, y ]);
		}
		final zombieIds = zombies.map( z -> z.id );
		zombieIds.sort(( a, b ) -> Std.random( 3 ) - 2 );
		final strategy:Strategy = {
			positions: positions,
			zombieIds: zombieIds
		}
		return strategy;
	}

	inline function testStrategy() {
		final s:Strategy = {
			positions: [[5066,741]],
			zombieIds: [1,0]
		}
		return s;
	}

	inline function simulateStrategy( frameDataset:FrameDataset, strategy:Strategy ) {
		
		var mutFrameDataset = emptyMutFrameDataset;
		Game.setMutFrameDataset( frameDataset, mutFrameDataset );
		var remainingHumans = mutFrameDataset.humans.length;
		var remainingZombies = mutFrameDataset.zombies.length;
		
		final positions = strategy.positions;
		final zombieIds = strategy.zombieIds;

		var score = 0;
		var ashTargetX = mutFrameDataset.ashX;
		var ashTargetY = mutFrameDataset.ashY;
		var simTargetCounter = 0;
		var frame = 0;
		while( remainingHumans > 0 && remainingZombies > 0 ) {
			if( simTargetCounter < positions.length ) {
				ashTargetX = positions[simTargetCounter][0];
				ashTargetY = positions[simTargetCounter][1];
				// trace( '$frame go from ${mutFrameDataset.ashX}:${mutFrameDataset.ashY} to position ${ashTargetX}:${ashTargetY}' );
				if( MathUtils.distanceSq( frameDataset.ashX, frameDataset.ashY, ashTargetX, ashTargetY ) < Game.ASH_STEP_SQ ) simTargetCounter++;
			} else {
				for( i in simTargetCounter - positions.length...zombieIds.length ) {
					final zombie =  mutFrameDataset.zombies[zombieIds[i]];
					if( zombie.isUndead ) {
						ashTargetX = zombie.xNext;
						ashTargetY = zombie.yNext;
						// trace( '$frame go from ${mutFrameDataset.ashX}:${mutFrameDataset.ashY} to zombie ${zombie.id} ${ashTargetX}:${ashTargetY}' );
						break;
					}
				}
			}

			Game.executeRound( ashTargetX, ashTargetY, mutFrameDataset );

			final nextRemainingHumans = mutFrameDataset.humans.fold(( h, sum ) -> h.isAlive ? sum + 1 : sum, 0 );
			final nextRemainingZombies = mutFrameDataset.zombies.fold(( h, sum ) -> h.isUndead ? sum + 1 : sum, 0 );
			if( nextRemainingHumans == 0 ) score = 0;
			else score += Game.calculateScore( remainingHumans, remainingZombies - nextRemainingZombies );

			remainingHumans = nextRemainingHumans;
			remainingZombies = nextRemainingZombies;
			// trace( '$frame go from x:${mutFrameDataset.ashX} y:${mutFrameDataset.ashY}  to $ashTargetX:$ashTargetY  score $score' );
			frame++;
		}
		return score;
	}

}