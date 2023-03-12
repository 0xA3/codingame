import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using StringTools;
using xa3.StringUtils;

var lines:Array<String>;

function main() {

	final lsize = parseInt( readline() );
	final rheight = parseInt( readline() );
	final rwidth = parseInt( readline() );
	final theight = parseInt( readline() );
	final characters = readline().split(" ");
	final shapes = readline().split(" ");
	
	final input:Input = { lsize: lsize, rheight: rheight, rwidth: rwidth, theight: theight, characters: characters, shapes: shapes }
	
	final result = process( input );
	print( result );
}

function process( input:Input ) {
	final errorLines = [];
	final shapeResults = [];
	
	for( i in 0...input.shapes.length ) {
		final shape = input.shapes[i];
		switch shape {
			case "LINE":
				shapeResults.push( createLine( input.lsize, input.characters[0] ));
			case "RECTANGLE":
				if( input.rwidth > 0 && input.rheight > 0 ) shapeResults.push( createRectangle( input.rwidth, input.rheight, input.characters[1] ));
			case "TRIANGLE":
				if( input.theight > 0 ) shapeResults.push( createTriangle( input.theight, input.characters[2] ));
			case "REVERSE_TRIANGLE":
				if( input.theight > 0 ) shapeResults.push( createReverseTriangle( input.theight, input.characters[2] ));
			default: errorLines.push( '${shape} is not a shape'.toUpperCase() );
		}
	}
	final errors = errorLines.length == 0 ? [] : [errorLines.join( "\n" )];
	final output = errors.concat( shapeResults ).join( "\n\n" );
	return output;
}

function createLine( lsize:Int, char:String ) return char.repeat( lsize );

function createRectangle( rwidth:Int, rheight:Int, char:String ) {
	final lines = [];
	for( y in 0...rheight ) {
		final distY = min( y, rheight - 1 - y );
		var line = [];
		for( x in 0...rwidth ) {
			final distX = min( x, rwidth - 1 - x );
			line.push( distY == 0 || distX == 0 ? char : " " );
		}
		lines.push( line.join( "" ));
	}
	return lines.join( "\n" );
}

function createTriangle( theight:Int, char:String ) {
	final lines = [];
	for( y in 0...theight ) {
		final distY = min( y, theight - 1 - y );
		var line = [];
		for( x in 0...y + 1 ) {
			final distX = min( x, y - x );
			line.push( distY == 0 || distX == 0 ? char : " " );
		}
		lines.push( line.join( "" ));
	}
	return lines.join( "\n" );
}

function createReverseTriangle( theight:Int, char:String ) {
	final lines = [];
	for( minusY in -theight + 1...1 ) {
		final y = -minusY;
		final distY = min( y, theight - 1 - y );
		var line = [];
		for( x in 0...y + 1 ) {
			final distX = min( x, y - x );
			line.push( distY == 0 || distX == 0 ? char : " " );
		}
		lines.push( line.join( "" ));
	}
	return lines.join( "\n" );
}

function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;

typedef Input = {
	final lsize:Int;
	final rheight:Int;
	final rwidth:Int;
	final theight:Int;
	final characters:Array<String>;
	final shapes:Array<String>;
}