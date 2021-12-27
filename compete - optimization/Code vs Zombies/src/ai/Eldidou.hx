package ai;

import data.FrameDataset;
import data.Strategy;
import data.ZombieDataset;
import haxe.Timer;

using Lambda;

class Eldidou implements Ai {
	
	static inline var WIDTH = 16000;
	static inline var HEIGHT = 9000;

	final mutFrameDataset:MutFrameDataset = {
		ashX: 0,
		ashY: 0,
		humans: [],
		zombies: []
	};
	
	var bestStrategy:Strategy = { positions: [], zombieIds: [] };
	var isFirstFrame = true;

	public function new() {}

	public function reset() {
		isFirstFrame = true;
	}

	public function process( frameDataset:FrameDataset ) {

		final endTime = Timer.stamp() + 0.97;
		if( isFirstFrame ) {
			// find strategy
			var bestScore = 0;
			// while( Timer.stamp() < endTime ) {
			for( _ in 0...10 ) {
				final strategy = randomStrategy( frameDataset.ashX, frameDataset.ashY, frameDataset.zombies );
				final score = simulateStrategy( frameDataset, strategy );
				if( score > bestScore ) {
					bestScore = score;
					bestStrategy = strategy;
				}
			}
			trace( 'bestStrategy\n$bestStrategy\nScore $bestScore' );
			isFirstFrame = false;
		}

		if( bestStrategy.positions.length > 0 && frameDataset.ashX == bestStrategy.positions[0][0] && frameDataset.ashY == bestStrategy.positions[0][1] ) {
			bestStrategy.positions.shift();
		}
		
		if( bestStrategy.positions.length > 0 ) {
			final x = bestStrategy.positions[0][0];
			final y = bestStrategy.positions[0][1];
			return '$x $y';
		}
	
		if( bestStrategy.zombieIds.length > 0 ) {
			// do {
				final zombieIndex = getZombieIndex( bestStrategy.zombieIds[0], frameDataset.zombies );
				// todo
			// }
			final zombieId = bestStrategy.zombieIds[0];
			
			var zombie:ZombieDataset = null;
			for( z in frameDataset.zombies ) if( z.id == zombieId ) zombie = z;
			if( zombie == null ) bestStrategy.zombieIds.shift();
			final zombieId = bestStrategy.zombieIds[0];
			for( z in frameDataset.zombies ) if( z.id == zombieId ) zombie = z;
			
			final x = zombie.xNext;
			final y = zombie.yNext;
			return '$x $y';
		}
		
		return '${frameDataset.ashX} ${frameDataset.ashY}';
		
	}
	function getZombieIndex( zombieId:Int, zombies:Array<ZombieDataset> ) {
		for( i in 0...zombies.length ) if( zombies[i].id == zombieId ) return i;
		return -1;
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

	inline function simulateStrategy( frameDataset:FrameDataset, strategy:Strategy ) {
		
		Game.setMutFrameDataset( frameDataset, mutFrameDataset );
		var remainingHumans = mutFrameDataset.humans.length;
		var remainingZombies = mutFrameDataset.zombies.length;
		
		final positions = strategy.positions.copy();
		final zombieIds = strategy.zombieIds.copy();

		var score = 0;
		var ashTargetX = 0;
		var ashTargetY = 0;
		while( remainingHumans > 0 && remainingZombies > 0 ) {
			if( positions.length > 0 ) {
				ashTargetX = positions[0][0];
				ashTargetY = positions[0][1];
				Game.executeRound( ashTargetX, ashTargetY, mutFrameDataset );
				if( mutFrameDataset.ashX == ashTargetX && mutFrameDataset.ashY == ashTargetY ) positions.shift();
			} else if( zombieIds.length > 0 ) {
				final zombie = mutFrameDataset.zombies[zombieIds[0]];
				ashTargetX = zombie.xNext;
				ashTargetY = zombie.yNext;
				Game.executeRound( ashTargetX, ashTargetY, mutFrameDataset );
				if( !zombie.isUndead ) zombieIds.shift();
			}

			final nextRemainingHumans = mutFrameDataset.humans.fold(( h, sum ) -> h.isAlive ? sum + 1 : sum, 0 );
			final nextRemainingZombies = mutFrameDataset.zombies.fold(( h, sum ) -> h.isUndead ? sum + 1 : sum, 0 );
			if( nextRemainingHumans == 0 ) score = 0;
			else score += Game.calculateScore( remainingHumans, remainingZombies - nextRemainingZombies );

			remainingHumans = nextRemainingHumans;
			remainingZombies = nextRemainingZombies;
		}
		return score;
	}
}