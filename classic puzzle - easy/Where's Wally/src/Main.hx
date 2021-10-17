import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final inputs = readline().split(' ');
	final wallyWidth = parseInt( inputs[0] );
	final wallyHeight = parseInt( inputs[1] );
	final wallyRows = [for( i in 0...wallyHeight ) readline()];
	final inputs = readline().split(' ');
	final pictureWidth = parseInt( inputs[0] );
	final pictureHeight = parseInt( inputs[1] );
	final pictureRows = [for( i in 0...pictureHeight ) readline()];
					
	final result = process( wallyWidth, wallyHeight, wallyRows, pictureWidth, pictureHeight, pictureRows );
	print( result );
}

function process( wallyWidth:Int, wallyHeight:Int, wallyRows:Array<String>, pictureWidth:Int, pictureHeight:Int, pictureRows:Array<String> ) {
	
	final offset = getOffset( wallyRows[0] );
	final offsetChar = wallyRows[0].charAt( offset );

	for( y in 0...pictureRows.length ) {
		final pictureRow = pictureRows[y];
		for( x in 0...pictureRow.length ) {
			if( pictureRow.charAt( x ) == offsetChar ) {
				final startX = x - offset;
				final isFound = search( startX, y, wallyWidth, wallyHeight, wallyRows, pictureWidth, pictureHeight, pictureRows );
				if( isFound ) return '$startX $y';
			}
		}
	}
	throw 'Error: not found';
}

function search( px:Int, py:Int, wallyWidth:Int, wallyHeight:Int, wallyRows:Array<String>, pictureWidth:Int, pictureHeight:Int, pictureRows:Array<String> ) {
	if( px + wallyWidth > pictureWidth || py + wallyHeight > pictureHeight ) return false;

	for( y in 0...wallyRows.length ) {
		final wallyRow = wallyRows[y];
		for( x in 0...wallyRow.length ) {
			final wallyChar = wallyRow.charAt( x );
			if( wallyChar != " " ) {
				final pictureChar = pictureRows[py + y].charAt( px + x );
				if( pictureChar != wallyChar ) return false;
			}
		}
	}
	return true;
}

function getOffset( s:String ) {
	for( i in 0...s.length ) if( s.charAt( i ) != " " ) return i;
	throw "Error: offset not found";
}

