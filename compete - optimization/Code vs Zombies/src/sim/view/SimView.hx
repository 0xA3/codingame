package sim.view;

import data.FrameDataset;
import data.Vec2;
import h2d.Object;

class SimView {
	
	public final scene:Object;
	final ash:AshView;
	final entityCreator:EntityCreator;
	final humans:Array<HumanView> = [];
	final zombies:Array<ZombieView> = [];

	public function new( scene:Object, ash:AshView, entityCreator:EntityCreator ) {
		this.scene = scene;
		this.ash = ash;
		this.entityCreator = entityCreator;
	}

	public function initEntities( testCaseDataset:FrameDataset ) {
		for( humanData in testCaseDataset.humans ) {
			if( humans[humanData.id] == null ) {
				final human = entityCreator.createHuman( scene, humanData.position );
				humans[humanData.id] = human;
			} else {
				final human = humans[humanData.id];
				human.moveTo( humanData.position );
			}
		}
		for( zombieData in testCaseDataset.zombies ) {
			if( zombies[zombieData.id] == null ) {
				final zombie = entityCreator.createZombie( scene, zombieData.position );
				zombies[zombieData.id] = zombie;
			} else {
				final zombie = zombies[zombieData.id];
				zombie.moveTo( zombieData.position );
			}
		}
	}

	public function update( previousPosition:Vec2, frameDataset:FrameDataset ) {
		final ashVelocity = previousPosition.sub( frameDataset.ash );
		ash.rotate( ashVelocity.angle );
		
		ash.moveTo( frameDataset.ash );
		for( human in frameDataset.humans ) {
			humans[human.id].moveTo( human.position, human.isAlive );
		}
		for( zombie in frameDataset.zombies ) {
			final zombieVelocity = zombie.positionNext.sub( zombie.position );
			zombies[zombie.id].rotate( zombieVelocity.angle );
			zombies[zombie.id].moveTo( zombie.position, zombie.isExisting );
		}
	}
		
}