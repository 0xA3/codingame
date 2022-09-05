import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.StringUtils;

/*
You have to split a text t by the first occurrence of the match (case sensitive).

Return a tuple with three elements:
1 - everything before the "match"
2 - the "match"
3 - everything after the "match"

Example:
t = "I love coding and I love apples"
match = "love"

Output should be:
I
love
 coding and I love apples

 I love coding and I love apples
love

I 
love
 coding and I love apples

*/

function main() {

	final t = readline();
	final match = readline();
	final parts = t.split( match );
		
	print( '${parts[0]}\n$match\n' + parts.slice( 1 ).join( match ));
}
