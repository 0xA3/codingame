package resources.view;

import gameengine.view.core.Constants.HEIGHT;
import gameengine.view.core.Constants.WIDTH;
import gameengine.view.core.Point;
import gameengine.view.core.Transitions.easeOut;
import gameengine.view.core.Utils.fitAspectRatio;
import gameengine.view.core.Utils.lerpPosition;
import gameengine.view.core.Utils.unlerp;
import gameengine.view.core.Utils.unlerpUnclamped;
import h2d.Drawable;
import h2d.Graphics;
import h2d.Interactive;
import main.event.AnimationData;
import main.event.EventData;
import main.view.CellData;
import main.view.FrameViewData;
import main.view.GlobalViewData;
import resources.view.AssetConstants.COLOR_NAMES;
import resources.view.AssetConstants.HUD_HEIGHT;
import resources.view.AssetConstants.INDICATOR_OFFSET;
import resources.view.AssetConstants.TILE_HEIGHT;
import resources.view.GameConstants.EGG;
import resources.view.GameConstants.POINTS;
import resources.view.HexTools.hexToScreen;
import resources.view.PathSegments.computePathSegments;
import resources.view.Types;
import resources.view.Utils.fit;
import resources.view.Utils.fitContainer;
import resources.view.Utils.generateText;
import resources.view.Utils.last;
import resources.view.Utils.sum;
import resources.view.pixi.Container;
import resources.view.pixi.Sprite;
import resources.view.pixi.Text;

using Lambda;

typedef EffectPool = Map<String, Array<Effect>>;

typedef Api = {
	var options:{
		var debugMode:Bool;
		var seeAnts:Bool;
	}
	var ?setDebug:()->Void;
	var ?seeAnts:( v:Bool )->Void;
}

