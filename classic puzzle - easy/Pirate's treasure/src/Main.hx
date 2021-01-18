import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final width = parseInt(readline());
		final height = parseInt(readline());
		final grid = [for( i in 0...height ) readline().split(' ').map( cell -> parseInt( cell ))].flatten();
		
		final result = process( width, height, grid );
		print( result );
	}

	static function process( width:Int, height:Int, grid:Array<Int> ) {
		
		for( i in 0...grid.length ) {
			final x = getX( i, width );
			final y = getY( i, width );
				if( grid[i] == 0 && getSurrounded( x, y, width, height, grid )) return '$x $y';
		}
		return '0 0';
	}

	static function getSurrounded( x:Int, y:Int, width:Int, height:Int, grid:Array<Int> ) {
		final isSurrounded = [
			// top
			getObstacle( x, y - 1, width, height, grid ),
			getObstacle( x - 1, y - 1, width, height, grid ),
			getObstacle( x + 1, y - 1, width, height, grid ),
			// left
			getObstacle( x - 1, y, width, height, grid ),
			// bottom
			getObstacle( x, y + 1, width, height, grid ),
			getObstacle( x - 1, y + 1, width, height, grid ),
			getObstacle( x + 1, y + 1, width, height, grid ),
			// right
			getObstacle( x + 1, y, width, height, grid )
		].fold(( e, sum ) -> e && sum, true );

		return isSurrounded;
	}

	static function getObstacle( x:Int, y:Int, width:Int, height:Int, grid:Array<Int> ) {
		if( x < 0 ) return true;
		if( x >= width ) return true;
		if( y < 0 ) return true;
		if( y >= height ) return true;
		return grid[getIndex( x, y, width )] == 1;
		
	}

	static function getX( index:Int, width:Int ) return index % width;
	static function getY( index:Int, width:Int ) return int( index / width );
	static function getIndex( x:Int, y:Int, width:Int ) return y * width + x;
}
