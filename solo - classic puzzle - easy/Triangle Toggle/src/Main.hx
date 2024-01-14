import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

typedef Triangle = Array<Point>;

function main() {
	final inputs = readline().split(' ');
	final hi = parseInt( inputs[0] );
	final wi = parseInt( inputs[1] );
	final style = readline();
	final howManyTriangles = parseInt( readline() );
	final triangles = [for( _ in 0...howManyTriangles ){
		final inputs = readline().split(' ');
		final triangle:Array<Point> = [
			{ x: parseInt( inputs[0] ), y: parseInt(inputs[1])},
			{ x: parseInt( inputs[2] ), y: parseInt(inputs[3])},
			{ x: parseInt( inputs[4] ), y: parseInt(inputs[5])}
		];
		triangle;
	}];
	
	final result = process( hi, wi, style, triangles );
	print( result );
}

function process( hi:Int, wi:Int, style:String, triangles:Array<Triangle> ) {
	
	final grid = [for( _ in 0...hi )[for( _ in 0...wi ) true]];

	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			for( triangle in triangles ) {
				if( checkPointInTriangle( x, y, triangle )) grid[y][x] = !grid[y][x];
			}
		}
	}
	
	final joinChar = switch style {
		case "condensed": "";
		case "expanded": " ";
		default: throw 'Error: unsupported style "$style"';
	}

	return gridToStr( grid ).map( row -> row.join( joinChar )).join( "\n" );
}

function checkPointInTriangle( x:Int, y:Int, triangle:Triangle ) {
	final d1 = sign( x, y, triangle[0], triangle[1] );
	final d2 = sign( x, y, triangle[1], triangle[2] );
	final d3 = sign( x, y, triangle[2], triangle[0] );

	final hasNeg = ( d1 < 0 ) || ( d2 < 0 ) || ( d3 < 0 );
	final hasPos = ( d1 > 0 ) || ( d2 > 0 ) || ( d3 > 0 );

	return !( hasNeg && hasPos );
}

function sign( x:Int, y:Int, p1:Point, p2:Point ) {
	return ( x - p2.x ) * ( p1.y - p2.y ) - ( p1.x - p2.x ) * ( y - p2.y );
}

function gridToStr( grid:Array<Array<Bool>> ) return grid.map( row -> row.map( cell -> cell ? "*" : " " ));
