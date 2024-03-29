package viewer;

import Std.int;
import game.Config;
import h2d.Graphics;
import h2d.Object;
import h2d.Scene;
import h2d.Text;
import view.Coord;
import view.FrameViewData;
import viewer.App;
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
	final spellsLayer:Object;
	final hudLayer:Object;
	final textLayer:Object;

	final textfieldsMana:Array<Text> = [];
	final overlay:Object;
	final overlayBox:Graphics;
	final overlayText:Text;

	final lifes:Array<Life> = [];
	final heros:Array<HeroView> = [];
	final mobs:Map<Int, MobView> = [];
	final windSpells:Array<WindSpellView> = [];
	final shieldSpells:Array<ShieldSpellView> = [];
	final controlBeams:Array<ControlBeamView> = [];
	final controlMarkers:Array<ControlMarkerView> = [];
	
	public var isMouseDown = false;

	public function new( s2d:Scene, scene:Object, entityCreator:EntityCreator ) {
		this.s2d = s2d;
		this.scene = scene;
		this.entityCreator = entityCreator;

		backgroundLayer = new Object( scene );
		mobsLayer = new Object( scene );
		herosLayer = new Object( scene );
		spellsLayer = new Object( scene );
		hudLayer = new Object( scene );
		textLayer = new Object( scene );
		overlay = new Object( s2d );
		overlayBox = new Graphics( overlay );
		overlayText = new Text( timesFont, overlay );
	}

	public function init( player1:String, player2:String ) {

		entityCreator.createTextfields( textLayer, player1, player2 );
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
			final life = entityCreator.createLife( hudLayer, lifeX, lifeY );
			lifes.push( life );
		}
		for( _ in 0...3 ) heros.push( entityCreator.createHero( herosLayer, 0 ));
		for( _ in 0...3 ) heros.push( entityCreator.createHero( herosLayer, 1 ));
	}

	public function addFrameViewData( frame:Int, currentFrameData:FrameViewData ) {
		createMobs( frame, currentFrameData );
		updateLife( frame, currentFrameData );
		updatePositions( frame, currentFrameData );
		updateMobHealth( frame, currentFrameData );
		createStatesOfHeros( frame, currentFrameData );
		createWindSpells( frame, currentFrameData );
		createShieldSpells( frame, currentFrameData );
		createControlSpells( frame, currentFrameData );
	}

	function createMobs( frame:Int, currentFrameData:FrameViewData ) {
		for( entity in currentFrameData.spawns ) {
			if( entity.type == 2 ) {
				final mobType = frame < 40 ? 0 : frame < 90 ? 1 : 2;
				mobs[entity.id] = entityCreator.createMob( mobsLayer, mobType, entity.health, frame );
			}
		}
	}

	function updateLife( frame:Int, currentFrameData:FrameViewData ) {
		for( i in 0...currentFrameData.baseHealth.length ) {
			final lifes0 = i * 3;
			final baseHealth = currentFrameData.baseHealth[i];
			final hasLifes = [baseHealth > 0, baseHealth > 1, baseHealth > 2];
			for( o in 0...hasLifes.length ) {
				final life = lifes[lifes0 + o];
				if( !hasLifes[o] && life.start == Life.MAX ) {
					life.start = frame;
					// if( i == 0 ) trace( 'player $i lose life $o at frame $frame' );
				}
			}
		}
	}

	function updatePositions( frame:Int, currentFrameData:FrameViewData ) {
		for( id => coord in currentFrameData.positions ) {
			if( id < 6 ) { // hero
				heros[id].positions[frame] = coord;
			} else {
				mobs[id].positions[frame] = coord;
			}
		}
	}

	function updateMobHealth( frame:Int, currentFrameData:FrameViewData ) {
		final ids = [for( id in currentFrameData.positions.keys()) id];
		for( id in ids ) {
			if( id >= 6 ) {
				final currentHealth = currentFrameData.mobHealth[id];
				final isDying = currentHealth <= 0 ? true : false;
				mobs[id].setEndFrame( frame, isDying );
			}
		}
	}

	function createStatesOfHeros( frame:Int, currentFrameData:FrameViewData ) {
		for( i in 0...heros.length ) createHeroState( frame, currentFrameData, i );
	}

	function createHeroState( frame:Int, currentFrameData:FrameViewData, id:Int ) {
		final hero = heros[id];
		final isAttacking = currentFrameData.attacks.filter( attack -> attack.hero == id ).length > 0;
		final isCasting = currentFrameData.spellUses.filter( spellUse -> spellUse.hero == id ).length > 0;
		if( isAttacking ) {
			hero.setFrameState( frame, Combat );
		}
		else if( isCasting ) {
			// if( id == 0 ) trace( '$frame  hero $id  Cast' );
			hero.setFrameState( frame, Cast );
		} else {
			if( frame == 0 ) {
				// if( id == 0 ) trace( '$frame  hero $id  Idle' );
				hero.setFrameState( frame, Idle );
			} else {
				final currentPos = hero.positions[frame];
				final prevPos = hero.positions[frame - 1];
				// if( id == 0 ) trace( '$frame  hero $id  ' + ( currentPos.isEqual( prevPos ) ? "Idle" : "Run" ));
				hero.setFrameState( frame, currentPos.isEqual( prevPos ) ? Idle : Run );
			}
		}
		// if( id == 0 && frame < 100 ) trace( '$frame  hero $id  ${hero.states[frame]}  ${hero.stateDurations[frame]}' );
	}
	
	function createWindSpells( frame:Int, currentFrameData:FrameViewData ) {
		final windSpellUses = currentFrameData.spellUses.filter( spellUse -> spellUse.spell == AssetConstants.WIND );
		for( windSpellUse in windSpellUses ) {
			final pos = currentFrameData.positions[windSpellUse.hero];
			final windSpell = entityCreator.createWindSpell( spellsLayer, pos, windSpellUse.destination, frame - 1 );
			windSpell.place( sX( pos.x ), sY( pos.y ));
			windSpells.push( windSpell );
		}
	}

	function createShieldSpells( frame:Int, currentFrameData:FrameViewData ) {
		final shieldSpellUses = currentFrameData.spellUses.filter( spellUse -> spellUse.spell == AssetConstants.SHIELD );
		for( shieldSpellUse in shieldSpellUses ) {
			final pos = currentFrameData.positions[shieldSpellUse.hero];
			final shieldSpell = entityCreator.createShieldSpell( spellsLayer, pos, shieldSpellUse.target, frame );
			shieldSpells.push( shieldSpell );
			// trace( 'new ShieldSpell at frame $frame of hero ${shieldSpellUse.hero} pos $pos to mob ${shieldSpellUse.target}' );
		}

		for( mobId in currentFrameData.shielded ) {
			final shieldSpellView = findShieldView( mobId );
			shieldSpellView.addPos( frame, currentFrameData.positions[mobId] );
		}
	}

	function findShieldView( mobId:Int ) {
		for( i in -shieldSpells.length + 1...1 ) {
			final shieldSpell = shieldSpells[-i];
			if( shieldSpell.mobId == mobId ) return shieldSpell;
		}
		throw 'Error: no shield spell found for mob $mobId';
	}
	
	function createControlSpells( frame:Int, currentFrameData:FrameViewData ) {
		final controlSpellUses = currentFrameData.spellUses.filter( spellUse -> spellUse.spell == AssetConstants.CONTROL );
		for( controlSpellUse in controlSpellUses ) {
			final heroPos = currentFrameData.positions[controlSpellUse.hero];
			final mobPos = currentFrameData.positions[controlSpellUse.target];
			final controlBeam = entityCreator.createControlBeam( spellsLayer, controlSpellUse.hero, controlSpellUse.target, heroPos, mobPos, frame - 1 );
			controlBeam.place( sX( heroPos.x ), sY( heroPos.y ));
			controlBeams.push( controlBeam );

			final controlMarker = entityCreator.createControlMarker( backgroundLayer, mobPos, controlSpellUse.target, frame );
			controlMarkers.push( controlMarker );
		}

		for( mobId in currentFrameData.controlled ) {
			final controlMarkerView = findControlView( mobId );
			controlMarkerView.addPos( frame, currentFrameData.positions[mobId] );
		}
	}

	function findControlView( mobId:Int ) {
		for( i in -controlMarkers.length + 1...1 ) {
			final controlMarker = controlMarkers[-i];
			if( controlMarker.mobId == mobId ) return controlMarker;
		}
		throw 'Error: no control spell found for mob $mobId';
	}
	
	public function update( frame:Float, intFrame:Int, subFrame:Float, frameDatasets:Array<FrameViewData> ) {
		final currentFrameData = frameDatasets[intFrame];

		for( i in 0...currentFrameData.mana.length ) textfieldsMana[i].text = '${currentFrameData.mana[i]}';
		for( i in 0...currentFrameData.baseHealth.length ) {
			final lifes0 = i * 3;
			for( o in 0...3 ) lifes[lifes0 + o].update( frame );
		}

		for( hero in heros ) hero.update( frame, intFrame, subFrame );
		for( id => message in currentFrameData.messages ) heros[id].setMessage( message );
		
		for( mob in mobs ) mob.update( frame, intFrame, subFrame );
		for( windSpell in windSpells ) windSpell.update( frame );
		for( shieldSpell in shieldSpells ) shieldSpell.update( frame, intFrame, subFrame );
		for( controlBeam in controlBeams ) controlBeam.update( frame, intFrame, subFrame );
		for( controlMarker in controlMarkers ) controlMarker.update( frame, intFrame, subFrame );
	}

	public function updateControlMarkerRotation( dt:Float ) {
		for( controlMarker in controlMarkers ) controlMarker.updateRotation( dt );
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