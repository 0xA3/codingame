import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
	final n = parseInt( readline() );
	final rows = [for( _ in 0...n ) readline().split( "" )];

	final result = process( rows );
	print( result );
}

function process( rows:Array<Array<String>> ) {
	
	final height = rows.length;
	final width = rows[0].length;

	final topRight = mirrorHorizontally( width, height, rows );
	final bottomLeft = mirrorVertically( width, height, rows );
	final bottomRight = mirrorHorizontally( width, height, bottomLeft );

	final topLines = [for( _ in 0...width * 2 - 1 ) "-"].join( "" );
	final borderHorizontal = '+${topLines}+${topLines}+';

	

	return "";
}

function mirrorHorizontally( width:Int, height:Int, rows:Array<Array<String>> ) {
	return [for( y in 0...height ) [for( x in 0...width ) rows[y][width - 1 - x]]];
}

function mirrorVertically( width:Int, height:Int, rows:Array<Array<String>> ) {
	return [for( y in 0...height ) [for( x in 0...width ) rows[height - 1 - y][x]]];
}