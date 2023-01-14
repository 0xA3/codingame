import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final w = parseInt( readline() );
	final h = parseInt( readline() );
	final t = readline();
		
	final result = process( w, h, t );
	print( result );
}

function process( w:Int, h:Int, t:String ) {
	
	final chars = ["*", " "];
	final pixels = t.split(" ").map( s -> parseInt( s ));
	final chars = pixels.mapi(( i, v ) -> return [for( _ in 0...v ) chars[i % 2]]).flatten();
	
	final lines = [for( y in 0...h ) chars.slice( y * w, ( y + 1 ) * w ).join( "" )];
	final output = "|" + lines.join( "|\n|" ) + "|";

	return output;
}

function draw( v:Int, char:String ) return [for( i in 0...v ) char];
