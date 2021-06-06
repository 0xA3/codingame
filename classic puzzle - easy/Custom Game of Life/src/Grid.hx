import Math.max;
import Math.min;
import Std.int;
class Grid {
	
	public final width:Int;
	public final height:Int;
	public final cells:Array<Array<Bool>>;

	public function new( width:Int, height:Int, cells:Array<Array<Bool>> ) {
		this.width = width;
		this.height = height;
		this.cells = cells;
	}

	public static function create( width:Int, height:Int, lines:Array<String> ) {
		if( lines.length != height ) throw 'Error: lines ${lines.length} should match height $height';
		if( lines[0].length != width ) throw 'Error: lines width ${lines[0].length} should match width $width';

		final cells = lines.map( line -> line.split( "" ).map( cell -> cell == "O" ? true : false ));
		return new Grid( width, height, cells );
	}

	public function evolve( alive:Array<Bool>, dead:Array<Bool> ) {
		
		final nextCells = [];
		for( y in 0...cells.length ) {
			nextCells[y] = [];
			for( x in 0...cells[y].length ) {
				final cellState = cells[y][x];
				final neighborsSum = countAliveNeighbors( x, y );
				nextCells[y][x] = cellState ? alive[neighborsSum] : dead[neighborsSum];
			}
		}
		return new Grid( width, height, nextCells );
	}

	function countAliveNeighbors( x:Int, y:Int ) {
		final startX = x - 1;
		final startY = y - 1;
		final endX = x + 1;
		final endY = y + 1;
		
		var sum = 0;
		for( ny in startY...endY + 1 ) {
			for( nx in startX...endX + 1 ) {
				if( nx != x || ny != y ) {
					final neighborState = nx < 0 || nx >= width || ny < 0 || ny >= height ? false : cells[ny][nx];
					if( neighborState ) sum += 1;
					// trace( 'cellState $x:$y $cellState neighborState $nx:$ny $neighborState' );
				}
			}
		}
		return sum;
	}

	public function toString() {
		return cells.map( row -> row.map( cell -> cell ? "O" : "." ).join( "" )).join( "\n" );
	}
}