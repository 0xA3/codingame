package ai.versions;

import CodinGame.printErr;
import ai.data.Board.EMPTY;
import ai.data.Board.POWER_SOURCE;
import ai.data.Board;
import ai.data.PathNode;
import ai.data.SnakePath;
import ai.data.Snakebot;
import ai.data.TDirection;
import xa3.math.Pos;
import ya.Set;

class Ai20 {

	final outputs:Array<String> = [];
	
	var board:Board;
	var allSnakebots:Map<Int, ai.data.Snakebot> = [];
	var marginX:Int;
	var marginY:Int;
	
	var mySnakebots:Array<Snakebot> = [];
	var oppSnakebots:Array<Snakebot> = [];

	var turn = 1;
	var currentSnakebot = Snakebot.NO_SNAKEBOT;

	var isLog = false;

	final visited:Array<Array<Bool>> = [];
	final targetCells:Array<Array<Bool>> = [];

	final unassignedSnakebots:Map<Snakebot, Bool> = [];

	public function new() { }

	public function setGlobalInputs( board:Board, allSnakebots:Map<Int, Snakebot>, marginX:Int, marginY:Int ) {
		this.board = board;
		this.allSnakebots = allSnakebots;
		this.marginX = marginX;
		this.marginY = marginY;

		for( y in 0...board.marginBoardHeight ) visited.push( [for( x in 0...board.marginBoardWidth ) false] );
		for( y in 0...board.marginBoardHeight ) targetCells.push( [for( x in 0...board.marginBoardWidth ) false] );
	}

	public function setInputs( mySnakebotIds:Set<Int>, oppSnakebotIds:Set<Int> ) {
		mySnakebots  = [for( id in mySnakebotIds.toArray() ) allSnakebots[id]];
		oppSnakebots = [for( id in oppSnakebotIds.toArray() ) allSnakebots[id]];
		// printErr( mySnakebotIds.toArray().join( "," ) );

		mySnakebots.sort(( a, b ) -> b.bodyPositions.length - a.bodyPositions.length );
		for( snakebot in mySnakebots ) unassignedSnakebots.set( snakebot, true );

		for( snakebot in mySnakebots ) snakebot.isFalling = checkSnakebotFalling( snakebot );
		for( snakebot in oppSnakebots ) snakebot.isFalling = checkSnakebotFalling( snakebot );

		outputs.splice( 0, outputs.length );
		for( y in 0...board.marginBoardHeight ) for( x in 0...board.marginBoardWidth ) targetCells[y][x] = false;
	}

	function checkSnakebotFalling( snakebot:Snakebot ) {
		for( i in 0...snakebot.bodyPositions.length - 1 ) { // check bodyPositions except tail
			final groundDistance = getGroundDistance( snakebot, snakebot.bodyPositions[i], 0, 0, snakebot.bodyPositions.length );
			// printErr( 'snakebot ${snakebot.id} pos ${outputPos( snakebot.bodyPositions[i] )} groundDistance $groundDistance' );
			if( groundDistance == 0 ) return false;
		}
		// printErr( 'snakebot ${snakebot.id} is falling' );
		
		return true;
	}

