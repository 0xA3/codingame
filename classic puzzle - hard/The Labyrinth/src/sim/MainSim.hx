package sim;

import ai.Ai;
import asciix.Ansix;
import data.Levels;
import haxe.Timer;

using StringTools;

class MainSim {
	
	static var map:MazeMap;
	static var ai:Ai;
	static var x = 5;
	static var y = 6;
	
	static var fuel = 1200;
	static var isTriggered = false;

	static function main() {

		#if nodejs
		// Install source-map-support for nodejs
		// "npm install source-map-support"
		js.Lib.require('source-map-support').install();
		#end
		
		final level = l4;

		map = new MazeMap( level.map );

		ai = new Ai( map.width, map.height, level.alarmRounds );

		Sys.print( Ansix.clear());
		Sys.print( Ansix.resetCursor());
		Sys.println( map.getOutput());

		Timer.delay( update, 100 );
	}

	static function update() {
		ai.update( map.getVisibleLines() );
		final direction = ai.getDirection( map.kx, map.ky );
		fuel--;

		map.updatePosition( direction );
		render();
		
		if( map.getCurrentCell() == "C" ) isTriggered = true;
		if( isTriggered && map.getCurrentCell() == "T" ) {
			Sys.println( "\n\nSuccess!" );
			Sys.exit( 0 );
		}
	}

	static function render() {
		
		Sys.print( Ansix.resetCursor());
		Sys.println( map.getOutput());
		Sys.println( 'Fuel $fuel  Alarm ${ai.alarmRounds}       ' );
		Timer.delay( update, 100 );
	}
}