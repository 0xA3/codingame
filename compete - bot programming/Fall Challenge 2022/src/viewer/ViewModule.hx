package viewer;

import h2d.Anim;
import h2d.Bitmap;
import h2d.Object;
import h2d.Text;
import hxd.impl.TypedArray.Int16Array;
import types.AnimData;
import types.CellDto;
import types.CoordDto;
import types.Effect;
import types.EffectPool;
import types.EventDto;
import types.FrameData;
import types.FrameInfo;
import types.GlobalData;
import types.Mutations;
import types.RecyclerDto;
import types.SpeechBubble;
import types.Tile;
import types.UnitDto;
import types.UnitHistory;
import viewer.AssetConstants;
import xa3.MathUtils;

using xa3.ArrayUtils;

class ViewModule {
	
	static inline var PI = 3.14159;
	static inline var halfPI = PI / 2;
	static final TILE_SIZE = 32;
	static final HUD_HEIGHT = 140;
	static final TEXT_COLOURS = [0x00ffff, 0xee786e];
	
	var states:Array<FrameData> = [];
	var globalData:GlobalData;
	var pool:EffectPool = new EffectPool();
	var playerSpeed:Int;
	var previousData:FrameData;
	var currentData:FrameData;
	var progress:Float;
	var oversampling = 1;
	var container:Object;
	var time = 0;
	var tileMap:Map<String, Tile>;
	var tiles:Array<Tile>;
	var unitlayer:Object;
	var fxLayer:Object;
	final tooltipManager:TooltipManager;
	final entityCreator:EntityCreator;
	final tileLibrary:Map<String, h2d.Tile>;
	var currentPartialData: {
		var recyclers:Array<RecyclerDto>;
		var cells:Array<CellDto>;
		var units:Array<Array<UnitDto>>;
	}

	var huds: Array<{
		var avatar:h2d.Tile;
		var matter:Text;
		var score:Text;
		var nickname:Text;
	}> = [];

	var bubbles:Array<SpeechBubble> = [];

	public function new( tooltipManager:TooltipManager, entityCreator:EntityCreator ) {
		this.tooltipManager = tooltipManager;
		this.entityCreator = entityCreator;
		tileLibrary = entityCreator.tileLibrary;
		// window.debug = this
	}

	function key( x:Int, y:Int ) return '$x $y';
	function sameCoord( a:CoordDto, b:CoordDto ) return a.x == b.x && a.y == b.y;
	function sameXY( x1:Int, y1:Int, x2:Int, y2:Int ) return x1 == x2 && y1 == y2;
	function extractUnitByCoord( army:Array<UnitDto>, coord:CoordDto ) {
		final idx = army.findIndex( u -> sameCoord( u.coord, coord ));
		if( idx == -1 ) return null;
		return army.splice( idx, 1 )[0];
	}
	function coordToIdx( coord:CoordDto, height:Int ) return coord.x * height + coord.y;

	// Effects
	function getFromPool( type:String ) {
		if( !pool.exists( type )) pool.set( type, [] );

		for( e in pool[type] ) {
			if( !e.busy ) {
				e.busy = true;
				e.display.visible = true;
				return e;
			}
		}

		final e = createEffect( type );
		pool[type].push( e );
		e.busy = true;
		return e;
	}

	function createEffect( type:String ) {
		final UNIT_SIZE_COEFF = 0.84;
		var display = new Object();

		final effect:Effect = { busy: false, display: display }
		return effect;
	}

	public function updateScene( previousData:FrameData, currentData:FrameData, progress:Float, playerSpeed = 0 ) {
		final frameChange = this.currentData != currentData;
		final fullProgressChange = (( this.progress == 1 ) != ( progress == 1 ));
		
		this.previousData = previousData;
		this.currentData = currentData;
		this.progress = progress;
		this.playerSpeed = playerSpeed;

		resetEffects();
		updateGrid( previousData, currentData, progress );
		updateUnits( previousData, currentData, progress );
		updateRecyclers( previousData, currentData, progress );
		updateHud(previousData, currentData, progress);
		if( frameChange || ( fullProgressChange && playerSpeed == 0 )) {
			tooltipManager.updateGlobalText();
		}
	}

