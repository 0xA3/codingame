import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import xa3.MathUtils;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
You will receive a list of passwords with different conditions attached to them. A password is only valid if the specified letter x occurs at least a times and at most b times. How many passwords are valid?

20
6-8 s: svsssszslpsp
3-4 n: gncn
4-8 v: vkvmvdmvhttvvrgvvwv
16-18 j: jjjjjjjjjjjjjjjjjf
13-15 p: pppppppvppppxxppp
3-4 k: bkksggqbtwkkkzqcz
8-18 x: qxphxxtczxxxxxrbxxl
6-11 c: dccxcccccchrcfdckcsc
10-11 c: ccvxccccccccc
2-4 f: pszff
18-20 z: zzzzzzzzzzwzzzzzzzzj
1-7 g: ggggggpggggggg
3-5 h: hhhhfhh
2-5 x: dxxzxv
7-8 s: ssssssss
3-9 k: ktkkkkkklkck
2-9 r: rzrrrrrrrrrrrr
5-9 k: tkrkhkxbvkbkkkkk
8-9 n: tnnpbnrns
14-15 q: qqqqqqqqqqqqqqqq

Output
11
*/

class Main {
	
	static function main() {
		
		final n = parseInt( readline());
		var sum = 0;
		for( _ in 0...n ) {
			final parts = readline().split(" ");
			final range = parts[0].split( "-" );
			final from = parseInt( range[0] );
			final to = parseInt( range[1] );
			final char = parts[1].charAt( 0 );
			final count = parts[2].count( char );
			if( count >= from && count <= to ) sum++;
		}
		print( sum );
	}
}
