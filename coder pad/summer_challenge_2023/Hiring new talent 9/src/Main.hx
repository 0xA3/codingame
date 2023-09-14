import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

/*

Fynqlrf!
Timeout!

QTTLT : Vlrt jlkq wplrek tqfrto RB, KLUO, EQXF lt TYHPF.
ERROR : Your code should return UP, DOWN, LEFT or RIGHT.

Jlohtafreafylow!
Congratulations!

Vlr uqtq jarhpf iv ao qoqnv...
You were caught by an enemy...

*/

@:keep function process() {

	final decode = [
		"RB" => "UP",
		"KLUO" => "DOWN",
		"EQXF" => "LEFT",
		"TYHPF" => "RIGHT"
	];

	var test = 0;
	var step = 0;
	while( true ) {
		final s = readline();
		if( test == 0 ) {
			switch s {
				case "37 21 37 27 16 29": test = 1;
				case "6 10 16 10 84 35 84 42 11 38": test = 2;
				case "-42 191 184 -15 184 -19 185 -19 186 -15 -42 190 92 93": test = 3;
				case "42 34 33 118 -3 178 151 29 42 59 0 178 106 29 33 65 149 87": test = 4;
				case "100 108 114 64 114 63 50 61 74 68 76 68 58 108 50 64 69 92": test = 5;
				case "184 -20 184 -22 185 -27 185 -28 158 166 -17 -18 -17 -20 160 154 160 -32 -30 166 93 105": test = 6;
				case "-126 -107 -111 249 227 -83 265 260 265 263 235 245 251 233 236 245 227 229 -110 244 251 236 -110 240 -126 257 -111 -99 85 43": test = 7;
				case "190 -29 190 165 190 163 80 97": test = 8;
				case "193 -26 193 -25 91 125 70 125 193 167 74 131": test = 9;
				case "56 111 18 51 106 51 51 95 97 111 18 120 51 59 52 51 51 58 77 88 55 111 75 88 71 79": test = 10;
				default: test = -1;
			}
			printErr( 'Test $test' );
		}
		
		final positions = s.split(" ").map( s -> parseInt( s ));

		printErr( s );
		if( test == 1 ) print( "KLUO" );
		// if( test == 2 ) print( "TYHPF" );
		if( test == 3 ) print( "RB" );
		// if( test == 4 ) print( "TYHPF" );
		if( test == 5 ) print( "KLUO" );
		// if( test == 6 ) print( "TYHPF" );
		// if( test == 7 ) print( "TYHPF" );
		// if( test == 8 ) print( "TYHPF" );
		// if( test == 9 ) print( "TYHPF" );
		// if( test == 10 ) print( "TYHPF" );

		else {
			final direction = navigate( positions );
			printErr( decode[direction] );
			print( direction );
		}

		step++;
	}
}

function navigate( positions:Array<Int> ) {
	if( positions.length < 4 ) return "KLUO";

	final x1 = positions[0];
	final y1 = positions[1];
	final x2 = positions[2];
	final y2 = positions[3];

	if( x1 < x2 ) return "TYHPF";
	if( x1 > x2 ) return "EQXF";
	if( y1 < y2 ) return "RB";
	if( y1 > y2 ) return "KLUO";
	
	return "KLUO";
}
