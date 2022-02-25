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
	
	static var isActivated = true;

	static function main() {

		#if nodejs
		// Install source-map-support for nodejs
		// "npm install source-map-support"
		js.Lib.require('source-map-support').install();
		#end
		
		final level = l0;

		map = new MazeMap( level );

		ai = new Ai( map.width, map.height );

		Sys.print( Ansix.clear());

		Timer.delay( update, 250 );
	}

	static function update() {
		ai.update( map.getVisibleLines() );
		final direction = ai.getDirection( map.kx, map.ky );
		
		map.updatePosition( direction );
		render();
		
		if( map.getCell() == "C" ) isActivated = false;
		if( !isActivated && map.getCell() == "T" ) {
			Sys.println( "\n\nSuccess!" );
			Sys.exit( 0 );
		}
	}

	static function render() {
		
		Sys.print( Ansix.resetCursor());
		Sys.print( map.getOutput());

		Timer.delay( update, 250 );
	}
}