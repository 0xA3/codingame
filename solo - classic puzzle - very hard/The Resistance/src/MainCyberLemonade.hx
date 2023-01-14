import xa3.MathUtils;
import haxe.Timer;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

final encoding = [
	"A" => ".-",
	"B" => "-...",
	"C" => "-.-.",
	"D" => "-..",
	"E" => ".",
	"F" => "..-.",
	"G" => "--.",
	"H" => "....",
	"I" => "..",
	"J" => ".---",
	"K" => "-.-",
	"L" => ".-..",
	"M" => "--",
	"N" => "-.",
	"O" => "---",
	"P" => ".--.",
	"Q" => "--.-",
	"R" => ".-.",
	"S" => "...",
	"T" => "-",
	"U" => "..-",
	"V" => "...-",
	"W" => ".--",
	"X" => "-..-",
	"Y" => "-.--",
	"Z" => "--..",
];

var sequence:String;
final occur = new Map<String, Float>();
var combos:Array<Float>;
var max:Int;

function main() {
		
	final inputSequence = readline();
	final n = parseInt( readline() );
	final words = [for( i in 0...n ) readline()];
		
	final result = process( inputSequence, words );
	print( result );
}

function process( inputSequence:String, words:Array<String> ) {
	sequence = inputSequence;
	//trace( 'sequence $sequence' );
	final start = Timer.stamp();
	
	occur.clear();
	combos = [for( _ in 0...sequence.length) -1];
	max = 0;

	words.iter( word -> morph( word ));
	
	final result = tryCombos( 0 );
	//trace( combos );
	printErr( 'Duration ${Math.round(( Timer.stamp() - start ) * 1000 )}ms' );
	return result;
}

function morph( word:String ) {
	var morphed = "";
	for( i in 0...word.length ) {
		morphed += encoding[word.charAt( i )];
		if( sequence.indexOf( morphed ) == -1 ) {
			//trace( '$word is not in sequence' );
			return;
		}
	}

	var freq = 1.0;
	if( occur.exists( morphed )) {
		freq += occur[morphed];
		//trace( '$morphed is already in occur. Set freq to $freq' );
	} else {
		max = MathUtils.max( max, morphed.length );
		//trace( 'morph set $word "$morphed" to $freq   max $max' );
	}
	occur.set( morphed, freq );
}

function tryCombos( start:Int ):Float {
	//trace( 'tryCombos $start' );
	if( start == sequence.length ) {
		//trace( 'end of sequence' );
		return 1;
	}
	if( combos[start] != -1 ) {
		//trace( 'return combos[$start]: ${combos[start]}' );
		return combos[start];
	}
	
	var result:Float = 0;
	var i = 1;
	while( i <= max && start + i <= sequence.length ) {
		final sub = sequence.substring( start, start + i);
		//trace( '$start ${start + i} check $sub  exists ${occur.exists( sub )} ' );
		if( occur.exists( sub )) {
			//trace( 'result += occur[$sub] ${occur[sub]} * tryCombos( ${start + i} )' );
			result += occur[sub] * tryCombos( start + i );
			//trace( 'result = $result' );
		}
		i++;
	}
	//trace( 'set combos[$start] to ${result}' );
	combos[start] = result;
	
	return result;
}