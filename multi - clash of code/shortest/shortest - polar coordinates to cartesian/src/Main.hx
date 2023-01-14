import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseFloat;
import xa3.MathUtils;

/*
Convert polar coordinates to cartesian

*/

class Main {
	static var rad:Float;
	static var r:Float;
	static function main() {
		
		final theta = parseFloat( readline());
		rad = MathUtils.deg2Rad( theta );
		r = parseFloat( readline());
		
		final x = Math.round( r * Math.cos( rad ) * 10 ) / 10;
		final y = Math.round( r * Math.sin( rad ) * 10 ) / 10;
		print( '${x}, ${y}' );
	}

}