	public function process() {
		printErr( 'turn: $turn' );
		// printErr( board.outputBoard());
		
		// isLog = true;
		// isLog = turn == 1;
		// isLog = currentSnakebot.id == 5;
		// isLog = turn == 14 && currentSnakebot.id == 2;
		
		final outputs = [];
		
		final maxPaths = mySnakebots.length;

		//************************************
		//Step 1 find paths for each snakebot
		//************************************
		final snakePaths = [];
		for( snakebot in mySnakebots ) {
			currentSnakebot = snakebot;
			// isLog = currentSnakebot.id == 1 && turn >= 21;
			// isLog = currentSnakebot.id == 5;

			final paths = getPaths( maxPaths, snakebot, snakebot.bodyPositions.length );
			
			// if( isLog ) printErr( 'Id ${snakebot.id} head ${outputPos( snakebot.bodyPositions[0] )} paths: ${paths.length}' );
			for( path in paths ) {
				final targetPos = path.length > 0 ? path[path.length - 1] : Pos.NO_POS;
				final snakePath = new SnakePath( snakebot, path.length, targetPos, path );
				// if( isLog ) printErr( 'Path for snakebot ${snakebot.id} ' + [for( pos in path ) '${outputPos( pos )}' ].join( "," ) );
				snakePaths.push( snakePath );
			}
		}

		//************************************
		// Step 2 assign targets to snakebots
		//************************************
		snakePaths.sort(( a, b ) -> a.distance - b.distance );

		final snakeSet = new Set<Int>();
		final targetSet = new Set<Pos>();
		
		final assignedSnakebots = [];
		for( snakePath in snakePaths ) {
			currentSnakebot = snakePath.snakebot;
			final snakebotId = currentSnakebot.id;
			// isLog = true;
			// isLog = currentSnakebot.id == 0;
			// if( isLog ) printErr( 'Id ${snakebotId} path: ' + [for( pos in snakePath.path ) '${outputPos( pos )}' ].join( "," ) );

			// if( isLog ) printErr( 'snakePath snakeId ${snakePath.snakeId} distance ${snakePath.distance} targetPos ${outputPos( snakePath.targetPos )}' );
			if( snakeSet.contains( snakebotId )) continue;
			if( targetSet.contains( snakePath.targetPos )) continue;
			
			snakeSet.add( snakebotId );
			targetSet.add( snakePath.targetPos );
			
			assignedSnakebots.push( snakePath );
			unassignedSnakebots.remove( currentSnakebot );

			// if( isLog ) printErr( 'Id ${snakebotId} path: ' + [for( pos in snakePath.path ) '${outputPos( pos )}' ].join( "," ) );
		}

		for( snakebot in unassignedSnakebots.keys() ) assignedSnakebots.push( new SnakePath( snakebot, 0, Pos.NO_POS, [] ) );
		unassignedSnakebots.clear();
		
		assignedSnakebots.sort(( a, b ) -> b.path.length - a.path.length );

		//*******************************************************
		// Step 3 calculate next best position for each snakebot
		//*******************************************************
		for( snakePath in assignedSnakebots ) {
			final snakebot = snakePath.snakebot;
			currentSnakebot = snakebot;
			// isLog = true;
			// isLog = currentSnakebot.id == 0;
			
			// if( isLog ) printErr( 'Id ${snakebot.id} path: ' + [for( pos in snakePath.path ) '${outputPos( pos )}' ].join( "," ) );
			
			final path = snakePath.path;
			final preferredNextPosition = path.length > 0 ? path[0] : board.center;
			final headPos = snakebot.bodyPositions[0];
			final nextPosition = getNextPosition( headPos, preferredNextPosition );

			// if( isLog ) printErr( 'snakebot ${snakebot.id} head ${outputPos( headPos )} preferredNextPosition ${outputPos( preferredNextPosition )} nextPosition ${outputPos( nextPosition )}' );
			
			if( nextPosition != Pos.NO_POS ) {
				targetCells[nextPosition.y][nextPosition.x] = true;
				if( nextPosition.y > headPos.y ) snakebot.changeDirection( TDirection.Down );
				else if( nextPosition.x < headPos.x ) snakebot.changeDirection( TDirection.Left );
				else if( nextPosition.y < headPos.y ) snakebot.changeDirection( TDirection.Up );
				else if( nextPosition.x > headPos.x ) snakebot.changeDirection( TDirection.Right );
			}

			outputs.push( '${snakebot.id} ${snakebot.direction}' );
			// printErr( 'snakebot ${snakebot.id} ${snakebot.direction}' );
		}

		turn++;
		
		// return "";
		
		return outputs.join( ";" );
	}

