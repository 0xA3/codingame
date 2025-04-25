import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;
import Std.parseInt;

using Lambda;

typedef Entry = { row:Int, col:Int, value:Float };

function main() {

	final inputs = readline().split(' ');
	final m = parseInt(inputs[0]); // height of Matrix A
	final n = parseInt(inputs[1]); // width of Matrix A height of B
	final p = parseInt(inputs[2]); // width of Matrix B
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
	

	
	return "";
}

function printMatrix() {
	
}
