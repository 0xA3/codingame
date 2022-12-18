package viewer;

import Std.int;
import game.Coord;
import h2d.Graphics;
import h2d.Object;
import h2d.Scene;
import h2d.Text;
import view.FrameViewDataset;
import viewer.App;
import viewer.EntityCreator;

using xa3.MathUtils;

class GameView {
	
	public static inline var X0 = 48;
	public static inline var Y0 = 116;
	
	static inline var PADDING = 4;

	public static final TAU = 2 * Math.PI;
	public static final HPI = Math.PI / 2;
	static final scale = 1.; //App.CANVAS_WIDTH / Config.MAP_WIDTH;
	public static function sX( x:Float ) return x * scale + X0;
	public static function sY( y:Float ) return y * scale + Y0;

	final s2d:Scene;

	public final scene:Object;
	final entityCreator:EntityCreator;
	
	final backgroundLayer:Object;
	final gridLayer:Object;
		final tileLayer:Object;
		final robotLayer:Object;
		final recyclerLayer:Object;
	final hudLayer:Object;
	final textLayer:Object;

	final textfieldsMatter:Array<Text> = [];
	final textfieldsTiles:Array<Text> = [];
	final overlay:Object;
	final overlayBox:Graphics;
	final overlayText:Text;

	public var isMouseDown = false;

	public function new( s2d:Scene, scene:Object, entityCreator:EntityCreator ) {
		this.s2d = s2d;
		this.scene = scene;
		this.entityCreator = entityCreator;

		backgroundLayer = new Object( scene );
		gridLayer = new Object( scene );
		tileLayer = new Object( gridLayer );
		robotLayer = new Object( gridLayer );
		recyclerLayer = new Object( gridLayer );
		hudLayer = new Object( scene );
		textLayer = new Object( scene );
		
		overlay = new Object( s2d );
		overlayBox = new Graphics( overlay );
		overlayText = new Text( entityCreator.timesFont, overlay );
	}

	public function init( player1:String, player2:String ) {
		entityCreator.createPlayerNameTextfields( textLayer, player1, player2 );
		textfieldsMatter.push( new Text( entityCreator.lato_bold_44, textLayer ));
		textfieldsMatter.push( new Text( entityCreator.lato_bold_44, textLayer ));

		textfieldsMatter[0].x = 564;	textfieldsMatter[1].x = 		1414;
		textfieldsMatter[0].textAlign = textfieldsMatter[1].textAlign = Right;
		textfieldsMatter[0].textColor = textfieldsMatter[1].textColor = 0xd5c8c8;
		textfieldsMatter[0].y = 		textfieldsMatter[1].y = 		6;
		textfieldsMatter[0].text = 		textfieldsMatter[1].text = 		"0";
		
		textfieldsTiles.push( new Text( entityCreator.lato_bold_64, textLayer ));
		textfieldsTiles.push( new Text( entityCreator.lato_bold_64, textLayer ));

		textfieldsTiles[0].x = 718;		textfieldsTiles[1].x = 			1282;
		textfieldsTiles[0].textAlign =	textfieldsTiles[1].textAlign =	Right;
		textfieldsTiles[0].y = 			textfieldsTiles[1].y =			18;
		textfieldsTiles[0].text = 		textfieldsTiles[1].text = 		"0";

		overlayBox.beginFill( 0x000000 );
		overlayBox.drawRect( 0, 0, 100, 100 );
		overlayBox.endFill();
		overlayBox.x = -PADDING;
		overlayBox.y = -PADDING;
		overlayBox.alpha = 0.6;
		overlayBox.visible = false;
		
		overlay.x = 500;
		overlay.y = 500;

		entityCreator.createHUD( backgroundLayer, hudLayer, textLayer );
		initEntities();
	}

	public function initEntities() {
	}

	public function addFrameViewData( frame:Int, currentFrameData:FrameViewDataset ) {
		updatePositions( frame, currentFrameData );
	}

	function updatePositions( frame:Int, currentFrameData:FrameViewDataset ) {
	}

	public function update( frame:Float, intFrame:Int, subFrame:Float, frameDatasets:Array<FrameViewDataset> ) {
		final currentFrameData = frameDatasets[intFrame];

	}

	public function mouseOver( screenX:Float, screenY:Float, currentFrameData:FrameViewDataset ) {
		final mapX = ( screenX / App.scaleFactor - X0 ) / scale;
		final mapY = ( screenY / App.scaleFactor - Y0 ) / scale;
		
		/*
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
				overTexts.push( 'OverText ${screenX}:${screenY}' );
			}
			overlayText.text = overTexts.join( "\n" );
		}
		adjustBox( screenX, screenY );
		*/
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