import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;
import Math.floor;

using Lambda;

function main() {
		
	final x = readline();
	final n = parseInt( readline() );
	
	final result = process( x, n );
	print( result );
}

function process( x:String, n:Int ) {
	final decoded = decode( x );
	final result = add( decoded, n );
	final encoded = encode( result );
	return encoded;
}

function decode( x:String ) {
	final parts = x.split( "-" );
	final c0 = parts[0].split( "" );
	final num = parseInt( parts[1] ) - 1;
	final c1 = parts[2].split( "" );

	final chars = c0.concat( c1 ).map( s -> char2Num( s ));
	final decoded = chars.concat( [num] );
	
	return decoded;
}

function add( d:Array<Int>, n:Int ) {
	final mods = [26, 26, 26, 26, 999];
	var dn = n;
	final results = [];
	for( r in -d.length + 1...1 ) {
		final i = -r;
		dn = d[i] + dn;
		results[i] = ( dn % mods[i] );
		
		dn = floor( dn / mods[i] );
	}

	return results;
}

function encode( d:Array<Int> ) {
	final p0 = [d[0], d[1]].map( v -> num2Char( v )).join( "" );
	final p1 = tripleDigits( d[4] + 1 );
	final p2 = [d[2], d[3]].map( v -> num2Char( v )).join( "" );

	return '$p0-$p1-$p2';
}

function char2Num( s:String ) return s.charCodeAt( 0 ) - 65;
function num2Char( v:Int ) return String.fromCharCode( v + 65 );

function tripleDigits( v:Int ) {
	final sv = '$v';
	final s = [for( _ in sv.length...3 ) "0"].join( "" ) + sv;

	return s;
}