package resources.view;

import gameengine.view.core.Point;
import h2d.Object;
import h2d.Text;
import h2d.Tile;
import main.event.EventData;
import main.view.CellData;
import main.view.FrameViewData;
import main.view.GlobalViewData;
import resources.view.GameConstants.POINTS;
import resources.view.PathSegments.computePathSegments;
import resources.view.Types;
import resources.view.Utils.sum;

using Lambda;

typedef EffectPool = Map<String, Array<Effect<Tile>>>;

typedef Api = {
	var options:{
		var debugMode:Bool;
		var seeAnts:Bool;
	}
	var ?setDebug:()->Void;
	var ?seeAnts:( v:Bool )->Void;
}

typedef Hud = {
	var bar:Tile;
	var avatar:Tile;
	var ants:Text;
	var nickname:Text;
	var message:Text;
	var score:Text;
	var targetBarX:Int;
}

typedef ParticleGroup = {
	var particleGroups:Array<AntParticleGroup>;
	var particleGroupByTile:Map<Int, AntParticleGroup>;
	var particleGroupByMoveTo:Map<Int, Array<AntParticleGroup>>;
}

class ViewModule {
	static final CONVEYOR_SCALE = 0.21;
	static final MAX_PARTICLES_PER_GROUP = 8;
	static final ARROW_FADE_OUT_P = 0.8;
	static final XPLODE_PARTICLE_COUNT = 80;
	static final XPLODE_DURATION = 1000;
	static final THRESHOLD_TRIPLE = 50;
	static final THRESHOLD_DOUBLE = 20;
	static final EGG_COLORS = [0x01e31d, 0xb5b1b2];
	static final CRYSTAL_COLORS = [0xfdf100, 0xe86a02];

	static final MESSAGE_RECT = {
		x:130,
		y:80,
		w:688,
		h:42
	}

	var api:Api = {
		options:{
			debugMode: true,
			seeAnts: false
		}
	}

	var states:Array<FrameData> = [];
	var globalData:GlobalData;
	var pool:EffectPool = [];
	var playerSpeed:Int;
	var previousData:FrameData;
	var currentData:FrameData;
	var progress:Float;
	var oversampling:Int;
	var container:Object;
	var time = 0;
	final tooltipManager = new TooltipManager();
  
	var antParticleLayer:Object;
	var boardOverlay:Object;
	var boardLayer:Object;
  
	var huds:Array<Hud> = [];

	var scoreBar:Tile;

	var hexes:Map<Int, Hex>;
	var beacons:Map<Int, Tile>;
	var currentTempCellData:{ ants:Array<Array<Int>>, beacons:Array<Array<Int>>, richness:Array<Int> }
	var tiles:Map<String, Tile>;

	var particleGroupsByPlayer:Array<ParticleGroup>;

	var overlay:Tile;
	var conveyors:Array<Tile>;
	var conveyorLayer:Object;
	var beaconLayer:Object;
	var arrowLayer:Object;
	var particleLayer:Object;
	var counterLayer:Object;
	var distanceBetweenHexes:Int;
	var explosions:Array<Explosion> = [];

	final tileLibrary:Map<String, h2d.Tile> = [];

	public function new() {
		CreateTiles.create( tileLibrary, hxd.Res.ants.spritesheet_png.toTile(), hxd.Res.load( "ants/spritesheet.json" ).toText() );
	}

	// Effects
	function getFromPool<T>( type:String ) {
	}

	function createEffect<T>() {
		// not important
	}

	public function updateScene( previousData:FrameData, currentData:FrameData, progress:Float, playerSpeed = 0 ) {
		final lastShownData = this.currentData;
		final frameChange = lastShownData != currentData;
		final fullProgressChange = (this.progress == 1) != (progress == 1);
		this.previousData = previousData;
		this.currentData = currentData;
		this.progress = progress;
		this.playerSpeed = playerSpeed;

		// reset zIndex
		for( index => hex in hexes ) {
			// if( hex.icon != null ) hex.iconBounceContainer.zIndex = 1;
			// hex.indicatorLayer.zIndex = 2;
		}

		// resetEffects()
		updateTiles();
		updateBeacons();
		updateMoves();
		updateGains();
		// updateExplosions()
		// updateParticles(frameChange, lastShownData)
		updateHud();
		if (frameChange || (fullProgressChange && playerSpeed == 0)) {
			tooltipManager.updateGlobalText();
		}
	}

	function destroyParticles() {
		// not important
	}

	function resetParticles() {
		// not important
	}

	function updateParticles() {
		// not important
	}

	function drawParticleGroup() {
		// not important
	}

	function showPlayerDebug() {
		// return api.options.debugMode == true || api.options.debugMode == playerIdx;
	}

