import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using StringTools;
using xa3.StringUtils;

/*
You have to build a tree based on the following 2 inputs:
size: size of the tree base
decorator: decorator of the tree.
additionally at the end you will have to put a | in the middle like a tree trunk.
the decoration of the tree must be separated by spaces.

Input
4
*

Output
   *
  * *
 * * *
* * * *
   |

*/

function main() {

	final size = parseInt( readline());
	final decorator = readline();
	
	print( process( size, decorator ));
}

function process( size:Int, decorator:String ) {
	
	final tree = [for( i in 0...size ) {
		" ".repeat( size - i - 1 ) + '$decorator '.repeat( i + 1 ).trim();
	}].join( "\n" );

	final trunk = " ".repeat( size - 1 ) + "|";

	return tree + "\n" + trunk;
}
