package view;

import game.App;
import game.Configuration;
import h2d.Bitmap;
import h2d.Object;
import h2d.Text;
import view.CharacterView;
import view.EntityCreator;

using xa3.MathUtils;

class GameView {
	
	public static inline var X0 = 48;
	public static inline var Y0 = 116;
	
	static final scale = App.SCENE_WIDTH / Configuration.MAP_WIDTH;
	public static function sX( x:Float ) return x * scale + X0;
	public static function sY( y:Float ) return y * scale + Y0;

	final heartY = 58;
	final heartXs = [195, 226, 256, 1334, 1365, 1395];

	public final scene:Object;
	final entityCreator:EntityCreator;
	
	final herosLayer:Object;
	final monstersLayer:Object;
	final textLayer:Object;

	final tMana1:Text;
	final tMana2:Text;
	
	final heros:Array<CharacterView> = [];
	final monsters:Array<CharacterView> = [];
	final hearts:Array<Bitmap> = [];
	
	public function new( scene:Object, entityCreator:EntityCreator ) {
		
		this.scene = scene;
		this.entityCreator = entityCreator;

		herosLayer = new Object( scene );
		monstersLayer = new Object( scene );
		textLayer = new Object( scene );

		tMana1 = new Text( hxd.Res.ncaa_detroit_titans_bold.toFont(), textLayer );
		tMana1.x = 387;
		tMana1.y = 56;
		
		tMana2 = new Text( hxd.Res.ncaa_detroit_titans_bold.toFont(), textLayer );
		tMana2.x = 1526;
		tMana2.y = 56;
	}

	public function initEntities() {
		
		for( heartX in heartXs ) {
			hearts.push( entityCreator.createHeart( textLayer, heartX, heartY ));
		}

		for( i in 0...3 ) heros.push( entityCreator.createHero( herosLayer, 0 ));
		for( i in 0...3 ) heros.push( entityCreator.createHero( herosLayer, 1 ));
		// for( monsterData in testCaseDataset.monsters ) {
		// 	if( monsters[monsterData.id] == null ) {
		// 		final monsterView = entityCreator.createMonster( monstersLayer, monsterData.x, monsterData.y, 0 );
		// 		monsters[monsterData.id] = monsterView;
		// 	} else {
		// 		monsters[monsterData.id].place( monsterData.x, monsterData.y );
		// 	}
		// }
	}


	public function update( previous:FrameViewData, frame:FrameViewData, next:FrameViewData, subFrame:Float ) {
		
		for( id => coord in frame.positions ) {
			if( id < 6 ) { // hero
				place( heros[id], previous.positions[id], frame.positions[id], next.positions[id], subFrame );
			}
		}
		/*		final prevVelX = frame.ashX - ashPreviousX;
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

			final isDying = !zombieData.isUndead && zombieView.isVisible;
			final isBecomingAlive = zombieData.isUndead && !zombieView.isVisible;

			if( isDying ) zombieView.die();
			if( isBecomingAlive ) zombieView.live();

			if( zombieData.isUndead  ) {
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
*/	}

	function place( character:CharacterView, previous:Coord, coord:Coord, next:Coord, subFrame:Float ) {
		final dx1 = coord.x - previous.x;
		final dy1 = coord.y - previous.y;
		final dx2 = next.x - coord.x;
		final dy2 = next.y - coord.y;
		
		final easedRotation = quadEaseInOut( Math.min( 1, subFrame * 3 ));
		final easedSubFrame = quadEaseInOut( subFrame );
		
		final angle1 = MathUtils.angle( dx1, dy1 );
		final angle2 = MathUtils.angle( dx2, dy2 );
		final angle = interpolate( angle1, angle2, easedRotation );
		character.rotate( angle);
		
		final ashX = interpolate( coord.x, next.x, easedSubFrame);
		final ashY = interpolate( coord.y, next.y, easedSubFrame );
		character.place( ashX, ashY );
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