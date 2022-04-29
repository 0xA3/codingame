package player;

import Std.int;
import game.Config;
import game.Vector;
import h2d.Bitmap;
import h2d.Graphics;
import h2d.Object;
import h2d.Scene;
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
	
	static inline var PADDING = 4;

	public static final TAU = 2 * Math.PI;
	static final scale = App.SCENE_WIDTH / Config.MAP_WIDTH;
	public static function sX( x:Float ) return x * scale + X0;
	public static function sY( y:Float ) return y * scale + Y0;

	final s2d:Scene;

	final timesFont = hxd.Res.times_new_roman_bold.toFont();
	final heartY = 58;
	final heartXs = [195, 226, 256, 1334, 1365, 1395];

	public final scene:Object;
	final entityCreator:EntityCreator;
	
	final herosLayer:Object;
	final mobsLayer:Object;
	final textLayer:Object;

	final textfieldsMana:Array<Text>;
	final overlay:Object;
	final overlayBox:Graphics;
	final overlayText:Text;

	final heros:Array<HeroView> = [];
	final mobs:Map<Int, MobView> = [];
	final hearts:Array<Bitmap> = [];
	
	public var isMouseDown = false;

	public function new( s2d:Scene, scene:Object, entityCreator:EntityCreator ) {
		this.s2d = s2d;
		this.scene = scene;
		this.entityCreator = entityCreator;

		mobsLayer = new Object( scene );
		herosLayer = new Object( scene );
		textLayer = new Object( scene );

		textfieldsMana = [
			new Text( timesFont, textLayer ),
			new Text( timesFont, textLayer )
		];
		textfieldsMana[0].textAlign = Right;
		textfieldsMana[0].x = 446;
		textfieldsMana[0].y = 54;
		textfieldsMana[1].textAlign = Right;
		textfieldsMana[1].x = 1582;
		textfieldsMana[1].y = 54;

		overlay = new Object( s2d );
		
		overlayBox = new Graphics( overlay );
		overlayBox.beginFill( 0x000000 );
		overlayBox.drawRect( 0, 0, 100, 100 );
		overlayBox.endFill();
		overlayBox.x = -PADDING;
		overlayBox.y = -PADDING;
		overlayBox.alpha = 0.6;
		
		overlayText = new Text( timesFont, overlay );

		overlay.x = 500;
		overlay.y = 500;
	}

	public function initEntities() {
		for( heartX in heartXs ) hearts.push( entityCreator.createHeart( textLayer, heartX, heartY ));
		for( _ in 0...3 ) heros.push( entityCreator.createHero( herosLayer, 0 ));
		for( _ in 0...3 ) heros.push( entityCreator.createHero( herosLayer, 1 ));
	}

	public function createMobs( frame:FrameViewData ) {
		for( id => coord in frame.positions ) {
			if( id >= 6 ) {
				if( !mobs.exists( id )) {
					final fullHealth = frame.mobHealth.exists( id ) ? frame.mobHealth[id] : 1;
					final mobType = id < 40 ? 0 : id < 75 ? 1 : 2;
					mobs[id] = entityCreator.createMob( mobsLayer, mobType, fullHealth );
				}
			}
		}
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

		final mobPositions = [for( id => coord in frame.positions ) if( id >= 6 ) new Vector( coord.x, coord.y )];

		for( id => coord in frame.positions ) {
			if( id < 6 ) { // hero
				var isAttacking = false;
				final heroPosition = new Vector( coord.x, coord.y );
				for( mobPos in mobPositions ) {
					if( heroPosition.distance( mobPos ) <= Config.HERO_ATTACK_RANGE ) {
						isAttacking = true;
						break;
					}
				}
				place( heros[id], previous.positions[id], frame.positions[id], next.positions[id], subFrame, isAttacking );
			} else {
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

	function place( character:CharacterView, previous:Coord, coord:Coord, next:Coord, subFrame:Float, isAttacking = false ) {
		final dx1 = coord.x - previous.x;
		final dy1 = coord.y - previous.y;
		final dx2 = next.x - coord.x;
		final dy2 = next.y - coord.y;
		
		final easedRotation = quadEaseInOut( Math.min( 1, subFrame * 3 ));
		final easedSubFrame = quadEaseInOut( subFrame );
		
		final angle1 = MathUtils.angle( dx1, dy1 );
		final angle2 = MathUtils.angle( dx2, dy2 );
		final angle = interpolate( angle1, angle2, easedRotation ) + ( isAttacking ? subFrame * TAU : 0 );
		if( isAttacking || dx2 != 0 || dy2 != 0 ) character.rotate( angle);

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

	public function over( screenX:Float, screenY:Float, frame:Float ) {
		overlayText.text = '${hxd.Math.fmt( frame )}';
		adjustBox( screenX, screenY );
	}

	public function mouseOver( screenX:Float, screenY:Float, frame:FrameViewData ) {
		final mapX = ( screenX / App.scaleFactor - X0 ) / scale;
		final mapY = ( screenY / App.scaleFactor - Y0 ) / scale;
		
		final overIds = [];
		for( id => pos in frame.positions ) {
			if( isOver( mapX, mapY, pos )) {
				overIds.push( id );
			}
		}
		if( overIds.length == 0 ) {
			overlayText.text = 'x: ${int( mapX )}\ny: ${int( mapY )}';
		} else {
			var overTexts = [];
			for( id in overIds ) {
				final coord = frame.positions[id];
				if( id < 6 ) {
					overTexts.push( 'HERO $id\nx: ${coord.x}\ny: ${coord.y}' );
				} else {
					final health = frame.mobHealth[id];
					overTexts.push( 'MOB $id\nhealth: $health\nx: ${coord.x}\ny: ${coord.y}' );
				}
			}
			overlayText.text = overTexts.join( "\n" );
		}
		adjustBox( screenX, screenY );
	}
	
	function adjustBox( screenX:Float, screenY:Float ) {
		final boxWidth = overlayText.textWidth + PADDING * 2;
		final boxHeight = overlayText.textHeight + PADDING * 2;
		overlayBox.scaleX = boxWidth / 100;
		overlayBox.scaleY = boxHeight / 100;
		
		overlay.x = screenX + boxWidth < s2d.width ? screenX + 10 : screenX - boxWidth + 10;
		overlay.y = screenY + boxHeight < s2d.height - 10 ? screenY + 20 : screenY - boxHeight + 10;
		overlay.visible = true;
	}

	static inline var OVER_DISTANCE = 400;

	inline function isOver( mouseX:Float, mouseY:Float, c2:Coord ) {
		if( Math.abs( c2.x - mouseX ) < OVER_DISTANCE && Math.abs( c2.y - mouseY ) < OVER_DISTANCE ) return true;
		return false;
	}

}