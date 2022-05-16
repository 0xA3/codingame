package viewer;

import Std.int;
import game.Config;
import game.Vector;
import h2d.Anim;
import h2d.Bitmap;
import h2d.Graphics;
import h2d.Object;
import h2d.Scene;
import h2d.Text;
import view.Coord;
import view.FrameViewData;
import viewer.App;
import viewer.CharacterView;
import viewer.EntityCreator;

using xa3.MathUtils;

class GameView {
	
	public static inline var X0 = 48;
	public static inline var Y0 = 116;
	
	static inline var PADDING = 4;

	public static final TAU = 2 * Math.PI;
	public static final HPI = Math.PI / 2;
	static final scale = App.CANVAS_WIDTH / Config.MAP_WIDTH;
	public static function sX( x:Float ) return x * scale + X0;
	public static function sY( y:Float ) return y * scale + Y0;

	final s2d:Scene;

	final timesFont = hxd.Res.times_new_roman_bold.toFont();
	final lifeY = -30;
	final lifeXs = [147, 181, 215, 1416, 1450, 1484];

	public final scene:Object;
	final entityCreator:EntityCreator;
	
	final backgroundLayer:Object;
	final mobsLayer:Object;
	final herosLayer:Object;
	final hudLayer:Object;
	final textLayer:Object;

	final textfieldsMana:Array<Text> = [];
	final overlay:Object;
	final overlayBox:Graphics;
	final overlayText:Text;

	final heros:Array<HeroView> = [];
	final mobs:Map<Int, MobView> = [];
	final lifes:Array<Anim> = [];
	
	public var isMouseDown = false;

	public function new( s2d:Scene, scene:Object, entityCreator:EntityCreator ) {
		this.s2d = s2d;
		this.scene = scene;
		this.entityCreator = entityCreator;

		backgroundLayer = new Object( scene );
		mobsLayer = new Object( scene );
		herosLayer = new Object( scene );
		hudLayer = new Object( scene );
		textLayer = new Object( scene );
		overlay = new Object( s2d );
		overlayBox = new Graphics( overlay );
		overlayText = new Text( timesFont, overlay );
	}

	public function init( player1:String, player2:String ) {
		final textPlayer1 = new Text( entityCreator.timesBold40, textLayer );
		final textPlayer2 = new Text( entityCreator.timesBold40, textLayer );
		textPlayer1.textAlign = Center;
		textPlayer2.textAlign = Center;
		textPlayer1.x = 324;
		textPlayer2.x = 1594;
		textPlayer1.y = textPlayer2.y = -2;
		textPlayer1.text = player1;
		textPlayer2.text = player2;

		final textLife1 = new Text( entityCreator.times31, textLayer );
		final textLife2 = new Text( entityCreator.times31, textLayer );
		textLife1.x = 157;
		textLife2.x = 1426;
		textLife1.y = textLife2.y = 63;
		textLife1.text = textLife2.text = "Life";

		final textMana1 = new Text( entityCreator.times31, textLayer );
		final textMana2 = new Text( entityCreator.times31, textLayer );
		textMana1.x = 356;
		textMana2.x = 1626;
		textMana1.y = textMana2.y = 63;
		textMana1.text = textMana2.text = "Mana";

		textfieldsMana.push( new Text( entityCreator.times48, textLayer ));
		textfieldsMana.push( new Text( entityCreator.times48, textLayer ));
		
		for( textfield in textfieldsMana ) {
			textfield.textAlign = Right;
			textfield.textColor = 0x000b5fc;
		}
		textfieldsMana[0].textAlign = Right;
		textfieldsMana[1].textAlign = Right;
		textfieldsMana[0].x = 493;
		textfieldsMana[1].x = 1765;
		textfieldsMana[0].y = textfieldsMana[1].y = 54;

		overlayBox.beginFill( 0x000000 );
		overlayBox.drawRect( 0, 0, 100, 100 );
		overlayBox.endFill();
		overlayBox.x = -PADDING;
		overlayBox.y = -PADDING;
		overlayBox.alpha = 0.6;
		
		overlay.x = 500;
		overlay.y = 500;

		entityCreator.createHUD( backgroundLayer, mobsLayer, herosLayer, hudLayer, textLayer );
		initEntities();
	}

