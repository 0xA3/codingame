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

	final chars = commands.map( command -> [for( _ in 0...command.repetitions ) command.char].join( "" ));
	final output = chars.join( "" );

	return output;
}

function parseChunk( chunk:String ):Command {
	if( chunk == "nl" ) return { char: "\n", repetitions: 1 }
	if( chunk.contains( "sp" )) return { char: " ", repetitions: parseInt( chunk.substr( 0, chunk.length - 2 ))}
	if( chunk.contains( "bS" )) return { char: "\\", repetitions: parseInt( chunk.substr( 0, chunk.length - 2 ))}
	if( chunk.contains( "sQ" )) return { char: "'", repetitions: parseInt( chunk.substr( 0, chunk.length - 2 ))}
	return { char: chunk.substr( chunk.length - 1 ), repetitions: parseInt( chunk.substr( 0, chunk.length - 1 ))}
}	


typedef Command = {
	final char:String;
	final repetitions:Int;
}