	function getPaths( maxPaths:Int, snakebot:Snakebot, length:Int ) {
		for( y in 0...board.marginBoardHeight ) for( x in 0...board.marginBoardWidth ) visited[y][x] = false;
		final pathToTail = [];
		// for( targetCell in targetCells.keys()) visitedMap.set( targetCell, true );

		final tailPos = snakebot.bodyPositions[snakebot.bodyPositions.length - 1];

		// if( isLog ) printErr( 'getPaths snakebot ${snakebot.id} maxPaths $maxPaths headPos ${outputPos( snakebot.bodyPositions[0] )} tailPos ${outputPos( tailPos )} length $length' );

		final frontier = new List<PathNode>();
		final headNode = new PathNode( snakebot.bodyPositions[0], currentSnakebot.bodyPositions.copy(), PathNode.NO_NODE, 0, currentSnakebot.outsideCount );
		frontier.add( headNode );
		visited[headNode.posIn.y][headNode.posIn.x] = true;
		
		var steps = 0;

		final paths = [];
		while( !frontier.isEmpty() ) {
			steps++;
			final current = frontier.pop();
			if( current.depth > board.boardWidth + 1 ) break;
			
			// if( isLog ) printErr( 'current ${outputPos( current.posIn )} depth ${current.depth}' );
			// if( isLog ) printErr( board.previewNextBoard( current.bodyPositions));
			
			final headCell = board.currentBoard[current.posIn.y][current.posIn.x];
			if( headCell == Board.POWER_SOURCE ) {
				// if( isLog ) printErr( 'id ${currentSnakebot.id} found path to powerSource ${outputPos( current.posIn )} in ${steps} steps' );
				final path = backtrack( current, [] );
				paths.push( path ); // add backtrack positions to empty array
				if( path.length >= maxPaths ) break;
			}
			final posInBeforeGravity = current.posIn;
			
			final gravitatedBodyPositions = applyGravity( current.bodyPositions, current.depth + 1 );
			current.bodyPositions = gravitatedBodyPositions;

			final posAfterGravity = current.bodyPositions[0];
			if( posAfterGravity != posInBeforeGravity ) {
				visited[posInBeforeGravity.y][posInBeforeGravity.x] = false;
				visited[posAfterGravity.y][posAfterGravity.x] = true;
				// if( isLog ) printErr( 'change isVisited ${outputPos( posInBeforeGravity )} to false and ${outputPos( posAfterGravity )} to true' );
			}

			final currentHead = current.bodyPositions[0];
			if( currentHead == tailPos ) {
				// if( isLog ) printErr( 'id ${currentSnakebot.id} found tail at ${outputPos( currentHead )} in $steps steps' );
				backtrack( current, pathToTail ); // add positions to pathToTail
			}

			final neighbors = getNeighbors( currentHead, current.depth + 1, tailPos );

			// if( isLog ) printErr( 'current ${outputPos( current.posOut )} neighbors ' + [for( neighbor in neighbors ) '${outputPos( neighbor )}' ].join( "," ) );
			
			for( neighbor in neighbors ) {
				final movedBodyPositions = moveBody( neighbor, current.bodyPositions, current.depth + 1 );
				if( visited[neighbor.y][neighbor.x] ) {
					// if( isLog ) printErr( 'visited $neighbor exists' );
					continue;
				}
				
				// if( isLog ) printErr( 'neighbor ${outputPos( neighbor )}' );
				// if( isLog ) printErr( board.previewNextBoard( movedBodyPositions));

				final isOutside = board.checkOutsideBoard( neighbor.x, neighbor.y );
				final outsideCount = isOutside ? current.outsideCount + 1 : 0;
				if( outsideCount > length - 1 ) continue;

				final nextNode = new PathNode( neighbor, movedBodyPositions, current, current.depth + 1, outsideCount );
				// if( isLog ) printErr( 'add' );

				visited[neighbor.y][neighbor.x] = true;
				frontier.add( nextNode );
			}
		}
		
		if( paths.length > 0 ) return paths;

		printErr( 'id ${currentSnakebot.id} path to power source not found' );
		if( pathToTail.length == 0 ) printErr( 'id ${currentSnakebot.id} pathToTail not found' );
		else {
			printErr( 'id ${currentSnakebot.id} chasing tail' );
			return [pathToTail];
		}

		printErr( 'id ${currentSnakebot.id} go to any free neighbor' );
		return [getNeighbors( snakebot.bodyPositions[0], 0, tailPos )];
	}
	
	function getNeighbors( pos:Pos, depth:Int, tailPos:Pos ) {
		final neighbors = [];
		
		for( neighborOffset in board.neighborOffsets ) {
			final nextX = pos.x + neighborOffset.x;
			final nextY = pos.y + neighborOffset.y;
			// if( board.checkOutsideMarginBoard( nextX, nextY ) ) continue;
			if( board.checkOutsideBoard( nextX, nextY ) ) continue;

			final neighborPosition = board.positions[nextY][nextX];
			final cell = board.getCell( neighborPosition, depth );

			if( neighborPosition == tailPos || cell == EMPTY || cell == POWER_SOURCE ) neighbors.push( neighborPosition );
		}

		return neighbors;
	}

	function moveBody( neighbor:Pos, bodyPositions:Array<Pos>, depth:Int ) {
		final bodyAfterMove = [neighbor];
		for( i in 0...bodyPositions.length - 1 ) bodyAfterMove.push( bodyPositions[i] );
		// printErr( 'body after move ' + [for( pos in bodyAfterMove ) '${outputPos( pos )}' ].join( "," ) );

		return bodyAfterMove;
	}

