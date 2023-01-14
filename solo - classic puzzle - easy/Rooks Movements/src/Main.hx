import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final rookPosition = readline();
		final nbPieces = parseInt( readline() );
		final pieces:Map<String, Int> = [];
		
		for( _ in 0...nbPieces ) {
			var inputs = readline().split(' ');
			pieces.set( inputs[1], parseInt( inputs[0] ));
		};
		
		final result = process( rookPosition, pieces );
		print( result );
	}

	static function process( rookPosition:String, pieces:Map<String, Int> ) {
		
		final rookX = xPos( rookPosition );
		final rookY = yPos( rookPosition );
		
		final positions:Array<String> = [];
		// left
		for( x in -rookX + 1...0 ) {
			final pos = cPos( -x, rookY );
			if( pieces.exists( pos )) {
				if( pieces[pos] == 1 ) positions.push( 'R${rookPosition}x$pos' );
				break;
			} else positions.push( 'R${rookPosition}-$pos' );
		}
		// right
		for( x in rookX + 1...9 ) {
			final pos = cPos( x, rookY );
			if( pieces.exists( pos )) {
				if( pieces[pos] == 1 ) positions.push( 'R${rookPosition}x$pos' );
				break;
			} else positions.push( 'R${rookPosition}-$pos' );
		}
		// top
		for( y in -rookY + 1...0 ) {
			final pos = cPos( rookX, -y );
			if( pieces.exists( pos )) {
				if( pieces[pos] == 1 ) positions.push( 'R${rookPosition}x$pos' );
				break;
			} else positions.push( 'R${rookPosition}-$pos' );
		}
		// bottom
		for( y in rookY + 1...9 ) {
			final pos = cPos( rookX, y );
			if( pieces.exists( pos )) {
				if( pieces[pos] == 1 ) positions.push( 'R${rookPosition}x$pos' );
				break;
			} else positions.push( 'R${rookPosition}-$pos' );
		}

		positions.sort(( a, b ) -> {
			if( a > b ) return 1;
			if( a < b ) return -1;
			return 0;
		});
		// trace( positions );
		return positions.join( "\n" );
	}

	static inline function xPos( cPos:String ) {
		return cPos.charCodeAt( 0 ) - 96;
	}

	static inline function yPos( cPos:String ) {
		return parseInt( cPos.charAt( 1 ));
	}

	static inline function cPos( x:Int, y:Int ) {
		return String.fromCharCode( x + 96 ) + Std.string( y );
	}

}
