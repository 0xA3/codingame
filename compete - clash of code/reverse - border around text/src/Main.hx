import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final a = readline();
	final l = a.length;
	final lines = [];
	lines.push([for( _ in 0...l + 4 ) "*" ].join(""));
	lines.push( "* " + a + " *" );
	lines.push([for( _ in 0...l + 4 ) "*" ].join(""));
	print( lines.join("\n") );
}


