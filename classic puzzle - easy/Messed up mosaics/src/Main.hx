import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

function main() {

	final n = parseInt( readline() );
	final pattern = readline();
	final rows = [for( _ in 0...n ) readline()];
	
	final result = process( pattern, rows );
	print( result );
}

function process( pattern:String, rows:Array<String> ) {
	final rowLength = rows[0].length;
	final repeats = int( rowLength / pattern.length ) + 2;
	final patternRow = [for( _ in 0...repeats ) pattern].join( "" );
	final patternVariations = [for( i in 0...pattern.length) patternRow.substr( i )];

	for( i in 0...rows.length ) {
		final minDifference = getMinDifference( rows[i], patternVariations );
		if( minDifference.minDifference == 1 ) return '(${minDifference.pos},${i})';
	}
	
	return '';
}

function getMinDifference( row:String, patternVariations:Array<String> ) {
	var pos = 0;
	var minDifference = row.length;
	var variationId = 0;
	for( i in 0...patternVariations.length ) {
		final differencesNum = getDifferencesNum( row, patternVariations[i] );
		final differences = differencesNum.differences;
		if( differencesNum.differences < minDifference ) {
			minDifference = differences;
			pos = differencesNum.pos;
			variationId = i;
		}
	}
	
	return { minDifference: minDifference, pos: pos };
}

function getDifferencesNum( row:String, patternVariation:String ) {
	var pos = 0;
	var differences = 0;
	for( i in 0...row.length ) if( row.charAt( i ) != patternVariation.charAt( i )) {
		pos = i;
		differences++;
	}

	return { pos: pos, differences: differences };
}
