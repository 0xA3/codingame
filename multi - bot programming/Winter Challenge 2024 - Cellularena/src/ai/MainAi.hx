package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import ai.contexts.Type;
import ai.data.Cell;
import ai.data.TCell;
import ai.data.TDir;
import haxe.Timer;
import xa3.math.Pos;

using StringTools;

class MainAi {

	static inline var ME = 1;
	static inline var OPP = 0;
	static inline var NO_OWNER = -1;

	static function main() {
		js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		
		final ai = new ai.versions.Ai7();
		
		final inputs = readline().split(' ');
		final width = parseInt( inputs[0] );
		final height = parseInt( inputs[1] );
		final positions = [for( y in 0...height ) [for( x in 0...width ) new Pos( x, y )]];
		var prevCells:Map<Pos, Cell> = [for( y in 0...height ) for( x in 0...width ) positions[y][x] => Cell.createEmptyCell( positions[y][x] )];
		var cells:Map<Pos, Cell> = [for( y in 0...height ) for( x in 0...width ) positions[y][x] => Cell.createEmptyCell( positions[y][x] )];
		initNeighbors( positions, cells, width, height );
		// printErr( 'width: $width' );
		// printErr( 'height: $height' );
		ai.setGlobalInputs( positions, cells, width, height );
		
		final myCells:Array<Cell> = [];
		final myRootIds:Array<Int> = [];
		final oppMoves = [];
		final myMoves = [];
		final harvestedProteins:Map<Pos, Bool> = [];
		// final neitherEntities = [];
	
		// game loop
		while( true ) {
			final startTime = Timer.stamp();

			for( cell in cells ) {
				final prevCell = prevCells[cell.pos];
				prevCell.type = cell.type;
				prevCell.owner = cell.owner;
				prevCell.organId = cell.organId;
				prevCell.organDir = cell.organDir;
				prevCell.organParentId = cell.organParentId;
				prevCell.organRootId = cell.organRootId;

				cell.reset();
			}
			myCells.splice( 0, myCells.length );
			myRootIds.splice( 0, myRootIds.length );
			oppMoves.splice( 0, oppMoves.length );
			myMoves.splice( 0, myMoves.length );
			harvestedProteins.clear();

			final entityCount = parseInt( readline() );
			// printErr( 'entityCount: $entityCount' );
			for ( i in 0...entityCount ) {
				final inputs = readline().split(' ');
				// printErr( 'Entity: ${inputs.join(" ")}' );
				final x = parseInt( inputs[0] );
				final y = parseInt( inputs[1] ); // grid coordinate
				final type = switch inputs[2] {
					case "WALL": TCell.Wall;
					case "ROOT": TCell.Root;
					case "BASIC": TCell.Basic;
					case "TENTACLE": TCell.Tentacle;
					case "HARVESTER": TCell.Harvester;
					case "SPORER": TCell.Sporer;
					case "A": TCell.A;
					case "B": TCell.B;
					case "C": TCell.C;
					case "D": TCell.D;
					default: throw 'Error: unknown type: ${inputs[2]}';
				} // WALL, ROOT, BASIC, TENTACLE, HARVESTER, SPORER, A, B, C, D
				final owner = parseInt( inputs[3] ); // 1 if your organ, 0 if enemy organ, -1 if neither
				final organId = parseInt( inputs[4] ); // id of this entity if it's an organ, 0 otherwise
				final organDir = switch inputs[5] {
					case "N": TDir.N;
					case "E": TDir.E;
					case "S": TDir.S;
					case "W": TDir.W;
					case "X": TDir.X;
					default: throw 'Error: unknown direction: ${inputs[5]}';
				} // N,E,S,W or X if not an organ
				final organParentId = parseInt( inputs[6] );
				final organRootId = parseInt( inputs[7] );

				final pos = positions[y][x];
				final cell = cells[pos];
				
				cell.type = type;
				cell.owner = owner;
				cell.organId = organId;
				cell.organDir = organDir;
				cell.organParentId = organParentId;
				cell.organRootId = organRootId;

				if( owner == OPP && !cell.compareTo( prevCells[pos] )) oppMoves.push( cell );
				if( owner == ME && !cell.compareTo( prevCells[pos] )) myMoves.push( cell );

				if( cell.type == Wall ) isolate( cell );

				if( owner == ME ) {
					myCells.push( cell );
					if( cell.type == TCell.Root ) {
						// printErr( 'my root id: ${cell.organId}' );
						myRootIds.push( cell.organId );
					}
					if( cell.type == TCell.Harvester ) {
						final proteinPos = getNeighborPosition( positions, cell.pos, cell.organDir );
						harvestedProteins.set( proteinPos, true );
					}
				}
				// else if( owner == 0 ) oppCells.push( cell );
			}
			final inputs = readline().split(' ');
			// printErr( 'my inputs: ${inputs.join(" ")}' );
			final myA = parseInt( inputs[0] );
			final myB = parseInt( inputs[1] );
			final myC = parseInt( inputs[2] );
			final myD = parseInt( inputs[3] ); // your protein stock
			final inputs = readline().split(' ');
			// printErr( 'opp inputs: ${inputs.join(" ")}' );
			final oppA = parseInt( inputs[0] );
			final oppB = parseInt( inputs[1] );
			final oppC = parseInt( inputs[2] );
			final oppD = parseInt( inputs[3] ); // opponent's protein stock
			final requiredActionsCount = parseInt( readline() ); // your number of organisms, output an action for each one in any order
			// printErr( 'requiredActionsCount: $requiredActionsCount' );
			// final oppCellPositions = oppCells.map( cell -> cell.pos );
			// printErr( 'oppCellPositions: ${oppCellPositions.join(" ")}' );

			for( oppCell in oppMoves ) printErr( 'opp changed cell ${oppCell.pos} to ${Type.toString( oppCell.type )}' );
			for( myCell in myMoves ) printErr( 'my changed cell ${myCell.pos} to ${Type.toString( myCell.type )}' );

			ai.setInputs( myA, myB, myC, myD, requiredActionsCount, myRootIds, myCells, harvestedProteins, myMoves, oppMoves );

			final outputs = ai.process();
			// printErr( outputs );
			printErr( '${int(( Timer.stamp() - startTime ) * 1000)} ms' );
			print( outputs );
		}
	}

