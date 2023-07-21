package viewer;

import h2d.Object;
import h2d.Text;
import h2d.Tile;
import view.CellData;
import view.GlobalViewData;
import viewer.GameConstants.POINTS;
import viewer.Types;

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

	function updateScene( previousData:FrameData, currentData:FrameData, progress:Float, playerSpeed = 0 ) {
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
		// for( event in currentData.events.filter( type -> type == ev.MOVE )) {
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
		// return getLastEventEndP( ev.MOVE );
	}
	
	function getLastFoodEndP() {
		// return getLastEventEndP( ev.FOOD );
	}

	function getLastBuildEndP() {
		// return getLastEventEndP( ev.BUILD );
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

	function createExplosionParticleEffect() {
		
	}

	function handleFrameData( frameInfo:FrameInfo, raw:String ) {
		
	}

	function fitTextWithin() {
		
	}
}