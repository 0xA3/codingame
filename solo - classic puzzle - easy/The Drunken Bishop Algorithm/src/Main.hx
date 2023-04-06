import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.NumberConvert;

final width = 17;
final height = 9;
final top = "+---[CODINGAME]---+";
final bottom = "+-----------------+";

final directions = [
	"00" => [-1,-1],
	"01" => [ 1,-1],
	"10" => [-1, 1],
	"11" => [ 1, 1]
];

final symbols = [" ", ".", "o", "+", "=", "*", "B", "O", "X", "@", "%", "&", "#", "/", "^"];

function main() {

	final fingerprint = readline();
	
	final result = process( fingerprint );
	print( result );
}

function process( fingerprint:String ) {
	
	final hex = fingerprint.split( ":" );
	final bin = hex.map( s -> parseInt( '0x$s' ).toBin() ).map( s -> fillLeft( s, 8 ));
	
	final quadsPairs = bin.map( s -> [for( i in 0...4 ) s.charAt( i * 2 ) + s.charAt( i * 2 + 1 )]);
	
	final grid = [for( _ in 0...9 )[for(_ in 0...17) 0]];

	var x = int( width / 2 );
	var y = int( height / 2 );
	
	for( quadsPair in quadsPairs ) {
		for( i in -quadsPair.length + 1...1 ) {
			final pair = quadsPair[-i];
			final step = directions[pair];
			x = max( 0, min( width - 1, x + step[0] ));
			y = max( 0, min( height - 1, y + step[1] ));
			grid[y][x]++;
		}
	}

	final board = grid.map( row -> row.map( v -> symbols[v % symbols.length] ));
	board[4][8] = "S";
	board[y][x] = "E";

	final output = '$top\n' + board.map( row -> "|" + row.join( "" ) + "|" ).join( "\n" ) + '\n$bottom';
	return output;
}

function fillLeft( s:String, length:Int ) return s.length < length ? [for( _ in 0...length - s.length) "0"].join( "" ) + s : '$s';
function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