	static function initNeighbors( positions:Array<Array<Pos>>, cells:Map<Pos, Cell>, width:Int, height:Int ) {
		for( cell in cells ) {
			final pos = cell.pos;

			final x1 = pos.x - 1;
			final y1 = pos.y;
			final x2 = pos.x + 1;
			final y2 = pos.y;
			final x3 = pos.x;
			final y3 = pos.y - 1;
			final x4 = pos.x;
			final y4 = pos.y + 1;

			if( x1 >= 0 ) cell.neighbors.push( cells[positions[y1][x1]] );
			if( x2 < width ) cell.neighbors.push( cells[positions[y2][x2]] );
			if( y3 >= 0 ) cell.neighbors.push( cells[positions[y3][x3]] );
			if( y4 < height ) cell.neighbors.push( cells[positions[y4][x4]] );
		}
	}

	static function isolate( cell:Cell ) {
		for( neighborCell in cell.neighbors ) {
			neighborCell.removeNeighbor( cell );
		}
		cell.neighbors.splice( 0, cell.neighbors.length );
	}

	static function getNeighborPosition( positions:Array<Array<Pos>>, pos:Pos, direction:TDir ) {
		switch direction {
			case TDir.N: return positions[pos.y - 1][pos.x];
			case TDir.W: return positions[pos.y][pos.x - 1];
			case TDir.S: return positions[pos.y + 1][pos.x];
			case TDir.E: return positions[pos.y][pos.x + 1];
			case TDir.X: throw 'ERROR: invalid direction $direction';
		}
	}
}