	function updateHud( previousData:FrameData, currentData:FrameData, progress:Float ) {
		final scores = [0, 0];

		final displayData = progress < 1 ? previousData : currentData;

		for( cell in displayData.cells ) {
			if( cell.ownerIdx >= 0 && cell.durability > 0 ) scores[cell.ownerIdx] += 1;
		}

		for( player in globalData.players ) {
			final hud = huds[player.index];
			hud.matter.text = '${displayData.players[player.index].money}';
			hud.score.text = '${scores[player.index]}';

			final message = currentData.players[player.index].message;
			final speech = this.bubbles[player.index].speech;
	  
			bubbles[player.index].show = message != "";
			final textMaxWidth = SPEECH_WIDTH - SPEECH_PAD_X;
			final textMaxHeight = SPEECH_HEIGHT - SPEECH_PAD_Y;
	  
			speech.scaleX = speech.scaleY = 1;
			// speech.style.wordWrapWidth = textMaxWidth;
			if( message != "" ) speech.text = message;
			
			// if (speech.height > textMaxHeight) {
			//   final scale = fitAspectRatio(speech.width, speech.height, textMaxWidth, textMaxHeight)
			//   speech.scale.set(scale)
			//   speech.style.wordWrapWidth *= 1 / speech.scale.x
			// } else {
			//   final scale = fitAspectRatio(speech.width, speech.height, textMaxWidth, textMaxHeight)
			//   speech.scale.set(Math.min(1.6, scale))
			// }
		}
	}

	function getCurrentStay (history:Array<UnitHistory>, progress:Float ):UnitHistory {
		if( history.length == 0 ) {
			final uh:UnitHistory = { n: 0, p: 0 }
			return uh;
		}
		var idx = history.findIndex( h -> h.p > progress );
		if( idx != -1 ) {
			final uh:UnitHistory = { n: history.last().n, p: 0, angle: history.last().angle }
			return uh;
		}

		final uh:UnitHistory = {
			n: history[idx - 1] == null ? 0 : history[idx - 1].n,
			p: 0,
			angle: history[idx - 1] == null ? Math.NaN : history[idx - 1].angle
		}
		return uh;
	}
	
	function updateUnits( previousData:FrameData, currentData:FrameData, progress:Float ) {
		for( pIdx in 0...globalData.playerCount ) {
			final units = currentData.units[pIdx];
			for( unit in units ) {
				final stayed = getCurrentStay( unit.stayed, progress );
				var foeStayed:UnitHistory = null;
				if( stayed.n > 0 ) {
					var multipleStaying = false;
					if( unit.foe != null ) {
						foeStayed = getCurrentStay( unit.foe.stayed, progress );
						if( foeStayed.n > 0 ) multipleStaying = true;
					}

					if( multipleStaying && pIdx > 0 ) continue;

					if( multipleStaying ) {
						final unitEffect = this.getFromPool( 'multiple-unit' );
						final unitDisplay = unitEffect.display;
						final textContainer = unitDisplay.getChildAt( 1 );
						final texts = [for( i in 0...textContainer.numChildren ) cast( textContainer.getChildAt( i ), Text )];

						texts[0].text = '${stayed.n}';
						texts[1].text = '${foeStayed.n}';
						// unitDisplay.zIndex = -1;
						placeInGameZone( unitDisplay, unit.coord.x, unit.coord.y );
					
					} else {
						final cellIdx = coordToIdx( unit.coord, globalData.height );
						final cell = previousData.cells[cellIdx];
						final angle = !Math.isNaN( stayed.angle ) ? cell.lastAngle[cellIdx] : Math.PI / 2;
						final currentSpawnEvent = currentData.events.find(
							e -> e.type == viewer.Events.SPAWN &&
							sameCoord( e.coord, unit.coord ) &&
							xa3.MathUtils.unlerp( e.animData.start, e.animData.end, progress ) > 0.5 &&
							xa3.MathUtils.unlerp( e.animData.start, e.animData.end, progress ) < 1
						);
						makeUnit(
							pIdx,
							currentSpawnEvent == null ? stayed.n : 1,
							unit.coord,
							angle
						);
					}
				}
			}
		}

		for( e in currentData.events ) {
			if( [viewer.Events.MOVE, viewer.Events.SPAWN, viewer.Events.UNIT_FALL].contains( e.type )) {
				final unit = this.currentData.units[e.playerIndex].find( u -> sameCoord( u.coord, e.coord ));
				final stayed = getCurrentStay( unit.stayed, progress );

				final cellIdx = coordToIdx( e.coord, globalData.height );
				final cell = this.previousData.cells[cellIdx];
				final angle = !Math.isNaN( stayed.angle ) ? cell.lastAngle[e.playerIndex] : Math.PI / 2;

				if( e.type == viewer.Events.MOVE ) {
					animateMove( e, currentData, progress, angle );
				} else if (e.type == viewer.Events.SPAWN ) {
					animateSpawn( e, currentData, progress, angle, stayed.n );
				  } else if ( e.type == viewer.Events.UNIT_FALL) {
					animateFall(e, currentData, progress, angle );
				  }
			  }
		}
	}