	function updateMoves() {
		// for( event in currentData.events.filter( type -> type == EventData.MOVE )) {
		// 	if( !showPlayerDebug( event.playerIdx )) {
		// 		continue;
		// 	}

		// 	final p = genAnimProgress( event.animData, progress );
		// 	if( p < 0 || p > 1 ) {
		// 		continue;
		// 	}

		// 	final fromIdx = event.cellIdx;
		// 	final toIdx = event.targetIdx;
		// 	final amount = event.amount;
		// 	final playerIdx = event.playerIdx;


			// ...
		// }
	}

	function updateExplosions () {
	}

	function updateGains () {
		
	}

	function screenToBoard( point:Point ):Point {
		return {
			x:point.x + boardLayer.x,
			y:point.y + boardLayer.y
		}
	}

	function getLastEventEndP( eventType:Int ) {

	}

	function getLastMoveEndP() {
		// return getLastEventEndP( EventData.MOVE );
	}
	
	function getLastFoodEndP() {
		// return getLastEventEndP( EventData.FOOD );
	}

	function getLastBuildEndP() {
		// return getLastEventEndP( EventData.BUILD );
	}
	
	function getOwnersOfBeaconOn( cellIdx:Int, data:FrameData ) {
	}

	function updateBeacons() {
		
	}

	function updateTiles() {
		
	}

	function updateHud() {
		
	}

	function shake( entity:Tile, progress:Float ) {
		
	}

	function toGlobal() {
		
	}

	function getAnimProgress() {
		
	}

	function upThenDown() {
		
	}

	function resetEffects() {
		
	}

	function animateRotation() {
		
	}

	function animateScoreBar() {
		
	}

	function animateScene( delta:Float ) {
		
	}

	function farFromOne() {
		
	}

	function animateTiles() {
		
	}

	function animateParticleGroups() {
		
	}

	function animateConveyors() {
		
	}

	function animateAntParticles() {
		
	}

	function asLayer() {
		
	}

	function drawTile( cell:CellData ) {
		// final tile = Tile.from( "case.png" );
	}

	function initBackground() {
		
	}

	function initBeacons() {
		
	}

	function centerLayer() {
		
	}

	public function initBoard( layer:Object ) {
		// tiles.clear();
		// for( cell in globalData.cells ) {
		// 	final hex = initHex( cell );
		// 	layer.addChild( hex );
		// }

		// centerLayer( layer );
	}

	function initTileData() {
		
	}

	function initHex( cell:CellData ) {
		// final drawnHex = drawTile( cell );
		
		// final container = new Object();
		
	}

	function initHexData() {
		
	}

	function initHud() {
		
	}

	function reinitScene() {
		
	}

	function registerTooltip() {
		
	}

	function drawDebugFrameAroundObject() {
		
	}

	public function handleGlobalData( players:Array<PlayerInfo>, globalViewData:GlobalViewData ) {
		final anthills:Array<Array<Int>> = [[], []];
		globalViewData.cells.filter( cell -> cell.owner != -1 ).iter( cell -> anthills[cell.owner].push( cell.index ));

		final maxScore = globalViewData.cells
		.filter( cell -> cell.type == POINTS )
		.map( cell -> cell.richness )
		.fold(( v, sum ) -> sum + v, 0 );

		globalData = {
			cells: globalViewData.cells,
			players: players,
			playerCount: players.length,
			anthills: anthills,
			maxScore: maxScore
		}

		currentTempCellData = {
			ants: globalData.players.map( p -> globalData.cells.map( cell -> cell.ants[p.index] )),
			beacons: globalData.players.map( p -> this.globalData.cells.map( _ -> 0 )),
			richness: globalData.cells.map( cell -> cell.richness )
		}
	}

	function createExplosionParticleEffect( xplosion: Explosion ) {
		//TODO











		return xplosion;
	}

