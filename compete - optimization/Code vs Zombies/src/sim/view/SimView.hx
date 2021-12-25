package sim.view;

import data.FrameDataset;
import h2d.Object;
import h2d.Text;
import xa3.MathUtils;
import xa3.NumberFormat;

class SimView {
	
	public final scene:Object;
	final entityCreator:EntityCreator;
	
	final bloodLayer:Object;
	final humansLayer:Object;
	final zombiesLayer:Object;
	final ashLayer:Object;
	final textLayer:Object;

	final tHumansLeft:Text;
	final tScore:Text;
	
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
		textLayer = new Object( scene );

		ashLayer.addChild( ash.object );
		
		tHumansLeft = new Text( hxd.Res.ncaa_detroit_titans_bold.toFont(), textLayer );
		tHumansLeft.x = 1700;
		tHumansLeft.y = 46;
		tHumansLeft.rotation = MathUtils.degToRad( -8 );
		
		tScore = new Text( hxd.Res.ncaa_detroit_titans_bold.toFont(), textLayer );
		tScore.x = 2070;
		tScore.y = 76;
		tScore.rotation = MathUtils.degToRad( -8 );
	}

	public function initEntities( testCaseDataset:FrameDataset ) {
		
		for( humanData in testCaseDataset.humans ) {
			if( humans[humanData.id] == null ) {
				final bloodSplatter = entityCreator.createBlood( bloodLayer );
				final humanView = entityCreator.createHuman( humansLayer, humanData.x, humanData.y, bloodSplatter );
				humans[humanData.id] = humanView;
			} else {
				humans[humanData.id].place( humanData.x, humanData.y );
			}
		}
		for( zombieData in testCaseDataset.zombies ) {
			if( zombies[zombieData.id] == null ) {
				final bloodSplatter = entityCreator.createBlood( bloodLayer );
				final zombieView = entityCreator.createZombie( zombiesLayer, zombieData.x, zombieData.y, bloodSplatter );
				zombies[zombieData.id] = zombieView;
			} else {
				zombies[zombieData.id].place( zombieData.x, zombieData.y );
			}
		}
		for( i in testCaseDataset.humans.length...humans.length ) humans[i].hide();
		for( i in testCaseDataset.zombies.length...zombies.length ) zombies[i].hide();
	}

	public function update( ashPreviousX:Int, ashPreviousY:Int, frame:FrameDataset, nextFrame:FrameDataset, subFrame:Float, score:Int ) {
		final prevVelX = frame.ashX - ashPreviousX;
		final prevVelY = frame.ashY - ashPreviousY;
		final velX = nextFrame.ashX - frame.ashX;
		final velY = nextFrame.ashY - frame.ashY;
		
		final easedRotation = quadEaseInOut( Math.min( 1, subFrame * 3 ));
		final easedSubFrame = quadEaseInOut( subFrame );
		
		final angle1 = MathUtils.angle( prevVelX, prevVelY );
		final angle2 = MathUtils.angle( velX, velY );
		final angle = interpolate( angle1, angle2, easedRotation );
		ash.rotate( angle);
		
		final ashX = interpolate( frame.ashX, nextFrame.ashX, easedSubFrame);
		final ashY = interpolate( frame.ashY, nextFrame.ashY, easedSubFrame );
		ash.place( ashX, ashY );
		
		var humansLeft = 0;
		for( i in 0...frame.humans.length ) {
			final humanData = frame.humans[i];
			final humanView = humans[i];

			final isDying = !humanData.isAlive && humanView.isVisible;
			final isBecomingAlive = humanData.isAlive && !humanView.isVisible;

			if( isDying ) humanView.die();
			if( isBecomingAlive ) humanView.live();
			if( humanData.isAlive ) {
				humanView.place( humanData.x, humanData.y );
				humansLeft++;
			}
		}
		
		for( i in 0...frame.zombies.length ) {
			final zombieData = frame.zombies[i];
			final zombieView = zombies[i];

			final isDying = !zombieData.isExisting && zombieView.isVisible;
			final isBecomingAlive = zombieData.isExisting && !zombieView.isVisible;

			if( isDying ) zombieView.die();
			if( isBecomingAlive ) zombieView.live();

			if( zombieData.isExisting  ) {
				final zombieVelX = zombieData.xNext - zombieData.x;
				final zombieVelY = zombieData.yNext - zombieData.y;
				zombieView.rotate( MathUtils.angle( zombieVelX, zombieVelY ));
				
				final zombieX = interpolate( zombieData.x, zombieData.xNext, easedSubFrame );
				final zombieY = interpolate( zombieData.y, zombieData.yNext, easedSubFrame );
				
				zombieView.place( zombieX, zombieY );
			}
		}
		tHumansLeft.text = '$humansLeft';
		tScore.text = NumberFormat.number( score );
	}


	inline function interpolate( v1:Float, v2:Float, f:Float ) {
		return v1 + ( v2 - v1 ) * f;
	}
	
	public function quadEaseInOut( k:Float ) {
		if ((k *= 2) < 1) {
			return 1 / 2 * k * k;
		}
		return -1 / 2 * ((k - 1) * (k - 3) - 1);
	}

}