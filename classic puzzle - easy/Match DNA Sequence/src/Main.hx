import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final delta = parseInt( readline() );
	final gene = readline();
	final n = parseInt( readline() );
	var chrs = [for( _ in 0...n ) readline()];
	
	final result = process( delta, gene, chrs );
	print( result );
}

function process( delta:Int, gene:String, chrs:Array<String> ) {

	for( i in 0...chrs.length ) {
		final chr = chrs[i];
		for( o in 0...chr.length + 1 - gene.length + delta ) {
			final errors = countErrors( gene, chr.substr( o ));
			if( errors <= delta ) {
				return '$i $o $errors';
			}
		}
	}
	return "NONE";
}

function countErrors( s1:String, s2:String ) {
	var errors = 0;
	for( i in 0...s1.length ) {
		final c1 = s1.charAt( i );
		final c2 = s2.length < i ? "" : s2.charAt( i );
		if( c1 != c2 ) errors++;
	}
	return errors;
}
