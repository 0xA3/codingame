package ai;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import ai.data.Cell;
import ai.data.Pos;
import ai.data.TCell;
import ai.data.TDir;

using StringTools;

class MainAi {
	static function main() {
		js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		final ai = new ai.versions.Ai2();
		final inputs = readline().split(' ');
		final width = parseInt( inputs[0] );
		final height = parseInt( inputs[1] );
		final positions = [for( y in 0...height ) [for( x in 0...width ) new Pos( x, y )]];
		final cells:Map<Pos, Cell> = [for( y in 0...height ) for( x in 0...width ) positions[y][x] => Cell.createEmptyCell( positions[y][x] )];
		initNeighbors( positions, cells, width, height );
		// printErr( 'width: $width' );
		// printErr( 'height: $height' );
		ai.setGlobalInputs( positions, cells, width, height );
		
		final myEntities:Map<Int, Cell> = [];
		final oppEntities = [];
		// final neitherEntities = [];
	
		// game loop
		while( true ) {
			myEntities.clear();
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

				if( cell.type == Wall ) isolate( cell );

				if( owner == 1 ) myEntities.set( organId, cell );
				else if( owner == 0 ) oppEntities.push( cell );
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
			
			ai.setInputs( requiredActionsCount, myEntities, oppEntities, myA, myB, myC, myD );

			final outputs = ai.process();
			// printErr( outputs );
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

}