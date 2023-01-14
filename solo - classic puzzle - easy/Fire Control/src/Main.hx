import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Lambda;
using xa3.MathUtils;

final size = 6;

function main() {

	final forest = [for( _ in 0...size ) readline().split( "" )];
	
	final result = process( forest );
	print( result );
}

function process( forest:Array<Array<String>> ) {

	var numTrees = [for( line in forest ) for( cell in line ) if( cell == "#" ) true].length;
	
	var numFire = 0;
	var treesToCut = 0;
	for( y in 0...forest.length ) {
		for( x in 0...forest[y].length ) {
			if( forest[y][x] == "*" ) {
				numFire++;
				for( neighborCoord in getNeighborCoords( x, y )) {
					if( forest[neighborCoord[1]][neighborCoord[0]] == "#" ) {
						forest[neighborCoord[1]][neighborCoord[0]] = "=";
						numTrees--;
						treesToCut++;
					}
				}
			}
			// trace( 'cell $x:$y $cell  numFire $numFire  numTrees $numTrees' );
		}
	}
	// trace( 'numFire $numFire  numTrees $numTrees  treesToCut $treesToCut' );
	return numFire == 0 ? "RELAX" : numTrees == 0 || treesToCut == 0 ? "JUST RUN" : '$treesToCut';
}

function getNeighborCoords( fireX:Int, fireY:Int ) {
	final top = ( fireY - 2 ).max( 0 );
	final bottom = ( fireY + 3 ).min( size );
	final left = ( fireX - 2 ).max( 0 );
	final right = ( fireX + 3 ).min( size );
	// trace( 'top $top bottom $bottom left $left right $right' );
	return [for( y in top...bottom ) for( x in left...right ) [x, y]];
}