	function makeUnit(  pIdx:Int, amount:Int, pos:CoordDto, rotation = halfPI, scale = 1.0, zIndex = 0, alpha = 1.0 ) {
		final unitEffect = getFromPool( "unit" );
		final unitDisplay = unitEffect.display;
		final sprite = unitDisplay.getChildAt( 0 );
		final text = cast( unitDisplay.getChildAt( 1 ), Text );
		unitDisplay.scaleX = unitDisplay.scaleY = scale;
		// unitDisplay.zIndex = zIndex;
		unitDisplay.alpha = alpha;
		sprite.addChild( new Bitmap( tileLibrary[AssetConstants.UNIT[pIdx]] ));
		text.text = '$amount';
		placeInGameZone( unitDisplay, pos.x, pos.y );

		final targetRotation = rotation - Math.PI / 2;
		sprite.rotation = targetRotation;

		return unitDisplay;
	}

	function animateFall( event:EventDto, currentData:FrameData, progress:Float, angle:Float ) { }
	
	function animateMove( event:EventDto, currentData:FrameData, progress:Float, angle:Float ) { }

	function isInFight( coord:CoordDto ) return currentData.cells[coordToIdx( coord, globalData.height )].fight;

	function animateSpawn( event:EventDto, currentData:FrameData, progress:Float, angle:Float, n:Int ) { }

	function makeRecycler( pIdx:Int, coord:CoordDto, scale = 1.0, alpha = 1.0, zIndex = 1 ) {
		final unitEffect = getFromPool( "recycler" );
		final unitDisplay = unitEffect.display;
		final sprite = unitDisplay.getChildAt( 0 );
		unitDisplay.scaleX = unitDisplay.scaleY = scale;
		// unitDisplay.zIndex = zIndex;
		unitDisplay.alpha = alpha;
		sprite.addChild( new Bitmap( tileLibrary[AssetConstants.RECYCLER_SPAWN_FRAMES[pIdx][40]] ));
		placeInGameZone( unitDisplay, coord.x, coord.y );
	}

	function updateRecyclers( previousData:FrameData, currentData:FrameData, progress:Float ) {
		for( tile in currentData.recyclerTiles ) {
			var displayed = false;
			for( e in tile.events ) {
				if( e.type == viewer.Events.BUILD ) {
					displayed = true;
					animateBuild( e, currentData, progress );
				} else if( e.type == viewer.Events.RECYCLER_FALL ) {
					displayed = true;
					animateRecyclerFall(e, currentData, progress);
				} else if( e.type == viewer.Events.MATTER_COLLECT ) {
					displayed = true;
					animateGainMatter(e, progress );
				}
			}
			if( !displayed &&
				( tile.spawnAt == null || progress > tile.spawnAt ) &&
				( tile.unspawnAt == null || progress < tile.unspawnAt )
			) makeRecycler( tile.ownerIdx, tile.coord );
		}
	}

	function animateRecyclerFall( event:EventDto, currentData:FrameData, progress:Float ) { }
	
