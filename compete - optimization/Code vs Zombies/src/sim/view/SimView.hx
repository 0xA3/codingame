package sim.view;

import data.FrameDataset;
import h2d.Bitmap;
import h2d.Object;

class SimView {
	
	public final scene:Object;
	
	final bloodLayer:Object;
	final humansLayer:Object;
	final zombiesLayer:Object;
	final ashLayer:Object;
	
	final entityCreator:EntityCreator;
	final humans:Array<PersonView> = [];
	final zombies:Array<ZombieView> = [];
	var ash:AshView;

	public function new( scene:Object, ash:AshView, entityCreator:EntityCreator ) {
		this.scene = scene;
		this.ash = ash;
		this.entityCreator = entityCreator;

		bloodLayer = new Object( scene );
		humansLayer = new Object( scene );
		zombiesLayer = new Object( scene );
		ashLayer = new Object( scene );
		ashLayer.addChild( ash.object );
	}

	public function initEntities( testCaseDataset:FrameDataset ) {
		
		for( humanData in testCaseDataset.humans ) {
			if( humans[humanData.id] == null ) {
				final bloodSplatter = entityCreator.createBlood( bloodLayer );
				final humanView = entityCreator.createHuman( humansLayer, humanData.position, bloodSplatter );
				humans[humanData.id] = humanView;
			} else {
				humans[humanData.id].place( humanData.position.x, humanData.position.y );
			}
		}
		for( zombieData in testCaseDataset.zombies ) {
			if( zombies[zombieData.id] == null ) {
				final bloodSplatter = entityCreator.createBlood( bloodLayer );
				final zombieView = entityCreator.createZombie( zombiesLayer, zombieData.position, bloodSplatter );
				zombies[zombieData.id] = zombieView;
			} else {
				zombies[zombieData.id].place( zombieData.position.x, zombieData.position.y );
			}
		}
	}

	public function update( frame:FrameDataset, nextFrame:FrameDataset, subFrame:Float ) {
		
		final easedSubFrame = quadEaseInOut( subFrame );

		final ashVelocity = nextFrame.ash.sub( frame.ash );
		// trace( 'ashVelocity $ashVelocity  length ${ashVelocity.length}' );
		ash.rotate( ashVelocity.angle );
		
		final ashX = interpolate( frame.ash.x, nextFrame.ash.x, easedSubFrame);
		final ashY = interpolate( frame.ash.y, nextFrame.ash.y, easedSubFrame );
		ash.place( ashX, ashY );
		
		for( i in 0...frame.humans.length ) {
			final humanData = frame.humans[i];
			final humanView = humans[i];

			final isDying = !humanData.isAlive && humanView.isVisible;
			final isBecomingAlive = humanData.isAlive && !humanView.isVisible;

			if( isDying ) humanView.die();
			if( isBecomingAlive ) humanView.live();
			if( humanData.isAlive ) humanView.place( humanData.position.x, humanData.position.y );
		}
		
		for( i in 0...frame.zombies.length ) {
			final zombieData = frame.zombies[i];
			final zombieView = zombies[i];

			final isDying = !zombieData.isExisting && zombieView.isVisible;
			final isBecomingAlive = zombieData.isExisting && !zombieView.isVisible;

			if( isDying ) zombieView.die();
			if( isBecomingAlive ) zombieView.live();

			if( zombieData.isExisting  ) {
				final zombieVelocity = zombieData.positionNext.sub( zombieData.position );
				zombieView.rotate( zombieVelocity.angle );
				
				final zombieX = interpolate( zombieData.position.x, zombieData.positionNext.x, easedSubFrame );
				final zombieY = interpolate( zombieData.position.y, zombieData.positionNext.y, easedSubFrame );
				
				zombieView.place( zombieX, zombieY );
			}
		}
	}

	inline function interpolate( v1:Int, v2:Int, f:Float ) {
		return v1 + ( v2 - v1 ) * f;
	}
	
	public function quadEaseInOut( k:Float ) {
		if ((k *= 2) < 1) {
			return 1 / 2 * k * k;
		}
		return -1 / 2 * ((k - 1) * (k - 3) - 1);
	}

}