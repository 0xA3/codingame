package ai;

import CodinGame.print;
import CodinGame.printErr;
import Std.int;
import Std.parseInt;
import ai.contexts.CellType;
import ai.data.Cell;
import ai.data.TCell;
import ai.data.TDir;
import haxe.Timer;
import js.Node.process;
import xa3.math.Pos;

using StringTools;
using tink.CoreApi;

// below is a mechanism that connects nodejs standard input with something that resembles the readline()
@await class MainAiLocal {
	
	static var inputLines:Array<String> = [];
	static var promises:Array<(String)->Void> = [];
	static var buffer:String = "";

	static function main() {
		process.stdin.setEncoding("utf8");
		process.stdin.on( "data", ( data:String ) -> {
			buffer += data;
			var lines:Array<String> = buffer.split( "\n" );
			if( lines.length > 1 ) {
				for( i in 0...lines.length - 1 ) inputLines.push( lines[i].trim() );
				buffer = lines[lines.length - 1];
				onReadline();
			}
		});

		// Start the async function
		asyncMain();
	}

	static function onReadline() {
		while( true ) {
			if( promises.length == 0 ) break;
			if( inputLines.length == 0 ) break;
			var prom = promises.shift();
			var str = inputLines.shift();
			
			prom( str );
		}
	}

	static function readline() {
		// trace( "readline" );
		var resolve:(String)->Void;

		final initFunc = function( r:(String)->Void ):Void {
			resolve = r;
			// trace( 'initFunc resolve: ${resolve}' );
			promises.push( resolve );
			onReadline();
		}

		// var prom:js.lib.Promise<String> = new js.lib.Promise( initFunc );
		final prom = Future.irreversible( initFunc );
		
		return prom;
	}
	
	static inline var ME = 1;
	static inline var OPP = 0;
	static inline var NO_OWNER = -1;

	@await static function asyncMain() {
		// actual code, but must use (@await readline()) instead of readline() - for example
		// trace( "asyncMain" );
		js.Syntax.code("// Build date {0}", CompileTime.buildDateString() );
		
		final ai = new ai.versions.Ai9();

		final inputsAwait = @await readline();
		final inputs = inputsAwait.split(' ');
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

			final entityCount = parseInt( @await readline() );
			// printErr( 'entityCount: $entityCount' );
			for ( i in 0...entityCount ) {
				final inputsAwait = @await readline();
				final inputs = inputsAwait.split(' ');
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
					default: throw new Error( 'Error: unknown type: ${inputs[2]}' );
				} // WALL, ROOT, BASIC, TENTACLE, HARVESTER, SPORER, A, B, C, D
				final owner = parseInt( inputs[3] ); // 1 if your organ, 0 if enemy organ, -1 if neither
				final organId = parseInt( inputs[4] ); // id of this entity if it's an organ, 0 otherwise
				final organDir = switch inputs[5] {
					case "N": TDir.N;
					case "E": TDir.E;
					case "S": TDir.S;
					case "W": TDir.W;
					case "X": TDir.X;
					default: throw new Error( 'Error: unknown direction: ${inputs[5]}' );
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
			final inputsAwait = @await readline();
			final inputs = inputsAwait.split(' ');
			// printErr( 'my inputs: ${inputs.join(" ")}' );
			final myA = parseInt( inputs[0] );
			final myB = parseInt( inputs[1] );
			final myC = parseInt( inputs[2] );
			final myD = parseInt( inputs[3] ); // your protein stock
			final inputsAwait = @await readline();
			final inputs = inputsAwait.split(' ');
			// printErr( 'opp inputs: ${inputs.join(" ")}' );
			final oppA = parseInt( inputs[0] );
			final oppB = parseInt( inputs[1] );
			final oppC = parseInt( inputs[2] );
			final oppD = parseInt( inputs[3] ); // opponent's protein stock
			final requiredActionsCount = parseInt( @await readline() ); // your number of organisms, output an action for each one in any order
			// printErr( 'requiredActionsCount: $requiredActionsCount' );
			// final oppCellPositions = oppCells.map( cell -> cell.pos );
			// printErr( 'oppCellPositions: ${oppCellPositions.join(" ")}' );

			for( oppCell in oppMoves ) printErr( 'opp changed cell ${oppCell.pos} to ${CellType.toString( oppCell.type )}' );
			for( myCell in myMoves ) printErr( 'my changed cell ${myCell.pos} to ${CellType.toString( myCell.type )}' );

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
