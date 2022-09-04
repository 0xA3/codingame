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
With my first computer, a TI-99/4A, the CHAR subprogram allows to define your own special graphics characters. You could find the original documentation here: https://www.99er.net/files/userrefguide.pdf#page=96

A character is drawn using a 8x8 grid of pixels.
An hexadecimal digit describes 4 pixels, so the pattern is composed of 8 rows of hexadecimal pairs which are grouped to form a 16 digits string.

In the hexadecimal pattern, most significant bits are drawn on the left.
*/

function main() {

	final pattern = readline();
	print( process( pattern ));
}

function process( pattern:String ) {
	final doubleBytes = [for( i in 0...int( pattern.length / 2 )) pattern.charAt( i * 2 ) + pattern.charAt( i * 2 + 1 )];
	final dec = doubleBytes.map( s -> s.hexToDec());
	final bitRows = dec.map( v -> v.toBaseN( 2 ));
	final bitRows8 = bitRows.map( bitRow -> fill( bitRow ));
	final lines = bitRows8.map( s -> format( s ));
	
	return lines.join( "\n" );
}

function fill( s:String ) return [for( _ in 0...8 - s.length ) "0"].join("") + s;
function format( s:String ) return s.split("").map( s -> s == "0" ? "." : "#" ).join( "" );