	public function handleFrameData( frameInfo:FrameInfo, dto:FrameViewData ) {
		final ants = currentTempCellData.ants.map( a -> a.copy());
		final richness = currentTempCellData.richness.copy();
		final eventMapPerPlayer = [new Map<Int, Array<EventData>>(), new Map<Int, Array<EventData>>()];

		final consumedFrom = [new Map<Int,Bool>(), new Map<Int,Bool>()];

		// Handle explosions
		final shouldExplodeThisFrame:Map<Explosion, Bool> = [];
		for( event in dto.events ) {
			eventMapPerPlayer[event.playerIdx][event.type] = eventMapPerPlayer[event.playerIdx][event.type] ?? [];
			eventMapPerPlayer[event.playerIdx][event.type].push( event );
			final start = event.animData.length > 0 ? event.animData[0].start : 0;
			final end = event.animData.length > 0 ? event.animData[event.animData.length - 1].end : 0;
			final pStart = start / frameInfo.frameDuration;
			final pEnd = end / frameInfo.frameDuration;

			if( event.type == EventData.BUILD ) {
				consumedFrom[event.playerIdx].set( event.path[0], true );
				for( cellIdx in globalData.anthills[event.playerIdx] ) {
					ants[event.playerIdx][cellIdx] += event.amount;
				}
				final fromRichness = richness[event.path[0]];
				final toRichness = fromRichness - event.amount;
				
				if( fromRichness >= THRESHOLD_TRIPLE && toRichness < THRESHOLD_TRIPLE ||
					fromRichness >= THRESHOLD_DOUBLE && toRichness < THRESHOLD_DOUBLE ||
					toRichness == 0 ) {
					final tStart = frameInfo.date + frameInfo.frameDuration * pEnd;
					final tEnd = tStart + XPLODE_DURATION;
					final e:Explosion = {
						cellIdx: event.path[0],
						start: tStart,
						end: tEnd,
						data: []
					}

					shouldExplodeThisFrame.set( e, true );
				}
				richness[event.path[0]] = toRichness;
			} else if( event.type == EventData.MOVE ) {
				ants[event.playerIdx][event.cellIdx] -= event.amount;
				ants[event.playerIdx][event.targetIdx] += event.amount;
				for( other in dto.events ) {
					if( other.cellIdx == event.targetIdx && other.targetIdx == event.cellIdx ) {
						event.double = true;
						event.crisscross = true;
					} else if( other.cellIdx == event.cellIdx && other.targetIdx == event.targetIdx && other.playerIdx != event.playerIdx ) {
						event.double = true;
						event.crisscross = false;
					}
				}
			} else if( event.type == EventData.FOOD ) {
				consumedFrom[event.playerIdx].set( event.path[0], true );
				final fromRichness = richness[event.path[0]];
				final toRichness = fromRichness - event.amount;
				if( fromRichness >= THRESHOLD_TRIPLE && toRichness < THRESHOLD_TRIPLE ||
					fromRichness >= THRESHOLD_DOUBLE && toRichness < THRESHOLD_DOUBLE ||
					toRichness == 0 ) {
					final tStart = frameInfo.date + frameInfo.frameDuration * pEnd;
					final tEnd = tStart + XPLODE_DURATION;
					final e:Explosion = {
						cellIdx: event.path[0],
						start: tStart,
						end: tEnd,
						data: []
					}

					shouldExplodeThisFrame.set( e, true );
				}
				richness[event.path[0]] = toRichness;
			}
			event.animData[0].start /= frameInfo.frameDuration;
      		event.animData[event.animData.length - 1].end /= frameInfo.frameDuration;
		}
		// Create synthetic multi-path event to aggregate FOOD and BUILD events
		final foodEvents = globalData.players.map( p -> computePathSegments( eventMapPerPlayer[p.index][EventData.FOOD] ?? [], p.index, EventData.FOOD ));
		final buildEvents = globalData.players.map( p -> computePathSegments( eventMapPerPlayer[p.index][EventData.BUILD] ?? [], p.index, EventData.BUILD ));

		final buildAmount = ants
		.mapi(( playerIndex, playerAnts ) -> {
			return playerAnts.mapi(( cellIndex, _ ) -> {
				return dto.events
					.filter( event -> event.type == EventData.BUILD )
					.filter( event -> event.playerIdx == playerIndex )
					.filter( (_) -> globalData.anthills[playerIndex].contains( cellIndex ))
					.fold(( event, buildAmount ) -> buildAmount + event.amount, 0 );
			});
		});

		final explosionParticleEffects = [for( e in shouldExplodeThisFrame.keys()) e].map( e -> createExplosionParticleEffect( e ));
		for( e in explosionParticleEffects ) explosions.push( e );

		final antTotals = [
			sum( ants[0] ),
			sum( ants[1] )
		];

		final frameData:FrameData = {
			scores: dto.scores,
			events: dto.events,
			messages: dto.messages,
			beacons: dto.beacons,
			number: frameInfo.number,
			frameDuration: frameInfo.frameDuration,
			date: frameInfo.date,
			
			previous: null,
			syntheticEvents: [foodEvents, buildEvents].flatten().filter( v -> v != null ),
			buildAmount: buildAmount,
			ants: ants,
			richness: richness,
			antTotals: antTotals,
			consumedFrom: consumedFrom
		}

		frameData.previous = Utils.last( states ) ?? frameData;
		states.push( frameData );

		currentTempCellData = {
			ants: frameData.ants,
			beacons: frameData.beacons,
			richness: frameData.richness
		}

		return frameData;
	}

	function fitTextWithin() {
		
	}
}