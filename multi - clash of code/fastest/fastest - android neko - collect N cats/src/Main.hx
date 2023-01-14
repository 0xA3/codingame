import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.ERegUtils;
using xa3.NumberConvert;
using xa3.StringUtils;

/*
Android Neko is a game developed by Android as an easter egg for Android 7 and 11. In Android 7, you play it like this:

1) Choose the food you want to put in the bowl
2) Wait for a random cat to come
3) Name it (If you want to)

How long would it take to speedrun the game (in seconds) if you collect N cats if it takes:

1) P seconds to place food for 1 cat
2) C + ((i-1)*2)) seconds to collect the ith cat
3) R seconds to name a cat

Input
1
10
60
6

Output
76
*/

function main() {

	final n = parseInt( readline());
	final p = parseInt( readline());
	final c = parseInt( readline());
	final r = parseInt( readline());
	
	var sum = 0;
	for( i in 1...n + 1 ) sum += p + c + (( i - 1 ) * 2 ) + r;

	print( sum );
}
