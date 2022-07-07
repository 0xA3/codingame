import xa3.MathUtils;
import haxe.Timer;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using xa3.MathUtils;

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
final wordCodes:Map<String, Float> = [];
final codeWords:Map<String, Array<String>> = [];
var subResults:Array<Float>;
var codeLengths:Array<Int>;

function main() {
		
	final inputSequence = readline();
	final n = parseInt( readline() );
	final words = [for( i in 0...n ) readline()];
		
	final result = process( inputSequence, words );
	print( result );
}

function process( inputSequence:String, words:Array<String> ) {
	final start = Timer.stamp();
	sequence = inputSequence;

	wordCodes.clear();
	codeWords.clear();
	subResults = [for( _ in 0...sequence.length ) -1];
	codeLengths = [];

	words.iter( word -> createWordCodes( word ));
	for( wordCode in wordCodes.keys()) if( !codeLengths.contains( wordCode.length )) codeLengths.push( wordCode.length );
	codeLengths.sort(( a, b ) -> a - b );

	// trace( 'sequence $sequence   length ${sequence.length}' );
	// for( code => amount in wordCodes ) trace( '$amount code $code ${codeWords[code]}' );
	// trace( 'codeLengths $codeLengths' );

	final result = search( 0 );
	// final subResultOutput = subResults.map( v -> v == -1 ? "." : '$v' ).join(" ");
	// trace( 'subResults [$subResultOutput]' );
	
	// final output = [];
	// for( i in 0...subResults.length ) if( subResults[i] > 0 ) output.push( 'subResults[$i]: ${subResults[i]}' );
	// trace( output.join( "\n" ));

	// printErr( 'Duration ${Math.round(( Timer.stamp() - start ) * 1000 )}ms' );
	return result;
}

function createWordCodes( word:String ) {
	var wordCode = "";
	for( i in 0...word.length ) wordCode += encoding[word.charAt( i )];
	if( sequence.indexOf( wordCode ) == -1 ) return;

	if( wordCodes.exists( wordCode )) {
		wordCodes[wordCode]++;
		codeWords[wordCode].push( word );
	} else {
		wordCodes.set( wordCode, 1 );
		codeWords.set( wordCode, [word] );
	}
}

function search( offset:Int ):Float {
	if( offset == sequence.length ) {
		// trace( 'offset $offset  end of sequence' );
		return 1.;
	}
	if( subResults[offset] != -1 ) {
		// trace( 'return subresult for $offset  ${subResults[offset]}' );
		return subResults[offset];
	}

	var result:Float = 0;
	for( i in codeLengths ) {
		if( offset + i > sequence.length ) {
			// trace( 'overflow ${offset + i}' );
			return result;
		}
		final subSequence = sequence.substr( offset, i );
		// trace( '$offset ${offset + i} check $subSequence  exists ${wordCodes.exists( subSequence )} ' );
		if( wordCodes.exists( subSequence )) {
			// trace( 'result += ${codeWords[subSequence]} * search( ${offset + i} )' );
			result += wordCodes[subSequence] * search( offset + i );
			// trace( 'result = $result' );
		}
	}
	// trace( 'set subResults[$offset] to $result' );
	subResults[offset] = result;
	
	return result;
}