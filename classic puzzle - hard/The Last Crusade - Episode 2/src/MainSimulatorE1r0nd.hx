import MainE1r0nd.dirs;
import MainE1r0nd.turns;
import MainE1r0nd;
import Math.abs;
import Std.int;
import Std.parseInt;
import Std.string;
import Sys.println;
import data.Tiles;
import haxe.Timer;

using Lambda;
using StringTools;


typedef InputPos = {
	var x:Int;
	var y:Int;
	var dir:String;
	var start:Int;
}

// Local simulator
function main() {
	
	// final levelContent = CompileTime.readFile( "./dest/levels/avoiding_rocks.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/broken_mausoleum.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/broken_secret_passages.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/broken_sewer.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/broken_well.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/double_turn.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/multiple_choice_and_rocks.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/only_one_way_validator.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/only_one_way.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/rock_interception.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/rocks_1.txt" );
	final levelContent = CompileTime.readFile( "./dest/levels/rocks_2.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/rocks_2_test.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/simple.txt" );
	// final levelContent = CompileTime.readFile( "./dest/levels/underground_complex.txt" );
	
	final input = levelContent;
	final inputLines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
	var inputs = inputLines[0].split(' ');
	final w = parseInt( inputs[0] ); // number of columns.
	final h = parseInt( inputs[1] ); // number of rows.
	final map = [for( i in 0...h ) inputLines[i + 1].split(" ").map( a -> {
		final v = parseInt( a );
		if( v == null ) throw "Error map value is null";
		final v2:Int = v;
		v2;
	})]; // represents a line in the grid and contains W integers. Each integer represents one room of a given type.
	final exit = parseInt( inputLines[1 + h] ); // the coordinate along the X axis of the exit (not useful for this first mission, but must be read).

	final indyInput = getInputPos( inputLines[1 + h + 1] );
	var indy:Pos = { x: indyInput.x, y: indyInput.y, dir: indyInput.dir };

	final rocksNo = parseInt( inputLines[1 + h + 2] );
	final rocksStart = 1 + h + 3;
	final rocks = [for( i in rocksStart...rocksStart + rocksNo ) getInputPos( inputLines[i] )];

	final clientMap = map.map( line -> line.copy());
	var rollingRocks:Array<Pos> = [];
	
	for( i in 0...100 ) {
		for( rockLocation in rocks ) {
			if( rockLocation.start == i ) rollingRocks.push({ x: rockLocation.x, y: rockLocation.y, dir: rockLocation.dir });
		}

		println( cellsToString3x3( map, w, indy, rollingRocks ));
	
		final startTime = Timer.stamp();
		final action = MainE1r0nd.process( indy, rollingRocks, exit, clientMap );
		println( action );
		// println( 'time ${Timer.stamp() - startTime}' );
		
		if( action != "WAIT" ) {
			final actionPosition = getPosOfAction( action );
			if( actionPosition.x == indy.x && actionPosition.y == indy.y ) {
				println( 'Invalid instruction: you cannot rotate cell ($action) as Indy is currently in it' );
				break;
			}
			for( rock in rollingRocks ) {
				if( actionPosition.x == rock.x && actionPosition.y == rock.y ) {
					println( 'Invalid instruction: you cannot rotate cell ($action) as a rock is currently in it' );
					break;
				}
			}
			map[actionPosition.y][actionPosition.x] = turns[ string( map[actionPosition.y][actionPosition.x] ) + actionPosition.dir.charAt(0)];
		}
		
		final nextPos = getNextPos( indy, map );
		
		for( rock in rollingRocks ) {
			if( indy.x == rock.x && indy.y == rock.y ) {
				println( "Indy was crashed by a rock and died" );
				return;
			}
		}
		if( indy.x == exit && indy.y == map.length - 1 ) {
			println( "Indy reached the exit" );
			// println( tunnel.cellsToString3x3( cells, indy, rollingRocks ));
			break;
		}
		if( nextPos == null ) {
			println( 'Indy crashed' );
			// println( tunnel.cellsToString3x3( cells, indy, rollingRocks ));
			break;
		}
		indy = nextPos;

		rollingRocks = rollingRocks.map( rock -> getNextPos( rock, map )).filter( rock -> rock != null );
		// for( i in 0...rollingRocks.length ) trace( 'rock $i ${rollingRocks[i].x}:${rollingRocks[i].y}' );

		final char = Sys.getChar( false );
		if( char == 27 || char == 3 ) break;

	}

}

function getInputPos( s:String ) {
	final line = s.split(" ");
	final pos:InputPos = { x: parseInt( line[0] ), y: parseInt( line[1] ), dir: line[2].charAt( 0 ), start: line.length > 3 ? parseInt( line[3] ) : 0 };
	return pos;
}

function getPosOfAction( action:String ) {
	final parts = action.split(" ");
	final p:Pos = { x: parseInt( parts[0] ), y: parseInt( parts[1] ), dir: parts[2].charAt( 0 ) };
	return p;
}

function getNextPos( pos:Pos, map:Array<Array<Int>> ) {
	final tile = int( abs( map[pos.y][pos.x] ));
	final nextDir = dirs['$tile${pos.dir}'];
	
	if( nextDir == null ) return null; //throw 'Error: dirs[$dir${pos.dir}] is null';
	final nextPos:Pos = {
		x: pos.x + nextDir.x,
		y: pos.y + nextDir.y,
		dir: nextDir.dir
	}
	if( nextPos.y >= map.length ) return null;
	final nextTile = int( abs( map[nextPos.y][nextPos.x] ));
	if( dirs['$nextTile${nextDir.dir}'] == null ) return null;
	return nextPos;
}

function cellsToString3x3( map:Array<Array<Int>>, width:Int, indy:Pos, rocks:Array<Pos> ) {
	var output = "";
	final height = map.length;
	for( y in 0...height ) {
		for( i in 0...3 ) {
			for( x in 0...width ) {
				final cell = map[y][x];
				final tile = tiles[int(abs(cell))][i];
				
				final isIndyPosition = indy.x == x && indy.y == y;
				final isRockPosition = rocks.fold(( rock, isPosition ) -> isPosition || rock.x == x && rock.y == y, false );
				
				if( i == 1 && isIndyPosition) output += tile.charAt( 0 ) + "@" + tile.charAt( 2 );
				else if( i == 1 && isRockPosition ) output += tile.charAt( 0 ) + "O" + tile.charAt( 2 );
				else output += tile;
			}
			output += "\n";
		}
	}
	return output;
}
