import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.ArrayUtils;
using xa3.StringUtils;

function main() {

	final n = parseInt( readline() );
	final lines = [for( _ in 0...n ) readline()];
	
	final result = process( lines );
	print( result );
}

function process( lines:Array<String> ) {
	final outputs = lines.map( line -> smoosh( line ));

	return outputs.join( "\n" );
}

function smoosh( line:String ) {
	final words = line.split(" ");
	final name1 = words[0];
	final name2 = words[2];

	final merges = merge( name1.toLowerCase(), name2.toLowerCase() );
	final result = merges.length == 0 ? "NONE" : merges.join(" ");
	return '$name1 plus $name2 = $result';
}

function merge( name1:String, name2:String ) {
	final merges = [];
	final maxLength = max( name1.length, name2.length );
	for( l in -maxLength...0 ) { // countdown from maxLength to 1
		final charLength = -l;
		if( charLength < name2.length ) {
			final combinations = getCombinations( name1, name2, charLength );
			for( c in combinations ) merges.push( c );
		}
		if( charLength < name1.length ) {
			final combinations = getCombinations( name2, name1, charLength );
			for( c in combinations ) merges.push( c );
		}

		if( merges.length > 0 ) break;
	}
	merges.sort(( a, b ) -> a > b ? 1 : -1 );
	final uniqueMerges = merges.uniquify();
	
	return uniqueMerges;
}

function getCombinations( s1:String, s2:String, charLength:Int ) {
	final minLength = min( s1.length, s2.length );
	// trace( '$charLength chars with $s1 $s2' );
	final combinations = [];
	for( i in 1...s1.length - charLength + 1 ) {
		final chars = s1.substr( i, charLength );
		final indices = getCharIndices( s2, chars );
		// trace( 'chars: "$chars"  indices $indices' );
		for( index in indices ) {
			final left = s1.substr( 0, i );
			final right = s2.substr( index + charLength );
			final name = left + chars + right;
			if( right != "" && name.length >= minLength && name != s1 && name != s2 ) {
				// trace( 'found: $name' );
				combinations.push( c( name ));
			}
		}
	}
	return combinations;
}

function getCharIndices( s:String, chars:String ) {
	final indices = [];
	var index = -1;
	while( true ) {
		index = s.indexOf( chars, index + 1 );
		if( index != -1 ) indices.push( index );
		else break;
	}
	return indices;
}

function c( s:String ) return s.charAt( 0 ).toUpperCase() + s.substr( 1 );
function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;