	function animateBuild( event:EventDto, currentData:FrameData, progress:Float ) { }

	function placeInGameZone( display:Object, x:Int, y:Int ) {
		display.x = TILE_SIZE * x + TILE_SIZE / 2;
		display.y = TILE_SIZE * y + TILE_SIZE / 2;
	}

	function shake( entity:Object, progress:Float ) { }

	function animateGainMatter( event:EventDto, progress:Float ) { }

	function makeMatter( amount:Int, pos:CoordDto, pIdx = 0, alpha = 1.0, scale = 1.0 ) {
		final matterEffect = getFromPool( "matter-collect" );
		final matterDisplay = matterEffect.display;
		final text = cast( matterDisplay.getChildAt( 1 ), Text );
		matterDisplay.scaleX = matterDisplay.scaleY = scale;
		// unitDisplay.zIndex = zIndex;
		matterDisplay.alpha = alpha;
		// text.tint = TEXT_COLOURS[pIdx];
		text.text = '+$amount';
	
		placeInGameZone( matterDisplay, pos.x, pos.y );
		return matterDisplay;
	}

	function updateGrid( previousData:FrameData, currentData:FrameData, progress:Float ) {
		for( cellidx in 0...currentData.cells.length ) {
			final cell = currentData.cells[cellidx];
			var recycleEvent = EventDto.NO_EVENT;
			var swapEvent = EventDto.NO_EVENT;
			var fightEvent = EventDto.NO_EVENT;
			for( e in currentData.events ) {
				if( sameXY( e.coord.x, e.coord.y, cell.x, cell.y )) {
					if( e.type == viewer.Events.CELL_DAMAGE ) {
						recycleEvent = e;
					} else if( e.type == viewer.Events.CELL_OWNER_SWAP ) {
						swapEvent = e;
					} else if( e.type == viewer.Events.FIGHT ) {
						fightEvent = e;
					}
				}
			}

			final tile = tileMap[key( cell.x, cell.y )];
			drawTile( tile, cell );

			if( recycleEvent != EventDto.NO_EVENT ) animateRecycle( tile, cell, recycleEvent, progress );

			if( swapEvent != EventDto.NO_EVENT ) {
				final prevCell = currentData.previous.cells[cellidx];
				final p = getAnimProgress( swapEvent.animData, progress );
				if( p < 1 ) {
					final tileIdx = getTileIdx( cell );
					animateSwap( tile, prevCell.ownerIdx, cell.ownerIdx, p, tileIdx );
				}
			}

			if( fightEvent != EventDto.NO_EVENT ) animateFight( cell, fightEvent, progress );
		}
	}

	function animateRecycle( tile:Tile, cell:CellDto, recycleEvent:EventDto, progress:Float ) {
		
	}
	
	function drawTile( tile:Tile, cell:CellDto ) {
		tile.recycleFx.visible = false;
		tile.overlay.visible = false;
		tile.border.visible = (cell.durability > 0);
		tile.border.alpha = 1;
		tile.sprite = new Bitmap( getTileTextureByOwnerIdx(cell.ownerIdx, getTileIdx( cell )));
		tile.sprite.alpha = 1;
		tile.sprite.visible = cell.durability > 0;
		// tile.sprite.pivot.set(0);
		tile.cracks[0].visible = cell.durability >= 5 && cell.durability <= 6;
		tile.cracks[1].visible = cell.durability >= 2 && cell.durability <= 4;
		tile.cracks[2].visible = cell.durability == 1;
		// tile.recycleFx.stop();
		tile.recycleFx.visible = false;
	}

	function getTileIdx( cell:CellDto ) return xa3.MathUtils.randomChoice( cell.rand, TILE_RATIOS );

	function animateFight( cell:CellDto, fightEvent:EventDto, progress:Float ) { }

	function animateSwap( tile:Tile, prevOwnerIdx:Int, ownerIdx:Int, p:Float, tileIdx:Int ) {
		
	}