	public function initEntities() {
		for( lifeX in lifeXs ) {
			final lifeAni = entityCreator.createLife( hudLayer, lifeX, lifeY );
			lifeAni.loop = false;
			lifes.push( lifeAni );
		}
		for( _ in 0...3 ) heros.push( entityCreator.createHero( herosLayer, 0 ));
		for( _ in 0...3 ) heros.push( entityCreator.createHero( herosLayer, 1 ));
	}

	public function createMobs( currentFrame:Int, currentFrameData:FrameViewData ) {
		for( id => coord in currentFrameData.positions ) {
			if( id >= 6 ) {
				if( !mobs.exists( id )) {
					final fullHealth = currentFrameData.mobHealth.exists( id ) ? currentFrameData.mobHealth[id] : 1;
					final mobType = id < 40 ? 0 : id < 75 ? 1 : 2;
					mobs[id] = entityCreator.createMob( mobsLayer, mobType, fullHealth );
				}
			}
		}
	}

	public function update( currentFrame:Int, subFrame:Float, frameDatasets:Array<FrameViewData> ) {
		final previousFrame = Std.int( Math.max( 0, currentFrame - 1 ));
		final nextFrame = Std.int( Math.min( frameDatasets.length - 1, currentFrame + 1 ));
		
		final currentFrameData = frameDatasets[currentFrame];
		final previousFrameData = frameDatasets[previousFrame];
		final nextFrameData = frameDatasets[nextFrame];

		for( mobView in mobs ) mobView.hide();

		for( i in 0...currentFrameData.mana.length ) {
			textfieldsMana[i].text = '${currentFrameData.mana[i]}';
		}
		
		for( i in 0...currentFrameData.baseHealth.length ) {
			final lifeStart = i * 3;
			final baseHealth = currentFrameData.baseHealth[i];
			lifes[lifeStart].visible = baseHealth > 0;
			lifes[lifeStart + 1].visible = baseHealth > 1;
			lifes[lifeStart + 2].visible = baseHealth > 2;
		}

		final mobPositions = [for( id => coord in currentFrameData.positions ) if( id >= 6 ) new Vector( coord.x, coord.y )];

		for( id => coord in currentFrameData.positions ) {
			if( id < 6 ) { // hero
				var isAttacking = false;
				final heroPosition = new Vector( coord.x, coord.y );
				for( mobPos in mobPositions ) {
					if( heroPosition.distance( mobPos ) <= Config.HERO_ATTACK_RANGE ) {
						isAttacking = true;
						break;
					}
				}
				place( heros[id], previousFrameData.positions[id], currentFrameData.positions[id], nextFrameData.positions[id], subFrame, isAttacking );
			} else {
				final previousCoord = previousFrameData.positions.exists( id ) ? previousFrameData.positions[id] : coord ;
				final nextCoord = nextFrameData.positions.exists( id ) ? nextFrameData.positions[id] : coord;
				
				final mobView = mobs[id];
				if( currentFrameData.mobHealth.exists( id )) {
					final health = currentFrameData.mobHealth[id];
					if( health > 0 ) {
						mobView.show();
						mobView.setHealth( currentFrameData.mobHealth[id] );
					}
				}
				
				place( mobView, previousCoord, coord, nextCoord, subFrame );
				mobView.animate( currentFrame + subFrame );
			}
		}
		for( id => message in currentFrameData.messages ) {
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
		if( isAttacking || dx2 != 0 || dy2 != 0 ) character.rotate( angle );

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

	public function mouseOver( screenX:Float, screenY:Float, currentFrameData:FrameViewData ) {
		final mapX = ( screenX / App.scaleFactor - X0 ) / scale;
		final mapY = ( screenY / App.scaleFactor - Y0 ) / scale;
		
		final overIds = [];
		for( id => pos in currentFrameData.positions ) {
			if( isOver( mapX, mapY, pos )) {
				overIds.push( id );
			}
		}
		if( overIds.length == 0 ) {
			overlayText.text = 'x: ${int( mapX )}\ny: ${int( mapY )}';
		} else {
			var overTexts = [];
			for( id in overIds ) {
				final coord = currentFrameData.positions[id];
				if( id < 6 ) {
					overTexts.push( 'HERO $id\nx: ${coord.x}\ny: ${coord.y}' );
				} else {
					final health = currentFrameData.mobHealth[id];
					overTexts.push( 'MOB $id\nhealth: $health\nx: ${coord.x}\ny: ${coord.y}' );
				}
			}
			overlayText.text = overTexts.join( "\n" );
		}
		adjustBox( screenX, screenY );
	}

	public function mouseOut() {
		if( overlay.visible == true ) overlay.visible = false;
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