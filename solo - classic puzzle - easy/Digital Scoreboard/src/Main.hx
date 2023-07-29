import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;
using StringTools;

final numbers = [
" ~~~ 
|   |
     
|   |
 ~~~ ",
"     
    |
     
    |
     ",
" ~~~ 
    |
 ~~~ 
|    
 ~~~ ",
" ~~~ 
    |
 ~~~ 
    |
 ~~~ ",
"     
|   |
 ~~~ 
    |
     ",
" ~~~ 
|    
 ~~~ 
    |
 ~~~ ",
" ~~~ 
|    
 ~~~ 
|   |
 ~~~ ",
" ~~~ 
    |
     
    |
     ",
" ~~~ 
|   |
 ~~~ 
|   |
 ~~~ ",
" ~~~ 
|   |
 ~~~ 
    |
 ~~~ ",
].map( s -> s.replace( "\r", "" ));

function main() {

	final grid = [for( i in 0...23 ) readline().split( "" )];
	
	final result = process( grid );
	print( result );
}

function process( grid:Array<Array<String>> ) {
	final startBoard = grid.slice( 1, 6 );
	final subtractBoard = grid.slice( 9, 14 );
	final addBoard = grid.slice( 17, 22 );
	
	// trace( "\n" + grid2String( startBoard ));
	// trace( "\n" + grid2String( subtractBoard ));
	// trace( "\n" + grid2String( addBoard ));
	
	final afterSubtraction = subtract( startBoard, subtractBoard );
	final afterAddition = add( afterSubtraction, addBoard );
	// trace( "\n" + grid2String( afterAddition ));

	final result = parseBoard( afterAddition );

	return result;
}

function subtract( grid1:Array<Array<String>>, grid2:Array<Array<String>> ) {
	final result = copy( grid1 );
	for( y in 0...grid2.length ) for( x in 0...grid2[y].length ) {
		if( grid1[y][x] == " " && grid2[y][x] != " " ) throw "Error: cannot subtract something from nothing.";
		if( grid2[y][x] != " " ) result[y][x] = " ";
	}
	return result;
}

function add( grid1:Array<Array<String>>, grid2:Array<Array<String>> ) {
	final result = copy( grid1 );
	for( y in 0...grid2.length ) for( x in 0...grid2[y].length ) {
		if( grid2[y][x] != " " ) result[y][x] = grid2[y][x];
	}
	return result;
}

function parseBoard( grid:Array<Array<String>> ) {
	final s1 = grid.map( row -> row.slice( 2, 7 )).map( row -> row.join( "" )).join( "\n" );
	final s2 = grid.map( row -> row.slice( 10, 15 )).map( row -> row.join( "" )).join( "\n" );

	// trace( "\n" + s1 );
	// trace( "\n" + s2 );

	final n1 = parseNumber( s1 );
	final n2 = parseNumber( s2 );
	return '$n1$n2';
}

function parseNumber( s:String ) {
	for( i in 0...numbers.length ) if( s == numbers[i] ) return i;
	throw 'Error:\n$s\n is no valid number';
}

function copy( a:Array<Array<String>> ) {
	return a.map( row -> row.copy());
}

function grid2String( grid:Array<Array<String>> ) {
	return grid.map( row -> row.join( "" )).join( "\n" );
}