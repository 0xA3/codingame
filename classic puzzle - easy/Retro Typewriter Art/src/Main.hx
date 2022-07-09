import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringUtils;

function main() {
		
	final t = readline();
	
	final result = process( t );
	print( result );
}

function process( t:String ) {
	final commands = t.split(" ").map( chunk -> parseChunk( chunk ));

	final chars = commands.map( command -> [for( _ in 0...command.reps ) command.char].join( "" ));
	final output = chars.join( "" );

	return output;
}

function parseChunk( chunk:String ):Command {
	if( chunk == "nl" ) return { char: "\n", reps: 1 }
	if( chunk.contains( "sp" )) return { char: " ", reps: getReps2( chunk )}
	if( chunk.contains( "bS" )) return { char: "\\", reps: getReps2( chunk )}
	if( chunk.contains( "sQ" )) return { char: "'", reps: getReps2( chunk )}
	return { char: chunk.substr( chunk.length - 1 ), reps: getReps1( chunk )}
}	

function getReps1( s:String ) return parseInt( s.substr( 0, s.length - 1 ));
function getReps2( s:String ) return parseInt( s.substr( 0, s.length - 2 ));


typedef Command = {
	final char:String;
	final reps:Int;
}

