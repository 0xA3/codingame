import haxe.exceptions.PosException;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Math.abs;

using Lambda;

function main() {

	final numberSnails = parseInt( readline());
	final snailSpeeds = [for( i in 0...numberSnails ) parseInt( readline())];
	final mapHeight = parseInt( readline());
	final mapWidth = parseInt( readline());
	final grid = [for( _ in 0...mapHeight ) readline().split( "" )];

	final result = process( numberSnails, snailSpeeds, mapWidth, mapHeight, grid );
	print( result );
}

function process( numberSnails:Int, snailSpeeds:Array<Int>, mapWidth:Int, mapHeight:Int, grid:Array<Array<String>> ) {
	final parseResult = parseGrid( numberSnails, grid );
	var snails = parseResult.snails;
	final destinations = parseResult.destinations;

	final snailDestinations = getSnailDestinations( snails, destinations );
	// outputMap( 0, snails, destinations, mapWidth, mapHeight );

	final winner = run( snails, snailSpeeds, snailDestinations, mapWidth, mapHeight );

	return winner;
}

function parseGrid( numberSnails:Int, grid:Array<Array<String>> ) {
	final snails:Array<Position> = [];
	final destinations:Array<Position> = [];
	for( y in 0...grid.length ) {
		for( x in 0...grid[y].length ) {
			if( grid[y][x] == "#" ) destinations.push( { x: x, y: y } );
			else if( grid[y][x] != "*" ) {
				final index = parseInt( grid[y][x] ) - 1;
				if( index > numberSnails ) throw 'Error in grid snail ${index + 1} found with numberSnails $numberSnails';
				snails[index] = { x: x, y: y }
			}
		}
	}
	return { snails: snails, destinations: destinations }
}

function getSnailDestinations( snails:Array<Position>, destinations:Array<Position> ) {
	final snailDestinations:Array<Position> = [];
	for( i in 0...snails.length ) {
		var closestDistance = 9999.0;
		var closestDestination = destinations[0];
		for( destination in destinations ) {
			final distance = getDistance( snails[i], destination );
			if( distance < closestDistance ) {
				closestDistance = distance;
				closestDestination = destination;
			}
		}
		snailDestinations[i] = closestDestination;
	}

	return snailDestinations;
}

function run( snails:Array<Position>, snailSpeeds:Array<Int>, snailDestinations:Array<Position>, mapWidth:Int, mapHeight:Int ) {

	var step = 0;
	var tempSnails = snails;
	while( step++ < 10 ) {
		tempSnails = tempSnails.mapi( ( i, snail ) -> moveSnail( snail, snailSpeeds[i], snailDestinations[i] ));
		// outputMap( step, tempSnails, snailDestinations, mapWidth, mapHeight );
		for( i in 0...snails.length ) {
			final snail = tempSnails[i];
			final destination = snailDestinations[i];
			if( snail.x == destination.x && snail.y == destination.y ) return i + 1;
		}
	}

	return 0;
}

function moveSnail( snail:Position, speed:Int, destination:Position ) {
	if( getDistance( snail, destination ) < speed ) return destination;

	var tempPosition = snail;
	for( _ in 0...speed ) {
		final dx = destination.x - tempPosition.x;
		final dy = destination.y - tempPosition.y;
		if( abs( dx ) > abs( dy )) {
			final nextX = dx > 0 ? tempPosition.x + 1 : tempPosition.x - 1;
			tempPosition = { x: nextX, y: tempPosition.y }
		} else {
			final nextY = dy > 0 ? tempPosition.y + 1 : tempPosition.y - 1;
			tempPosition = { x: tempPosition.x, y: nextY }
		}
	}

	return tempPosition;
}

function getDistance( pos1:Position, pos2:Position ) return abs( pos1.x - pos2.x ) + abs( pos1.y - pos2.y );

function outputMap( step:Int, snails:Array<Position>, destinations:Array<Position>, mapWidth:Int, mapHeight:Int ) {
	final grid = [for( _ in 0...mapHeight ) [for( _ in 0...mapWidth ) "."]];
	for( destination in destinations ) grid[destination.y][destination.x] = "#";
	for( i in 0...snails.length ) grid[snails[i].y][snails[i].x] = '${i + 1}';

	final output = grid.map( line -> line.join( "" )).join( "\n" );
	printErr( '___${step}___\n$output' );
}


typedef Position = {
	final x:Int;
	final y:Int;
}
