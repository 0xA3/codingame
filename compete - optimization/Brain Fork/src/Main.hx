import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import xa3.MathUtils.abs;

using Converter;
using Distance;
using Lambda;


inline var NUM_ZONES = 30;
inline var ALPHABET = " ABCDEFGHIJKLMNOPQRSTUVWXYZ";

var charMap:Map<String, Int>;
var charCodeMap:Map<Int, String>;

function main() {

	final magicPhrase = readline();
	printErr( magicPhrase );
	
	final program = process( magicPhrase );
	print( program );
}

function process( magicPhrase:String ) {
	
	charMap = [for( i in 0...ALPHABET.length ) ALPHABET.charAt( i ) => i ];
	charCodeMap = [for( i in 0...ALPHABET.length ) i => ALPHABET.charAt( i )];
	
	final charCodes = magicPhrase.separate( charMap );
	
	var position = 0;

	final zoneValues = [for( _ in 0...NUM_ZONES ) 0];
	final commands = [];

	for( c in charCodes ) {
		// trace( 'char $c ${charCodeMap[c] )}' );
		var dPos = NUM_ZONES;
		var dValue = ALPHABET.length;
		var minDistance = dPos + dValue;
		for( z in 0...NUM_ZONES ) {
			final posOffset = position.getDistance( z, NUM_ZONES );
			final valueOffset = zoneValues[z].getDistance( c, ALPHABET.length );
			final sum = abs( posOffset ) + abs( valueOffset );
			if( sum < minDistance ) {
				minDistance = sum;
				dPos = posOffset;
				dValue = valueOffset;
			}
		}
		position = ( NUM_ZONES + position + dPos ) % NUM_ZONES;
		zoneValues[position] = ( ALPHABET.length + zoneValues[position] + dValue ) % ALPHABET.length;
		// trace( 'dPos $dPos  dValue $dValue' );
		final posCommand = dPos > 0 ? ">" : "<";
		final distancePos = abs( dPos );
		for( _ in 0...distancePos ) {
			commands.push( posCommand );
		}
		
		final valueCommand = dValue > 0 ? "+" : "-";
		final distanceValue = abs( dValue );
		for( _ in 0...distanceValue ) commands.push( valueCommand );
		commands.push( "." );
		// trace( commands.join( "" ));
	}

	return commands.join( "" );
}
