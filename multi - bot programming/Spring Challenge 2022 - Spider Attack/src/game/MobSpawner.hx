package game;

import xa3.MTRandom;

class MobSpawner {
	
	final spawnLocations:Array<SpawnLocation>;
	final maxDirectionDelta:Float;
	final spawnRate:Int;
	var lastSpawn:Int;
	var currentMaxHealth:Float = Config.MOB_STARTING_MAX_ENERGY;

	public function new( spawnLocations:Array<SpawnLocation>, maxDirectionDelta:Float, spawnRate:Int ) {

		this.spawnLocations = spawnLocations;
		this.maxDirectionDelta = maxDirectionDelta;
		this.spawnRate = spawnRate;

		lastSpawn = -spawnRate;
	}

	public function update( turn:Int ) {
		// It's the end of the game, help the random generate a suitably epic final frame
		final suddenDeath = turn >= 200;

        if (turn - lastSpawn >= spawnRate) {
            lastSpawn = turn;
            return spawn( suddenDeath );
        }
		return new List<Mob>();
	}

	function opposite( v:Vector ) {
		return new Vector( Config.MAP_WIDTH - v.x, Config.MAP_HEIGHT - v.y );
	}

	function spawn( suddenDeath:Bool ) {
		
		final newMobs = new List<Mob>();

		for( pairToUse in spawnLocations ) {
			var suddenDeathTarget:Vector = null;

			if( suddenDeath ) {
				var tx = MTRandom.quickIntRand( Config.BASE_ATTRACTION_RADIUS );
				var ty = MTRandom.quickIntRand( Config.BASE_ATTRACTION_RADIUS );
				if( MTRandom.quickRand() < 0.5 ) {
					tx = Config.MAP_WIDTH - tx;
					ty = Config.MAP_HEIGHT - ty;
				}
				suddenDeathTarget = new Vector( tx, ty );
			}

			final directionDelta = MTRandom.quickRand() * maxDirectionDelta * 2 - maxDirectionDelta;
			for( i in 0...2 ) {
				final location = i == 0 ? pairToUse.position : pairToUse.symmetry;
				final direction = i == 0 ? pairToUse.direction : pairToUse.direction.symmetric();
				final mob = new Mob( Referee.entityId++, location, Std.int( currentMaxHealth ));
				if( suddenDeath ) {
					final v = Vector.fromVectors(location, i == 0 ? suddenDeathTarget : opposite( suddenDeathTarget )).normalize()
					.mult( Config.MOB_MOVE_SPEED ).truncate();
					mob.velocity = v;
				} else {
					mob.velocity = direction.rotate( directionDelta ).normalize().mult( Config.MOB_MOVE_SPEED ).truncate();
				}
				newMobs.add( mob );
			}
		}
		currentMaxHealth += Config.MOB_GROWTH_MAX_ENERGY;
		return newMobs;
	}
}