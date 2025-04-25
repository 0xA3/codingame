import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;
import Std.parseInt;

using Lambda;
using xa3.NumberFormat;

typedef Entry = { row:Int, col:Int, value:Float };

function main() {

	final inputs = readline().split(' ');
	final m = parseInt(inputs[0]); // height of matrix A, height of result matrix
	final n = parseInt(inputs[1]); // width of Matrix A height of B
	final p = parseInt(inputs[2]); // width of Matrix B, width of result matrix
	final inputs = readline().split(' ');
	final countA = parseInt(inputs[0]); // number of nonzero etnries of A
	final countB = parseInt(inputs[1]); // number of nonzero etnries of B
	final matrix1Entries = readEntries( countA );
	final matrix2Entries = readEntries( countB );

	final result = process( m, n, p, matrix1Entries, matrix2Entries );
	print( result );
}

function readEntries( count:Int ) {
	return [for( i in 0...count ) {
		final inputs = readline().split(' ');
		final entry:Entry = { row: parseInt( inputs[0] ), col: parseInt( inputs[1] ), value: parseFloat( inputs[2] ) }
		entry;
	}];
}

function process( m:Int, n:Int, p:Int, matrix1Entries:Array<Entry>, matrix2Entries:Array<Entry> ) {
	// printErr( 'm: $m, n: $n, p: $p' );
	// printErr( "Matrix 1 entries" );
	// for( entry in matrix1Entries ) printErr( entry );
	// printErr( "Matrix 2 entries" );
	// for( entry in matrix2Entries ) printErr( entry );
	// printErr( "Matrix 1" );
	// printMatrix( n, m, matrix1Entries );
	// printErr( "Matrix 2" );
	// printMatrix( p, n, matrix2Entries );

	final matrix1Rows:Map<Int, Map<Int, Float>> = [];
	for( entry in matrix1Entries ) {
		if( !matrix1Rows.exists( entry.row ) ) matrix1Rows.set( entry.row,new Map<Int, Float>() );
		matrix1Rows[entry.row].set( entry.col, entry.value );
	}
	final matrix2Cols:Map<Int, Map<Int, Float>> = [];
	for( entry in matrix2Entries ) {
		if( !matrix2Cols.exists( entry.col ) ) matrix2Cols.set( entry.col, new Map<Int, Float>() );
		matrix2Cols[entry.col].set( entry.row, entry.value );
	}
	
	final resultEntries:Array<Entry> = [];
	for( row => colValues in matrix1Rows ) {
		// printErr( 'matrix1row $row, colValues: $colValues' );
		for( col => rowValues in matrix2Cols ) {
			// printErr( 'matrix2row $col, rowValues: $rowValues' );
			var mult = 0.0;
			for( col => colValue in colValues ) {
				if( rowValues.exists( col )) mult += colValue * rowValues[col];
			}
			if( mult != 0 ) resultEntries.push( { row: row, col: col, value: mult } );
		}
	}
	// printErr( "Result matrix" );
	// printMatrix( p, m, resultEntries );

	resultEntries.sort(( a, b ) -> {
		if( a.row != b.row ) return a.row - b.row;
		if( a.col != b.col ) return a.col - b.col;
		return 0;
	});

	final outputs = [];
	for( resultEntry in resultEntries ) {
		final vs = '${resultEntry.value}';
		final valueString = vs.indexOf( "." ) == -1 ? vs + ".0" : vs;
		outputs.push( '${resultEntry.row} ${resultEntry.col} $valueString' );
	}

	return outputs.join( "\n" );
}

function printMatrix( width:Int, height:Int, entries:Array<Entry>) {
	final matrix = [for( y in 0...height ) [for( x in 0...width ) 0.0]];
	for( entry in entries ) {
		// printErr( 'Entry ${entry.col}:${entry.row} = ${entry.value.number( 2 )}' );
		matrix[entry.row][entry.col] = entry.value;
	}

	printErr( matrix.map( row -> row.map( v -> v.number( 2 )).join( " " )).join( "\n" ));
}