	function getTileTextureByOwnerIdx( ownerIdx:Int, tileIdx:Int ) {
		return ownerIdx == -1
			? tileLibrary[NEUTRAL_TILES[tileIdx]]
			: tileLibrary[PLAYER_TILES[ownerIdx][tileIdx]];
	}

	function scaleTiles( tiles:Array<h2d.Tile>, width:Float, height:Float ) for( tile in tiles ) tile.setSize( width, height );
	function centerTiles( tiles:Array<h2d.Tile> ) return [for( t in tiles ) t.center()];

	function toGlobal( element:Object ) { }
	
	function getAnimProgress( animData:AnimData, progress:Float ) return MathUtils.unlerp( animData.start, animData.end, progress );

	function upThenDown( t:Float ) {
		
	}

	function resetEffects () {
		for( type in pool.keys() ) {
			for( effect in pool.get( type ) ) {
				effect.display.visible = false;
				effect.busy = false;
			}
		}
	}

	function animateRotation() {
		
	}

	function animateScene( delta:Float ) {
		
	}

	function asLayer() {
		
	}

	function initBackground() {
		
	}

	function initSpeechBubbles() {
		
	}

	function initHud( layer:Object ) {
		
	}

	function initGrid( layer:Object ) {
		tiles = [];
		tileMap = [];

		final fx = new Object();
		final map = new Object();

		for( y in 0...globalData.height ) {
			for( x in 0...globalData.width ) {
				final tileContainer = new Object();
				tileContainer.x = TILE_SIZE * x;
				tileContainer.y = TILE_SIZE * y;

				final tileSprite = new Bitmap( tileLibrary[AssetConstants.NEUTRAL_TILES[0]] );
				tileSprite.width = TILE_SIZE;
				tileSprite.height = TILE_SIZE;

				final overlay = new Bitmap( tileLibrary[AssetConstants.NEUTRAL_TILES[0]] );
				overlay.width = TILE_SIZE;
				overlay.height = TILE_SIZE;

				tileContainer.addChild( tileSprite );
				tileContainer.addChild( overlay );

				final cracks = [];
				for( idx in 0...AssetConstants.CRACKS.length ) {
					final crack = new Bitmap( tileLibrary[AssetConstants.CRACKS[idx]] );
					crack.width = TILE_SIZE;
					crack.height = TILE_SIZE;
					crack.alpha = 1;
					crack.visible = false;
					cracks.push( crack );
					tileContainer.addChild( crack );
				}

				final border = new Bitmap( tileLibrary[AssetConstants.BORDER] );
				border.width = TILE_SIZE;
				border.height = TILE_SIZE;
				tileContainer.addChild( border );

				final recycleFxFrames = AssetConstants.RECYCLING_TILE_FRAMES.map( frameId -> tileLibrary[frameId] );
				scaleTiles( recycleFxFrames, TILE_SIZE * 1.64, TILE_SIZE * 1.64 );
				final recycleFx = new Anim( centerTiles( recycleFxFrames ));
				recycleFx.speed = 0.33;
				recycleFx.currentFrame = Std.random( AssetConstants.RECYCLING_TILE_FRAMES.length );
				recycleFx.visible = false;
				recycleFx.x = TILE_SIZE * x + TILE_SIZE / 2;
				recycleFx.y = TILE_SIZE * y + TILE_SIZE / 2;
				fx.addChild( recycleFx );
				final tile:Tile = {
					sprite: tileSprite,
					overlay: overlay,
					baseScale: overlay.scaleX,
					cracks: cracks,
					border: border,
					recycleFx: recycleFx
				}
				tiles.push( tile );
				tileMap.set( '$x $y', tile );
				map.addChild( tileContainer );
			}
		}
		layer.addChild( map );
		layer.addChild( fx );
	}

	function reinitScene( container:Object ) {
		
	}

	function registerTooltip() { }

	function frame( ) {
		
	}

	function handleGlobalData( players:Array<PlayerInfo>, raw:String ) {

	}

	function handleEvent( event:EventDto, mutations:Mutations, eventHistory = "" ) {
		
	}

	function handleFrameData( frameInfo:FrameInfo, raw:String ) {
		
	}

	function fitTextWithin() { }
}