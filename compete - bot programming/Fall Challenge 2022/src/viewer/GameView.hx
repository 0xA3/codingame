package viewer;

import Std.int;
import game.Coord;
import h2d.Anim;
import h2d.Bitmap;
import h2d.Graphics;
import h2d.Object;
import h2d.Scene;
import h2d.Text;
import view.FrameViewDataset;
import viewer.App;
import viewer.AssetConstants;
import viewer.EntityCreator;

using Lambda;
using xa3.MathUtils;

class GameView {
	
	static final TILE_SIZE = 128;
	static final HALF_TILE = TILE_SIZE / 2;
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
	final tileLibrary:Map<String, h2d.Tile>;
	
	final backgroundLayer:Object;
	final mapLayer:Object;
		final tileLayer:Object;
		final robotLayer:Object;
		final recyclerLayer:Object;
	final hudLayer:Object;
	final textLayer:Object;

	final textfieldsMatter:Array<Text> = [];
	final textfieldsOwnedCells:Array<Text> = [];
	final overlay:Object;
	final overlayBox:Graphics;
	final overlayText:Text;
	
	final tileViews:Array<TileView> = [];
	final robotViews:Array<Array<RobotView>> = [[],[]];
	final recyclerViews:Array<Array<RecyclerView>> = [[],[]];

	var gridWidth:Int;
	var gridHeight:Int;

	public var isMouseDown = false;
	var lastFrame = -1;

	public function new( s2d:Scene, scene:Object, entityCreator:EntityCreator ) {
		this.s2d = s2d;
		this.scene = scene;
		this.entityCreator = entityCreator;
		tileLibrary = entityCreator.tileLibrary;

		backgroundLayer = new Object( scene );
		mapLayer = new Object( scene );
			tileLayer = new Object( mapLayer );
			robotLayer = new Object( mapLayer );
			recyclerLayer = new Object( mapLayer );
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
		
		textfieldsOwnedCells.push( new Text( entityCreator.lato_bold_64, textLayer ));
		textfieldsOwnedCells.push( new Text( entityCreator.lato_bold_64, textLayer ));

		textfieldsOwnedCells[0].x = 718;		textfieldsOwnedCells[1].x = 			1282;
		textfieldsOwnedCells[0].textAlign =	textfieldsOwnedCells[1].textAlign =	Right;
		textfieldsOwnedCells[0].y = 			textfieldsOwnedCells[1].y =			18;
		textfieldsOwnedCells[0].text = 		textfieldsOwnedCells[1].text = 		"0";

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
	}
	
	public function initGrid( gridWidth:Int, gridHeight:Int ) {
		this.gridWidth = gridWidth;
		this.gridHeight = gridHeight;
		
		mapLayer.x = 180;
		mapLayer.y = 220;
		final tilesPerWidth = 1560 / TILE_SIZE;
		
		mapLayer.scaleX = mapLayer.scaleY = tilesPerWidth / gridWidth;
		trace( tilesPerWidth, mapLayer.scaleX );
		for( y in 0...gridHeight ) {
			for( x in 0...gridWidth ) {
				final tileContainer = new Object( tileLayer );
				tileContainer.x = TILE_SIZE * x;
				tileContainer.y = TILE_SIZE * y;

				final spriteContainer = new Object( tileContainer );
				final tileId = Std.random( AssetConstants.NEUTRAL_TILES.length );
				final tileSprite = new Bitmap( tileLibrary[NEUTRAL_TILES[tileId]] );
				tileSprite.width = TILE_SIZE;
				tileSprite.height = TILE_SIZE;

				final overlay = new Bitmap( tileLibrary[AssetConstants.NEUTRAL_TILES[0]] );
				overlay.width = TILE_SIZE;
				overlay.height = TILE_SIZE;

				
				final border = new Bitmap( tileLibrary[AssetConstants.BORDER] );
				border.width = TILE_SIZE;
				border.height = TILE_SIZE;

				final crackTiles = viewer.AssetConstants.CRACKS.map( tileName -> tileLibrary[tileName] );
				crackTiles.iter( tile -> tile.scaleToSize( TILE_SIZE, TILE_SIZE ));
				final crackBitmaps = crackTiles.map( crackTile -> new Bitmap( crackTile ));
				// crackBitmaps.iter( crackBitmap -> crackBitmap.visible = false );

				spriteContainer.addChild( tileSprite );
				// tileContainer.addChild( overlay );
				// tileContainer.addChild( border );
				crackBitmaps.iter( crackBitmap -> tileContainer.addChild( crackBitmap ));

				tileViews.push({
					container: tileContainer,
					spriteContainer: spriteContainer,
					tileId: tileId,
					sprite: tileSprite,
					overlay: overlay,
					border: border,
					cracks: crackBitmaps
				});
			}
		}
	}

