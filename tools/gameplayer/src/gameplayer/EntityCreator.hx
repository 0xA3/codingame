package gameplayer;

import Std.int;
import gameplayer.view.ClickButton;
import gameplayer.view.Slider;
import gameplayer.view.SwitchButton;
import gameplayer.view.Tooltip;
import h2d.Bitmap;
import h2d.Interactive;
import h2d.Object;
import h2d.Text;
import h2d.Tile;
import haxe.Json;
import hxd.Window;

class EntityCreator {
	
	public static function populateLibrary( window:Window, container:Object, library:GameplayerLibrary ) {
		library.gameplayerContainer = container;
		createBackground( container, library );
		createButtons( container, library );
		createTextfield( container, library );
		createSlider( window, container, library );
		createTooltip( window, container, library );
	}

	public static function createBackground( container:Object, library:GameplayerLibrary ) {
		final background = new Object( container );
		final rectangle = new h2d.Graphics( background );
		rectangle.beginFill( 0x252e38 );
		rectangle.drawRect( 0, 0, 800, 44 );
		rectangle.endFill();
		rectangle.y = -44;

		library.gameplayerBackground = background;
	}

	public static function createButtons( container:Object, library:GameplayerLibrary ) {
		final buttonsMap = Json.parse( hxd.Res.load( "gameplayer/buttons_map.json" ).toText() );
		final buttonsTile = hxd.Res.gameplayer.buttons.toTile();

		final rewind = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.end.frame ));
		final prev = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.next.frame ));
		final pause = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.pause.frame ));
		final play = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.play.frame ));
		final next = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.next.frame ));
		final end = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.end.frame ));
		final handle = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.drag.frame ));
		final tooltipArrow = new Bitmap( createSubTile( buttonsTile, buttonsMap.frames.tooltip_arrow.frame ));
		
		rewind.scaleX = -1;
		prev.scaleX = -1;
		pause.visible = false;
		
		final bContainers = [];
		for( i in 0...5 ) {
			final bContainer = new Object( container );
			bContainer.x = 10 + 30 * i;
			bContainer.y = -34;
			bContainers.push( bContainer );
		}
		final interactives = [];
		for( _ in 0...5 ) {
			final interactive = new Interactive( 28, 24 );
			interactives.push( interactive );
		}
		
		library.bRewind = createClickButton( bContainers[0], interactives[0], rewind );
		library.bPrev = createClickButton( bContainers[1], interactives[1], prev );
		library.bPlay = createSwitchButton( bContainers[2], interactives[2], pause, play );
		library.bNext = createClickButton( bContainers[3], interactives[3], next );
		library.bEnd = createClickButton( bContainers[4], interactives[4], end );
		library.handle = handle;
		library.tooltipArrow = tooltipArrow;
	}

	static function createSubTile( tile:Tile, frame:{ x:Int, y:Int, w:Int, h:Int } ) {
		return tile.sub( frame.x, frame.y, frame.w, frame.h );
	}

	static function createClickButton( container:Object, interactive:Interactive, bitmap:Bitmap ) {
		centerBitmap( interactive.width, interactive.height, bitmap );
		container.addChild( bitmap );
		container.addChild( interactive );
		// createVisualClickArea( container, interactive );
		
		return new ClickButton( container, interactive, bitmap );
	}

	static function createSwitchButton( container:Object, interactive:Interactive, bitmap1:Bitmap, bitmap2:Bitmap ) {
		centerBitmap( interactive.width, interactive.height, bitmap1 );
		centerBitmap( interactive.width, interactive.height, bitmap2 );
		container.addChild( bitmap1 );
		container.addChild( bitmap2 );
		container.addChild( interactive );
		// createVisualClickArea( container, interactive );

		return new SwitchButton( container, interactive, bitmap1, bitmap2 );
	}

	static function centerBitmap( width:Float, height:Float, bitmap:Bitmap ) {
		bitmap.x = bitmap.scaleX > 0
		? int( width / 2 - bitmap.tile.width / 2 )
		: int( width / 2 + bitmap.tile.width / 2 );
		
		bitmap.y = height / 2 - bitmap.tile.height / 2;
	};

	static function createVisualClickArea( container:Object, interactive:Interactive ) {
		final rectangle = new h2d.Graphics( container );
		rectangle.beginFill( 0x00ffff );
		rectangle.drawRect( 0, 0, interactive.width, interactive.height );
		rectangle.endFill();
		rectangle.alpha = 0.25;
	}

	static function createTextfield( container:Object, library:GameplayerLibrary ) {
		var font = hxd.Res.gameplayer.OpenSans10.toFont();
		var textfield = new h2d.Text( font, container );
		textfield.x = 170;
		textfield.y = -33;
		textfield.text = "0/0";

		library.frameCounter = textfield;
	}

	static function createSlider( window:Window, container:Object, library:GameplayerLibrary ) {
		final sliderContainer = new Object( container );
		sliderContainer.y = -44;

		final barHeightContainer = new Object( sliderContainer );
		final backgroundContainer = new Object( barHeightContainer );
		var rectangle = new h2d.Graphics( backgroundContainer );
		rectangle.beginFill( 0x3f4446 );
		rectangle.drawRect( 0, 0, 800, 8 );
		rectangle.endFill();
		rectangle.y = -8;
		
		final barContainer = new Object( barHeightContainer );
		final bar = new Object( barContainer );
		final rectangle2 = new h2d.Graphics( bar );
		rectangle2.beginFill( 0xf2bb13 );
		rectangle2.drawRect( 0, 0, 800, 8 );
		rectangle2.endFill();
		rectangle2.y = -8;

		final barInteractiveContainer = new Object( sliderContainer );
		barInteractiveContainer.y = -14;
		final barInteractive = new Interactive( 800, 20, barInteractiveContainer );
		
		final handleContainer = new Object( sliderContainer );
		handleContainer.y = -4;
		
		final handle = library.handle;
		// handle.x = -handle.tile.width / 2;
		handle.tile.setCenterRatio();
		handle.y = -4;
		sliderContainer.addChild( handle );

		library.sliderContainer = sliderContainer;
		library.slider = new Slider(
			window,
			barHeightContainer,
			backgroundContainer,
			barContainer,
			barInteractiveContainer,
			handle,
			barInteractive
		);
	}

	static function createTooltip( window:Window, container:Object, library:GameplayerLibrary ) {
		final tooltipArrow = library.tooltipArrow;
		tooltipArrow.tile.setCenterRatio( 0.5, 1 );
		tooltipArrow.y = -62;
		tooltipArrow.visible = false;
		container.addChild( tooltipArrow );

		final tooltipContainer = new Object( container );
		tooltipContainer.y = -96;
		final rectangle3 = new h2d.Graphics( tooltipContainer );
		rectangle3.beginFill( 0xf2bb13 );
		rectangle3.drawRect( 0, 0, 70, 28 );
		rectangle3.endFill();
		final tooltipText = new Text( hxd.Res.gameplayer.OpenSans9.toFont(), tooltipContainer );
		tooltipText.textAlign = Center;
		tooltipText.text = "0/0";
		tooltipText.textColor = 0x252e38;
		tooltipText.maxWidth = 70;
		tooltipText.y = 5;
		
		library.tooltip = new Tooltip(
			window,
			tooltipArrow,
			tooltipContainer,
			tooltipText
		);
	}
}