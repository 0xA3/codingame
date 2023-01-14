import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

var randomSeed:Int;

function main() {

	final t = readline();
	final d = parseInt( readline() );
	final l = parseInt( readline() );
	final s = readline();
	
	final result = process( t, d, l, s );
	print( result );
}

function process( text:String, depth:Int, length:Int, seed:String ) {
	
	randomSeed = 0;

	final words = text.split(" ");
	if( words.length < depth + 1 ) throw 'Error: Text generator needs at least ${depth + 1} words';
	
	final chain:Map<String, Array<String>> = [];
	for( i in 0...words.length - depth ) {
		final nGram = [for( o in 0...depth ) words[i + o]].join(" ");
		final option = words[i + depth];
		
		if( !chain.exists( nGram )) chain.set( nGram, [] );
		
		final options = chain[nGram];
		if( !options.contains( option )) options.push( option );
		// trace( '$nGram => $options' );
	}
	
	final output = seed.split(" ");
	for( i in output.length - depth...length - depth ) {
		final nGram = [for( o in 0...depth ) output[i + o]].join(" ");
		final options = chain.exists( nGram ) ? chain[nGram] : throw 'Error: nGram "$nGram" not found in chain';
		
		final optionIndex = pickOptionIndex( options.length );
		output.push( options[optionIndex] );
		// trace( '$nGram $options $optionIndex  ${options[optionIndex]}  "${output.join(" ")}"' );
	}
	return output.join(" ");
}

function pickOptionIndex( numOfOptions:Int ) {
	randomSeed += 7;
	return randomSeed % numOfOptions;
}