	function applyGravity( bodyPositions:Array<Pos>, depth:Int ) {
		var minGroundHeight = -1;
		for( i in 1...board.boardHeight ) {
			for( bodyPosition in bodyPositions ) {
				if( bodyPosition.y + i >= board.marginBoardHeight ) break;
				
				final testPos = board.positions[bodyPosition.y + i][bodyPosition.x];
				final testCell = board.getCell( testPos, depth );
				if( !currentSnakebot.bodyPositionsMap.exists( testPos ) && testCell != EMPTY ) {
					minGroundHeight = i - 1;
					break;
				}
			}
			if( minGroundHeight != -1 ) break;
		}

		// printErr( 'neighbor ${getDirection( bodyPositions[0], neighbor )} ${outputPos( neighbor )} minGroundHeight $minGroundHeight' );
		final bodyAfterGravity = [];
		for( pos in bodyPositions ) {
			final nextY = pos.y + minGroundHeight;
			final clippedNextY = nextY > 0 && nextY < board.marginBoardHeight ? nextY : board.marginBoardHeight - 1;
			bodyAfterGravity.push( board.positions[clippedNextY][pos.x] );
		}

		return bodyAfterGravity;
	}

	function getDirection( pos1:Pos, pos2:Pos ) {
		return pos2.x < pos1.x
			? TDirection.Left
			: pos2.x > pos1.x
				? TDirection.Right
				: pos2.y < pos1.y
					? TDirection.Up
					: TDirection.Down;
	}

	function getNextPosition( pos:Pos, preferredNextPos:Pos ) {
		if( preferredNextPos != board.center && !targetCells[preferredNextPos.y][preferredNextPos.x] ) return preferredNextPos;
		
		final neighbors = [];
		for( neighborOffset in board.neighborOffsets ) {
			final nextX = pos.x + neighborOffset.x;
			final nextY = pos.y + neighborOffset.y;

			final neighborPosition = board.positions[nextY][nextX];
			final cell = board.getCell( neighborPosition, 0 );

			if( targetCells[neighborPosition.y][neighborPosition.x] ) continue;
			if( cell == EMPTY || cell == POWER_SOURCE ) neighbors.push( neighborPosition );
		}

		if( neighbors.length == 0 ) return Pos.NO_POS;
		neighbors.sort(( a, b ) -> {
			final distanceA = board.getDistance( a, preferredNextPos );
			final distanceB = board.getDistance( b, preferredNextPos );
			return distanceA - distanceB;
		});

		return neighbors[0];
	}

	inline function getGroundDistance( snakebot:Snakebot, pos:Pos, currentDepth:Int, currentGroundDistance:Int, length:Int ) {
		var groundDistance = board.boardHeight;
		
		for( i in 0...length ) {
			final yBelow = pos.y + i + 1;
			if( yBelow >= board.marginBoardHeight ) break;
			final positionBelow = board.positions[yBelow][pos.x];

			if( snakebot.bodyPositionsMap.exists( positionBelow )) {
				continue;
			}
			
			final cellBelow = board.getCell( positionBelow, currentDepth );
			if( cellBelow != Board.EMPTY) {
				groundDistance = i;
				// if( outputPos ( current.pos ) == "2:5" ) printErr( '2:5 positionBelow ${outputPos( positionBelow )} cellBelow $cellBelow groundDistance $groundDistance' );
				break;
			}
		}
		// if( outputPos( current.pos ) == "2:5" ) printErr( '2:5 groundDistance $groundDistance current+1 ${current.groundDistance + 1}' );
		
		return min( groundDistance, currentGroundDistance + 1 );
	}

	function backtrack( node:PathNode, aPath:Array<Pos> ) {
		final path = new List<Pos>();
		var tempNode = node;
		while( tempNode.previous != PathNode.NO_NODE ) {
			path.add( tempNode.posIn );
			board.previewNextBoard( tempNode.bodyPositions );
			tempNode = tempNode.previous;
		}
		
		for( pos in path ) aPath.push( pos );
		aPath.reverse();
		return aPath;
	}

	inline function max( a:Int, b:Int ) return a > b ? a : b;
	inline function min( a:Int, b:Int ) return a < b ? a : b;

	public inline function outputPos( pos:Pos ) return '${pos.x - marginX}:${pos.y - marginY}';
}
