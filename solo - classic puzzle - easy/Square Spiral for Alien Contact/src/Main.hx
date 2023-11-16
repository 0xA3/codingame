import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using StringTools;

function main() {

	final crypticInstructions = readline();
	
	final result = process( crypticInstructions );
	print( result );
}

function process( crypticInstructions:String ) {
	final instructions = crypticInstructions.split(" ");
	final sideSize = parseInt( instructions[0] );
	final start = instructions[1];
	final spin = instructions[2];
	final pattern1 = instructions[3];
	final pattern2 = instructions[4];

	final char1 = pattern1.charAt( 0 );
	final amount1 = parseInt( pattern1.substr( 1 ));
	final char2 = pattern2.charAt( 0 );
	final amount2 = parseInt( pattern2.substr( 1 ));
	final charDelta = pattern2.charCodeAt( 0 ) - pattern1.charCodeAt( 0 );
	final amountDelta = amount2 - amount1;

	final charGenerator = new CharGenerator( char1, charDelta, amount1, amountDelta );
	final spiralGenerator = new SpiralGenerator( sideSize, start, spin );

	spiralGenerator.generate( charGenerator );

	final output = spiralGenerator.getOutput();

	// trace( "\n" + output );

	return output;
}