	public function update( frame:Float, intFrame:Int, subFrame:Float, frameDatasets:Array<FrameViewDataset> ) {
		if( intFrame != lastFrame ) {
			final currentFrameData = frameDatasets[intFrame];
			updateFrame( intFrame, currentFrameData );
			lastFrame = intFrame;
		}
	}

	public function updateFrame( frame:Int, currentFrameData:FrameViewDataset ) {
		for( i in 0...currentFrameData.players.length ) {
			final player = currentFrameData.players[i];
			textfieldsMatter[i].text = '${player.money}';
			textfieldsOwnedCells[i].text = '${player.ownedCells}';
		}

		var playerRobotCounts = [0, 0];
		var playerRecyclerCounts = [0, 0];
		for( i in 0...currentFrameData.cellDatasets.length ) {
			updateTile( currentFrameData.cellDatasets[i], tileViews[i] );
			final cell = currentFrameData.cellDatasets[i];
			if( cell.unitStrength > 0 ) updateRobot( cell, playerRobotCounts );
			if( cell.excavator ) updateRecycler( cell, playerRecyclerCounts );
			
		}

		for( playerId in 0...currentFrameData.players.length ) {
			for( robotId in playerRobotCounts[playerId]...robotViews[playerId].length ) {
				robotViews[playerId][robotId].container.visible = false;
			}
			for( recyclerId in playerRecyclerCounts[playerId]...recyclerViews[playerId].length ) {
				recyclerViews[playerId][recyclerId].container.visible = false;
			}
		}
	}

	function updateTile( cell:CellDataset, tile:TileView ) {
		tile.border.visible = ( cell.durability > 0) ;
		tile.spriteContainer.removeChild( tile.sprite );
		tile.sprite = new Bitmap( getTileTextureByOwnerIdx( cell.ownerIdx, tile.tileId ));
		tile.sprite.visible = cell.durability > 0;
		tile.spriteContainer.addChild( tile.sprite );
		tile.cracks[0].visible = cell.durability >= 5 && cell.durability <= 6;
		tile.cracks[1].visible = cell.durability >= 2 && cell.durability <= 4;
		tile.cracks[2].visible = cell.durability == 1;
	}

	function updateRobot( cell:CellDataset, playerRobotCounts:Array<Int> ) {
		final playerId = cell.ownerIdx;
		final robotId = playerRobotCounts[playerId];
		final robotArray = robotViews[playerId];
		if( robotId >= robotArray.length ) {
			final robotView = entityCreator.createRobot( playerId );
			robotLayer.addChild( robotView.container );
			robotArray.push( robotView );
		}
		
		final robotView = robotArray[robotId];
		robotView.container.visible = true;
		robotView.container.x = cell.x * TILE_SIZE + HALF_TILE;
		robotView.container.y = cell.y * TILE_SIZE + HALF_TILE;
		robotView.text.text = '${cell.unitStrength}  ${cell.x}:${cell.y}';
		playerRobotCounts[playerId]++;
	}

	function updateRecycler( cell:CellDataset, playerRecyclerCounts:Array<Int> ) {
		final playerId = cell.ownerIdx;
		final recyclerId = playerRecyclerCounts[playerId];
		final recyclerArray = recyclerViews[playerId];
		if( recyclerId >= recyclerArray.length ) {
			final recyclerView = entityCreator.createRecycler( playerId );
			recyclerLayer.addChild( recyclerView.container );
			recyclerArray.push( recyclerView );
		}
		
		final recyclerView = recyclerArray[recyclerId];
		recyclerView.container.visible = true;
		recyclerView.container.x = cell.x * TILE_SIZE + HALF_TILE;
		recyclerView.container.y = cell.y * TILE_SIZE + HALF_TILE;
		playerRecyclerCounts[playerId]++;
	}

	function getTileIdx( cell:CellDataset ) return xa3.MathUtils.randomChoice( 4, TILE_RATIOS );
	
	function getTileTextureByOwnerIdx( ownerIdx:Int, tileIdx:Int ) {
		return ownerIdx == -1
			? tileLibrary[NEUTRAL_TILES[tileIdx]]
			: tileLibrary[PLAYER_TILES[ownerIdx][tileIdx]];
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

	function posToIdx( x:Int, y:Int, height:Int ) return y * height + x;
}