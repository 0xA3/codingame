import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.floor;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {
	
	final inputs = readline().split(' ');
	final w = parseInt( inputs[0] );
	final h = parseInt( inputs[1] );
	final t1 = parseInt( inputs[2] );
	final t2 = parseInt( inputs[3] );
	final t3 = parseInt( inputs[4] );
	final firstPictureRows = [];
	final secondPictureRows = [];
	for( i in 0...h ) {
		var inputs = readline().split(' ');
		firstPictureRows.push( inputs[0] );
		secondPictureRows.push( inputs[1] );
	}
		
	final result = process( w, h, t1, t2, t3, firstPictureRows, secondPictureRows );
	print( result );
}	

function process( w:Int, h:Int, t1:Int, t2:Int, t3:Int, firstPictureRows:Array<String>, secondPictureRows:Array<String> ) {
	
	final p1 = getPositions( firstPictureRows );
	final p2 = getPositions( secondPictureRows );
	final d12 = t2 - t1;
	final d13 = t3 - t1;
	
	final velocities:Map<String, Velocity> = [];
	for( id => a1 in p1 ) {
		final a2 = p2[id];
		final dx = ( a2.x - a1.x ) / d12;
		final dy = ( a2.y - a1.y ) / d12;
		velocities.set( id, { x: dx, y: dy });
	};
	
	final p3:Map<String, Position> = [];
	for( id => a1 in p1 ) {
		final velocity = velocities[id]		;
		final x3 = velocity.x * d13 + a1.x;
		final y3 = velocity.y * d13 + a1.y;
		p3.set( id, { x: floor( x3 ), y: floor( y3 )} );
	};

	final resultGrid = [];
	for( y in 0...h ) {
		final row = [];
		for( x in 0...w ) row[x] = ".";
		resultGrid[y] = row;
	}

	// for( id => a1 in p1 ) {
	// 	final a2 = p2[id];
	// 	final v = velocities[id];
	// 	final a3 = p3[id];
	// 	trace( '$id $a1 $a2 $v $a3' );
	// }
	
	for( id => a3 in p3 ) {
		final x = a3.x;
		final y = a3.y;
		if( x >= 0 && x < w && y >= 0 && y < h ) {
			final cell = resultGrid[y][x];
			if( cell == "." || cell > id ) resultGrid[y][x] = id;
		}
	}

	final result = resultGrid.map( row -> row.join("") ).join( "\n" );
	return result;
}

function getPositions( pictureRows:Array<String> ) {
	
	final pictureGrid = pictureRows.map( row -> row.split( "" ));
	final asteroidPositions:Map<String, Position> = [];
	for( y in 0...pictureGrid.length ) {
		final row = pictureGrid[y];
		for( x in 0...pictureGrid.length ) {
			final char = row[x];
			if( char != "." ) asteroidPositions.set( char, { x: x, y: y });
		}
	}
	return asteroidPositions;
}

typedef Position = {
	final x:Int;
	final y:Int;
}

typedef Velocity = {
	final x:Float;
	final y:Float;
}