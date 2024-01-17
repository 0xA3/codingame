import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {
	final sideSize = parseInt( readline());
	final rows = [for( _ in 0...sideSize ) readline()];
	
	final result = process( sideSize, rows );
	print( result );
}

function process( sideSize:Int, rows:Array<String> ) {
	final halfSize = int( sideSize / 2 );
	final quads = [[],[],[],[]];
	for( y in 0...rows.length ) {
		final offset = int( y / halfSize ) * 2;
		quads[offset].push( rows[y].substr( 0, halfSize ));
		quads[offset + 1].push( rows[y].substr( halfSize ));
	}

	final sums = quads.map(
		quad -> quad.join("").split( "" )
		.map( char -> char == "." ? 0 : Std.parseInt( char ))
		.fold(( v, sum ) -> sum + v, 0 )
	);

	final occurrences:Map<Int, Int> = [];
	for( sum in sums ) {
		if( occurrences.exists( sum )) occurrences[sum]++;
		else occurrences.set( sum, 1 );
	}

	final oddValue = [for( value => occurence in occurrences ) if( occurence == 1 ) value][0];
	final otherValues = [for( value => occurence in occurrences ) if( occurence == 3 ) value][0];
	final quadWithOddValue = sums.indexOf( oddValue ) + 1;
	
	return 'Quad-$quadWithOddValue is Odd-Quad-Out\nIt has value of $oddValue\nOthers have value of $otherValues';
}
