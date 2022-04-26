package player;

import game.Configuration;
import h2d.Bitmap;
import h2d.Object;
import h2d.Text;
import player.App;
import player.CharacterView;
import player.EntityCreator;
import view.Coord;
import view.FrameViewData;

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

	final textfieldsMana:Array<Text>;
	
	final heros:Array<HeroView> = [];
	final mobs:Map<Int, MobView> = [];
	final hearts:Array<Bitmap> = [];
	
	public function new( scene:Object, entityCreator:EntityCreator ) {
		this.scene = scene;
		this.entityCreator = entityCreator;

		mobsLayer = new Object( scene );
		herosLayer = new Object( scene );
		textLayer = new Object( scene );

		textfieldsMana = [
			new Text( hxd.Res.times_new_roman.toFont(), textLayer ),
			new Text( hxd.Res.times_new_roman.toFont(), textLayer )
		];
		textfieldsMana[0].textAlign = Right;
		textfieldsMana[0].x = 446;
		textfieldsMana[0].y = 54;
		textfieldsMana[1].textAlign = Right;
		textfieldsMana[1].x = 1582;
		textfieldsMana[1].y = 54;

	}

	public function initEntities() {
		for( heartX in heartXs ) hearts.push( entityCreator.createHeart( textLayer, heartX, heartY ));
		for( _ in 0...3 ) heros.push( entityCreator.createHero( herosLayer, 0 ));
		for( _ in 0...3 ) heros.push( entityCreator.createHero( herosLayer, 1 ));
	}

	public function update( previous:FrameViewData, frame:FrameViewData, next:FrameViewData, subFrame:Float ) {
		for( mobView in mobs ) mobView.hide();

		for( i in 0...frame.mana.length ) {
			textfieldsMana[i].text = '${frame.mana[i]}';
		}
		
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
				if( !mobs.exists( id )) {
					final fullHealth = frame.mobHealth.exists( id ) ? frame.mobHealth[id] : 1;
					final mobType = id < 40 ? 0 : id < 75 ? 1 : 2; // Todo find id of Mob Type 3
					mobs[id] = entityCreator.createMob( mobsLayer, mobType, fullHealth );
				}
				final previousCoord = previous.positions.exists( id ) ? previous.positions[id] : coord ;
				final nextCoord = next.positions.exists( id ) ? next.positions[id] : coord;
				
				final mobView = mobs[id];
				if( frame.mobHealth.exists( id )) {
					final health = frame.mobHealth[id];
					if( health > 0 ) {
						mobView.show();
						mobView.setHealth( frame.mobHealth[id] );
					}
				}
				
				place( mobView, previousCoord, coord, nextCoord, subFrame );
			}
		}
		for( id => message in frame.messages ) {
			heros[id].setMessage( message );
		}
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
		if( dx2 != 0 || dy2 != 0 ) character.rotate( angle);
		
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