typedef Hud = {
	var bar:Sprite;
	var avatar:Sprite;
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
	var container:Container;
	var time = 0;
	final tooltipManager:TooltipManager;
  
	var antParticleLayer:Container;
	var boardOverlay:Container;
	var boardLayer:Container;
  
	var huds:Array<Hud> = [];

	var scoreBar:Tile;

	var hexes:Map<Int, Hex> = [];
	var beacons:Map<Int, Array<Sprite>> = [];
	var currentTempCellData:{ ants:Array<Array<Int>>, beacons:Array<Array<Int>>, richness:Array<Int> }
	var tiles:Map<Int, { sprite:Sprite, container:Container }> = [];

	var particleGroupsByPlayer:Array<ParticleGroup>;

	var overlay:Tile;
	var conveyors:Array<Sprite>;
	var conveyorLayer:Container;
	var beaconLayer:Container;
	var arrowLayer:Container;
	var particleLayer:Container;
	var counterLayer:Container;
	var distanceBetweenHexes:Int;
	var explosions:Array<Explosion> = [];

	final tileLibrary:TileLibrary;
	final fonts:Fonts;

	public function new( tooltipManager:TooltipManager, tileLibrary:TileLibrary, fonts:Fonts ) {
		this.tooltipManager = tooltipManager;
		this.tileLibrary = tileLibrary;
		this.fonts = fonts;
	}

	// Effects
	function getFromPool( type:String ):Effect {
		if( !pool.exists( type )) {
			pool.set( type, [] );
		}
		
		for( e in pool[type] ) {
			if( !e.busy ) {
			  e.busy = true;
			  e.display.visible = true;
			  return cast e;
			}
		  }
		
		  final e = createEffect( type );
		  pool[type].push( e );
		  e.busy = true;
		  return e;
	}

	function createEffect( type:String ) {
		if (type == "conveyor") {
			// display = PIXI.TilingSprite.fromImage("convey3.png", { width: CONVEYOR_WIDTH, height: CONVEYOR_HEIGHT });
			final display = new Sprite( tileLibrary.convey3 );
			display.interactive = true;
	
			// registerTooltip( display, function() {
			// 	return (display as Dynamic).tooltip ?? "";
			// });
			// display.on("mouseover", function() {
			// 	return (display as Dynamic).mouseOver?.();
			// });
			// display.on("mouseout", function() {
			// 	return (display as Dynamic).mouseOut?.();
			// });
	
			display.anchor.set( 0, 0.5 );
			conveyors.push( display );
			conveyorLayer.addChild( display );
			
			final effect:Effect = { busy: false, display: display }
			return effect;
			
		} else if(type == "antText" ) {
			final display = generateText( "5", 0xFFFFFF, fonts.arial_black_40 );
			counterLayer.addChild( display );
			
			final effect:Effect = { busy: false, display: display }
			return effect;

		} else if( type == "arrow" ) {
			final display = new Container();
			var spriteContainer = new Container();
			var sprite = new Sprite( tileLibrary.Fleche_Bleu );
			var number = generateText( "5", 0xFFFFFF, fonts.arial_black_188 );
			sprite.anchor.set( 0.5 );
			number.anchor.set( 0.5 );
			spriteContainer.addChild( sprite );
			display.addChild( spriteContainer );
			display.addChild( number );
			fitContainer( spriteContainer, Math.POSITIVE_INFINITY, TILE_HEIGHT / 3 );
			arrowLayer.addChild( display );
			
			final effect:Effect = { busy: false, display: display }
			return effect;
			
		} else if( type == "particle" ) {
			final display = new Sprite( hxd.Res.ants.particle.toTile() );
			display.anchor.set( 0.5 );
			particleLayer.addChild( display );

			final effect:Effect = { busy: false, display: display }
			return effect;
		} else {
			throw 'Error: unknown type $type';
		}

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
		// for( index => hex in hexes ) {
			// if( hex.icon != null ) hex.iconBounceContainer.zIndex = 1;
			// hex.indicatorLayer.zIndex = 2;
		// }

		resetEffects();
		updateTiles();
		updateBeacons();
		updateMoves();
		updateGains();
		updateExplosions();
		updateParticles( frameChange, lastShownData );
		updateHud();
		if (frameChange || (fullProgressChange && playerSpeed == 0)) {
			tooltipManager.updateGlobalText();
		}
	}

	function destroyParticles() {
		// ...
	}

	function resetParticles() {
		// ...
	}

	function updateParticles( frameChange:Bool, lastShownData:FrameData ) {
		// ...
	}

	function drawParticleGroup() {
		// ...
	}

	function showPlayerDebug( playerIdx:Int ) {
		return api.options.debugMode == true;// || api.options.debugMode == playerIdx;
	}

	function updateMoves() {
		var progress = this.progress;
		for( event in currentData.events.filter( event -> event.type == EventData.MOVE )) {
			if( !showPlayerDebug( event.playerIdx )) continue;
			
			var p = getAnimProgress( event.animData, progress );
			if( p < 0 || p > 1 ) continue;
			
			final fromIdx = event.cellIdx;
			final toIdx = event.targetIdx;
			final amount = event.amount;
			final playerIdx = event.playerIdx;
			
			var display = getFromPool( 'arrow' ).display;
			var sprite:Sprite = cast display.getChildAt( 0 ).getChildAt( 0 );
			var number:Text = cast display.getChildAt( 1 );
			number.text = '$amount';
			sprite.tile = playerIdx == 0 ? tileLibrary.Fleche_Bleu : tileLibrary.Fleche_Rouge;
			
			var sourceCell = hexes[fromIdx];
			var targetCell = hexes[toIdx];
			var sourceP = hexToScreen( sourceCell.data.q, sourceCell.data.r );
			var targetP = hexToScreen( targetCell.data.q, targetCell.data.r );
			var newPosition = lerpPosition( sourceP, targetP, unlerp( 0, 0.5, p ) * 0.5 );
			display.setPosition( newPosition.x, newPosition.y );
			var rotation = Math.atan2( targetP.y - sourceP.y, targetP.x - sourceP.x );
			sprite.rotation = rotation;
			display.alpha = 1 - unlerp( ARROW_FADE_OUT_P, 1, p );
			
			if( event.double && api.options.debugMode == true ) {
				var offset = TILE_HEIGHT / 8;
				if( !event.crisscross && playerIdx == 0 ) {
					offset *= -1;
				}
				display.setPosition( display.x + Math.cos(rotation + Math.PI / 2) * offset,
				display.y + Math.sin(rotation + Math.PI / 2) * offset );
				display.setScale( 0.7 );
			} else {
				display.setScale( 1 );
			}
			
			sprite.sscale.x = unlerp( 0, 0.5, p );
			number.tscale.set( unlerp( 0, 0.25, p ));
		}
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
		return currentData.events
			.filter( e -> e.type == eventType )
			.map( e -> e.animData[e.animData.length - 1].end )
			.fold(( a, b ) -> Math.max( a, b ), 0 );
	}

	function getLastMoveEndP() {
		return getLastEventEndP( EventData.MOVE );
	}
	
	function getLastFoodEndP() {
		return getLastEventEndP( EventData.FOOD );
	}

	function getLastBuildEndP() {
		return getLastEventEndP( EventData.BUILD );
	}
	
	function getOwnersOfBeaconOn( cellIdx:Int, data:FrameData ) {
	    final powers = globalData.players.map( player -> data.beacons[player.index][cellIdx] );
		if( powers[0] > 0 && powers[1] > 0 ) {
			return [0, 1];
		}
		if( powers[0] == 0 && powers[1] > 0 ) {
			return [1];
		}
		if( powers[0] > 0 && powers[1] == 0 ) {
			return [0];
		}
		return [];
	}

	function updateBeacons() {
		for( index in hexes.keys() ) {
			final beacons = this.beacons[index];
			final beaconP = unlerp( 0, 0.5, progress );

			beacons.map( beacon -> {
				beacon.visible = false;
				beacon.alpha = 1;
			});

			var fromPlayers = getOwnersOfBeaconOn(index, previousData).filter(showPlayerDebug);
			var toPlayers = getOwnersOfBeaconOn(index, currentData).filter(showPlayerDebug);
	
			var fromSuffix = fromPlayers.length == 0 ? null : fromPlayers.length == 2 ? 'Rouge_Bleu' : COLOR_NAMES[fromPlayers[0]];
			var toSuffix = toPlayers.length == 0 ? null : toPlayers.length == 2 ? 'Rouge_Bleu' : COLOR_NAMES[toPlayers[0]];
	
			if( fromPlayers.length == 0 && toPlayers.length > 0 ) {
				var beacon = beacons[0];
				beacon.visible = true;
				beacon.alpha = easeOut( beaconP );
				// beacon.tile = PIXI.Texture.from("Balise_" + toSuffix + ".png");
				trace( '$index ${"Balise_" + toSuffix}' );
			} else if( fromPlayers.length > 0 && toPlayers.length == 0 ) {
				var beacon = beacons[0];
				beacon.visible = true;
				beacon.alpha = 1 - easeOut(beaconP);
			// 	beacon.texture = PIXI.Texture.from("Balise_" + fromSuffix + ".png");
				trace( '$index ${"Balise_" + fromSuffix}' );
		} else if( fromPlayers.length > 0 && toPlayers.length > 0 ) {
				var beacon = beacons[0];
				beacon.visible = true;
				// beacon.texture = PIXI.Texture.from("Balise_" + fromSuffix + ".png");
				trace( '$index ${"Balise_" + fromSuffix}' );
	
				if( fromSuffix != toSuffix ) {
					var other = beacons[1];
					other.visible = true;
			// 		other.texture = PIXI.Texture.from("Balise_" + toSuffix + ".png");
					trace( '$index ${"Balise_" + toSuffix}' );
	
					// Cross fade
					beacon.alpha = 1 - beaconP;
					other.alpha = beaconP;
				}
			}
		}
	}

	function updateTiles() {
		for( index => hex in hexes ) {
			final curr = currentData;
			final prev = previousData;
			tiles[index].sprite.alpha = 1;
			tiles[index].sprite.tint = 0xFFFFFF;
			hexes[index].bouncing = false;
			
			for( player in globalData.players ) {
				final antAmountDataSource = progress >= ( ARROW_FADE_OUT_P * getLastMoveEndP() ) ? curr : prev;
				final foodAmountDataSource = progress >= getLastFoodEndP() ? curr : prev;
				final eggAmountDataSource = progress >= getLastBuildEndP() ? curr : prev;
				
				final finalAmount = antAmountDataSource.ants[player.index][index];
				final buildAmount = curr.buildAmount[player.index][index];
				final isBetweenMoveAndBuild = progress >= ( ARROW_FADE_OUT_P * getLastMoveEndP() ) && progress < getLastBuildEndP();
				final temporaryAntAmount = isBetweenMoveAndBuild
					? finalAmount - buildAmount
					: finalAmount;
				hex.texts[player.index].visible = temporaryAntAmount > 0 && !api.options.seeAnts;

				hex.texts[player.index].text = '$temporaryAntAmount';

				hex.indicators[player.index].visible = temporaryAntAmount > 0 && !api.options.seeAnts;

				final richness = ( hex.data.type == EGG ? eggAmountDataSource : foodAmountDataSource ).richness[index];
				var richIdx = 0;
				if( richness >= THRESHOLD_TRIPLE ) {
				  richIdx = 1;
				} else if (richness >= THRESHOLD_DOUBLE) {
				  richIdx = 2;
				} else {
				  richIdx = 3;
				}

				if( richness > 0 ) {
					hex.foodText.text = '$richness';
					hex.foodText.visible = true;
					hex.foodTextBackground.visible = true;
					if( hex.icon != null ) {
						hex.icon.visible = true;
						hex.icon.setScale( 1 );
						if (hex.data.type == POINTS ) {
							hex.icon.tile = switch richIdx {
								case 1: tileLibrary.Cristaux_1.center();
								case 2: tileLibrary.Cristaux_2.center();
								case 3: tileLibrary.Cristaux_3.center();
								default: throw 'Error: richIdx can only be between 1-3 but is $richIdx';
							}
						} else {
							if( hex.data.richness < THRESHOLD_DOUBLE ) {
								hex.icon.tile = tileLibrary.Oeufs.center();
							} else {
								hex.icon.tile = switch richIdx {
									case 1: tileLibrary.Oeufs_1.center();
									case 2: tileLibrary.Oeufs_2.center();
									case 3: tileLibrary.Oeufs_3.center();
									default: throw 'Error: richIdx can only be between 1-3 but is $richIdx';
								}
							}
						}
					}
					} else if( hex.foodText != null ) {
						hex.foodText.visible = false;
						hex.foodTextBackground.visible = false;
					if( hex.icon != null ) {
						hex.icon.visible = false;
					}
				}
			}
		}
	}

	function updateHud() {
		
	}

	function shake( entity:Tile, progress:Float ) {
		
	}

	function toGlobal() {
		
	}

	function getAnimProgress( animData:Array<AnimationData>, progress:Float ) {
		return unlerpUnclamped( animData[0].start, animData[animData.length - 1].end, progress );
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

	function asLayer( func:( Container )->Void ) {
		final layer = new Container();
		func( layer );
		return layer;
	}

	function drawTile() {
		final sprite = new Sprite( tileLibrary.Case );
		sprite.anchor.set( 0.5 );
		return sprite;
	}

	function initBackground( layer:Container ) {
		final b = new Sprite( hxd.Res.ants.Background.toTile(), layer );
		fit( b, Math.POSITIVE_INFINITY, HEIGHT );
	}

	function initBeacons( layer:Container ) {
		this.beacons.clear();
		for( cell in globalData.cells ) {
			final beacons = [];
			for( player in globalData.players ) {
				final crosshair = new Sprite( player.index == 0 ? tileLibrary.Balise_Bleu : tileLibrary.Balise_Rouge );
				crosshair.anchor.set( 0.5 );
				
				final hexaP = hexToScreen( cell.q, cell.r );
				crosshair.position.set( hexaP.x, hexaP.y );

				beacons.push( crosshair );
				layer.addChild( crosshair );
			}
			this.beacons.set( cell.index, beacons );
		}
		centerLayer( layer );
	}

	function centerLayer( layer:Container ) {
		layer.position.set( WIDTH / 2, ( HEIGHT + HUD_HEIGHT ) / 2 );
	}

	public function initBoard( layer:Container ) {
		tiles.clear();
		for( cell in globalData.cells ) {
			final hex = initHex( cell );
			layer.addChild( hex );
		}
		centerLayer( layer );
	}

	function initTileData( layer:Container ) {
		hexes.clear();
		for( cell in globalData.cells ) {
			final hex = initHexData( cell );
			layer.addChild( hex );
		}
		centerLayer( layer );
	}

	function initHex( cell:CellData ) {
		final drawnHex = drawTile();
		
		final container = new Container();
		container.addChild( drawnHex );
		final hexaP = hexToScreen( cell.q, cell.r );
		container.position.set( hexaP.x, hexaP.y );
		// trace( 'initHex ${cell.index} ${hexaP.x}:${hexaP.y}' );
		tiles.set( cell.index, {
			sprite: drawnHex,
			container: container
		});
		return container;
	}

	function initHexData( cell:CellData ) {
		final container = new Container();
		container.sortableChildren = true;

		final hexaP = hexToScreen( cell.q, cell.r );
		container.position.set( hexaP.x, hexaP.y );
		if( cell.owner != -1 ) {
			final anthill = new Sprite( cell.owner == 0 ? tileLibrary.Fourmiliere_Bleu : tileLibrary.Fourmiliere_Rouge );
			anthill.anchor.set( 0.5 );
			container.addChild( anthill );
			anthill.zIndex = 0;
		}
		var foodTextBackground:Sprite = null;
		var foodText:Text = null;
		var icon:Sprite = null;
		var iconBounceContainer:Container = null;

		if( cell.richness > 0 ) {
			iconBounceContainer = new Container();
			foodTextBackground = new Sprite( tileLibrary.Oeufs_Nombre );
			foodTextBackground.anchor.set( 0.5 );
			foodText = generateText( '${cell.richness}', 0, fonts.arial_black_125 );

			fit( foodTextBackground, Math.POSITIVE_INFINITY, TILE_HEIGHT / 6 );

			if( cell.type == 1 ) {
				icon = new Sprite( tileLibrary.Oeufs_1 );
				icon.anchor.set( 0.5 );
				iconBounceContainer.addChild( icon );
				container.addChild( iconBounceContainer );
				iconBounceContainer.zIndex = 1;
			} else {
				icon = new Sprite( tileLibrary.Cristaux_1 );
				icon.anchor.set( 0.5 );
				iconBounceContainer.addChild( icon );
				container.addChild( iconBounceContainer );
				iconBounceContainer.zIndex = 1;
			}
			container.addChild( foodTextBackground );
			container.addChild( foodText );
			foodTextBackground.zIndex = 2;
			foodText.zIndex = 3;
		}

		final indicators:Array<Sprite> = [];
		final texts:Array<Text> = [];
		final indicatorLayer = new Container();
		for( player in globalData.players ) {
			final offsetY = INDICATOR_OFFSET;
			final indicator = new Sprite( player.index == 0 ? tileLibrary.Fourmies_Nombre_Bleu : tileLibrary.Fourmies_Nombre_Rouge );
			indicator.anchor.set( 0.5, player.index == 0 ? 0 : 1 );
			indicator.position.set( 0, player.index == 0 ? -offsetY : offsetY );
			indicators.push( indicator );
			indicatorLayer.addChild( indicator );
			indicator.setScale( 1.4 );

			final text = generateText( "0", 0xffffff, fonts.arial_black_214 );
			text.anchor.set( 0.5, 0.5 );
			
			final indicatorBounds = indicator.getBounds();
			text.position.set( 0, indicator.y + ( indicatorBounds.height / 2 ) * ( player.index == 0 ? 1 : -1 ));
			texts.push( text );
			indicatorLayer.addChild( text );
		}
		container.addChild( indicatorLayer );

		final hex:Hex = {
			container: container,
			data: cell,
			texts: texts,
			indicators: indicators,
			foodText: foodText,
			foodTextBackground: foodTextBackground,
			icon: icon,
			iconBounceContainer: iconBounceContainer,
			bouncing: false,
			indicatorLayer: indicatorLayer
		}
		hexes.set( cell.index, hex );

		return container;
	}

	function initHud( layer:Container ) {
		huds.splice( 0, huds.length );
		final hudFrame = new Sprite( tileLibrary.HUD );

		final backdrop = new Graphics();
		backdrop.beginFill(0x454142);
		backdrop.drawRect( 0, 0, WIDTH, 96 );
		backdrop.endFill();
		
		final barLayer = new Container();

		layer.addChild( backdrop );
		layer.addChild( barLayer );
		layer.addChild( hudFrame );

		final white = 0xffffff;

		for( player in globalData.players ) {
			final place = ( x:Float ) -> player.index == 0 ? x : WIDTH - x;

			final avatar = new Sprite( player.avatar );
			avatar.position.set( place( 51 ), 51 );
			avatar.width = 96;
			avatar.height = 96;
			avatar.anchor.set( 0.5 );

			final antRect = {
				x: 503,
				y: 11,
				w: 100,
				h: 48
			}

			final ants = generateText( "10", white, fonts.arial_black_54 );
			fitTextWithin( ants, antRect, place );

			final nicknameRect = {
				x: 115,
				y: 13,
				w: 354,
				h: 43
			}

			final nickname = generateText( player.name, white, fonts.arial_black_54 );
			fitTextWithin( nickname, nicknameRect, place );

			final message = generateText( "Chat zone", player.color, fonts.arial_black_64 );
			fitTextWithin( message, MESSAGE_RECT, place );

			final scoreRect = {
				x: 672,
				y: 20,
				w: 60,
				h: 29
			}

			final score = generateText( "000", white, fonts.arial_black_64 );
			fitTextWithin( score, scoreRect, place );
			
			final bar = new Sprite( player.index == 0 ? tileLibrary.Jauge_Bleu : tileLibrary.Jauge_Rouge );
			bar.anchor.set( player.index == 0 ? 1 : 0, 0.5 );
			final barX = 958 + ( 294 * ( player.index == 0 ? -1 : 1 ));
			bar.position.set( barX, 34 );

			final hud:Hud = {
				avatar: avatar,
				ants: ants,
				nickname: nickname,
				message: message,
				score: score,
				bar: bar,
				targetBarX: barX
			}

			huds.push( hud );

			final playerHud = new Container();

			barLayer.addChild( bar );
			playerHud.addChild( avatar );
			playerHud.addChild( ants );
			playerHud.addChild( nickname );
			playerHud.addChild( message );
			playerHud.addChild( score );
			layer.addChild( playerHud );
		}
	}

	public function reinitScene( container:Container ) {
		this.container = container;
		pool = [];
		conveyors = [];
		distanceBetweenHexes = 0;

		destroyParticles();
		
		final tooltipLayer = tooltipManager.reinit();

		antParticleLayer = new Container();
		centerLayer( antParticleLayer );

		particleLayer = new Container();
		centerLayer( particleLayer );

		counterLayer = new Container();
		centerLayer( counterLayer );

		final background = asLayer( initBackground );
		boardLayer = asLayer( initBoard );

		beaconLayer = asLayer( initBeacons );
		arrowLayer = new Container();
		conveyorLayer = new Container();

		final hudLayer = asLayer( initHud );
		
		boardOverlay = asLayer( initTileData );
		boardOverlay.addChild( conveyorLayer );
		boardOverlay.addChild( arrowLayer );

		final gameZone = new Container();
		gameZone.addChild( boardLayer );
		gameZone.addChild( beaconLayer );
		gameZone.addChild( antParticleLayer );
		gameZone.addChild( boardOverlay );
		gameZone.addChild( particleLayer );
		gameZone.addChild( counterLayer );

		container.addChild( background );
		container.addChild( gameZone );
		container.addChild( hudLayer );
		container.addChild( tooltipLayer );

		final pad = 20;
		fitContainer( boardLayer, WIDTH - pad, HEIGHT - pad - HUD_HEIGHT );
		antParticleLayer.setScale( boardLayer.scaleX );
		beaconLayer.setScale( boardLayer.scaleX );
		particleLayer.setScale( boardLayer.scaleX );
		boardOverlay.setScale( boardLayer.scaleX );
		counterLayer.setScale( boardLayer.scaleX );

		// container.interactive = true;
	
		// tooltipLayer.interactiveChildren = false
		// hudLayer.interactiveChildren = false

		// ...
		
	}

	function registerTooltip( container:Interactive, getString:()->String ) {
		tooltipManager.register( container, getString );
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
			beacons: globalData.players.map( p -> globalData.cells.map( _ -> 0 )),
			richness: globalData.cells.map( cell -> cell.richness )
		}
	}

	function createExplosionParticleEffect( xplosion: Explosion ) {
		
		// ...

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

		frameData.previous = last( states ) ?? frameData;
		states.push( frameData );

		currentTempCellData = {
			ants: frameData.ants,
			beacons: frameData.beacons,
			richness: frameData.richness
		}

		return frameData;
	}

	function fitTextWithin( text:Text, rect:{ x:Int, y:Int, w:Int, h:Int }, place:( x:Float )->Float ) {
		text.anchor.set( 0.5 );
		final x = rect.x + rect.w / 2;
		final y = rect.y + rect.h / 2;
		text.position.set( place( x ), y );
		if( text.textWidth > rect.w || text.textHeight > rect.h ) {
			final coeff = fitAspectRatio( text.textWidth, text.textHeight, rect.w, rect.h );
			text.tscale.set( coeff );
		}
	}
}