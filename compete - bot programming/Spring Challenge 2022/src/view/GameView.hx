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
	final mobsLayer:Object;
	final textLayer:Object;

	final tMana1:Text;
	final tMana2:Text;
	
	final heros:Array<CharacterView> = [];
	final mobs:Map<Int, CharacterView> = [];
	final hearts:Array<Bitmap> = [];
	
	public function new( scene:Object, entityCreator:EntityCreator ) {
		
		this.scene = scene;
		this.entityCreator = entityCreator;

		herosLayer = new Object( scene );
		mobsLayer = new Object( scene );
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
		// for( monsterData in testCaseDataset.mobs ) {
		// 	if( mobs[monsterData.id] == null ) {
		// 		final monsterView = entityCreator.createMonster( mobsLayer, monsterData.x, monsterData.y, 0 );
		// 		mobs[monsterData.id] = monsterView;
		// 	} else {
		// 		mobs[monsterData.id].place( monsterData.x, monsterData.y );
		// 	}
		// }
	}


	public function update( previous:FrameViewData, frame:FrameViewData, next:FrameViewData, subFrame:Float ) {
		
		for( mob in mobs ) mob.isVisible = false;

		for( i in 0...frame.baseHealth.length ) {
			final heartStart = i * 3;
			final baseHealth = frame.baseHealth[i];
			hearts[heartStart].visible = baseHealth > 0;
			hearts[heartStart + 1].visible = baseHealth > 1;
			hearts[heartStart + 2].visible = baseHealth > 2;
		}

		for( id => coord in frame.positions ) {
			if( id < 6 ) { // hero
				place( heros[id], previous.positions[id], frame.positions[id], next.positions[id], subFrame );
			} else {
				if( !mobs.exists( id )) createMob( id );
				final previousCoord = previous.positions.exists( id ) ? previous.positions[id] : coord ;
				final nextCoord = next.positions.exists( id ) ? next.positions[id] : coord;
				
				final mob = mobs[id];
				mob.isVisible = true;
				place( mob, previousCoord, coord, nextCoord, subFrame );
			}
		}
	}

	function createMob( id:Int ) {
		final mobType = id < 38 ? 0 : id < 72 ? 1 : 2; // Todo find id of Mob Type 3
		mobs[id] = entityCreator.createMob( mobsLayer, mobType );
		// trace( 'createMob $id' );
	}

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
		
		final x = interpolate( coord.x, next.x, easedSubFrame);
		final y = interpolate( coord.y, next.y, easedSubFrame );
		character.place( x, y );
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