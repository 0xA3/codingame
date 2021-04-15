import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.parseInt;
import Std.string;
import haxe.ds.ArraySort;

using ArrayUtils;

typedef Pos = {
	var x:Null<Int>;
	var y:Null<Int>;
	var dir:String;
	var ?turn:String;
	var ?next:Pos;
}

typedef Node = {
	?turn:String,
	move:Pos
}

class MainE1r0nd {

	public static final dirs:Map<String, Pos> = [
		'1T' =>  { x:  0, y: 1, dir: 'T' },
		'1L' =>  { x:  0, y: 1, dir: 'T' },
		'1R' =>  { x:  0, y: 1, dir: 'T' },
		'2L' =>  { x:  1, y: 0, dir: 'L' },
		'2R' =>  { x: -1, y: 0, dir: 'R' },
		'3T' =>  { x:  0, y: 1, dir: 'T' },
		'4T' =>  { x: -1, y: 0, dir: 'R' },
		'4R' =>  { x:  0, y: 1, dir: 'T' },
		'5T' =>  { x:  1, y: 0, dir: 'L' },
		'5L' =>  { x:  0, y: 1, dir: 'T' },
		'6L' =>  { x:  1, y: 0, dir: 'L' },
		'6R' =>  { x: -1, y: 0, dir: 'R' },
		'7T' =>  { x:  0, y: 1, dir: 'T' },
		'7R' =>  { x:  0, y: 1, dir: 'T' },
		'8L' =>  { x:  0, y: 1, dir: 'T' },
		'8R' =>  { x:  0, y: 1, dir: 'T' },
		'9T' =>  { x:  0, y: 1, dir: 'T' },
		'9L' =>  { x:  0, y: 1, dir: 'T' },
		'10T' => { x: -1, y: 0, dir: 'R' },
		'11T' => { x:  1, y: 0, dir: 'L' },
		'12R' => { x:  0, y: 1, dir: 'T' },
		'13L' => { x:  0, y: 1, dir: 'T' }
	];

	public static final turns = [
		'2L' => 3,
		'2R' => 3,
		'3L' => 2,
		'3R' => 2,
		'4L' => 5,
		'4R' => 5,
		'5L' => 4,
		'5R' => 4,
		'6L' => 9,
		'6R' => 7,
		'7L' => 6,
		'7R' => 8,
		'8L' => 7,
		'8R' => 9,
		'9L' => 8,
		'9R' => 6,
		'10L' => 13,
		'10R' => 11,
		'11L' => 10,
		'11R' => 12,
		'12L' => 11,
		'12R' => 13,
		'13L' => 12,
		'13R' => 10
	];

	static final rocksblocked:Array<Pos> = [];

	static function findPos( pos:Pos, map:Array<Array<Int>> ):Array<Pos> {
		// printErr( 'findPos $pos map $map' );
		final stone = map[pos.y][pos.x];
		final sStone = string( abs( stone ));
		// printErr( 'stone $stone' );
		final newPath:Array<Node> = [{
			move: dirs[sStone + pos.dir]
		}];

		if( stone != 0 ) {
			final turnsStoneL = string( turns[ sStone + 'L'] );
			final dirsTurnsStoneL = dirs[turnsStoneL + pos.dir];
			
			final doubleTurnsStoneL = string( turns[ turnsStoneL + 'L' ]);
			final dirsDoubleTurnsStoneL = dirs[doubleTurnsStoneL + pos.dir];
			
			final turnsStoneR = string( turns[ sStone + 'R'] );
			final dirsTurnsStoneR = dirs[turnsStoneR + pos.dir];
			
			newPath.push({
				turn: 'LEFT',
				move: dirsTurnsStoneL
			});
			newPath.push({
				turn: 'LEFT',
				move: dirsDoubleTurnsStoneL
			});
			newPath.push({
				turn: 'RIGHT',
				move: dirsTurnsStoneR
			});
		}
		
		return newPath.map( node -> {
			if( node.move == null ) return null;
			final pos:Pos = {
				x: pos.x,
				y: pos.y,
				dir: pos.dir,
				turn: node.turn,
				next: {
					x: pos.x + (  node.move.x != 0 ?  node.move.x : 0 ),
					y: pos.y + (  node.move.y != 0 ?  node.move.y : 0 ),
					dir: node.move.dir
				}
			};
			return pos;
		}).filter( n -> n != null );
	}

	static function findExit( pos:Pos, EX:Int, map:Array<Array<Int>>, ?newPath:Array<Pos> ) {
		if( newPath == null ) newPath = [];
		
		if( pos.x == EX && pos.y == map.length ) return newPath;
		if( pos.y >= map.length || pos.x < 0 || pos.x > map[0].length ) return null;

		final moves = findPos( pos, map );
		for( move in moves ) {
			newPath.push( move );
			if( findExit( move.next, EX, map, newPath ) != null ) return newPath;
			newPath.splice( newPath.length - 1, newPath.length );
		}
		return null;
	}

	static function findRockRoute( pos:Pos, indy:Pos, map:Array<Array<Int>>, ?newPath:Array<Pos> ) {
		if( newPath == null ) newPath = [];
		if( pos.y >= map.length || pos.x < 0 || pos.x >= map[0].length ) return newPath;
		if( pos.x == indy.x && pos.y == indy.y ) return newPath;

		newPath.push({ x: pos.x, y: pos.y, dir: pos.dir });
		// printErr( 'push ${pos.x}:${pos.y} dir ${pos.dir}' );
		final tile = abs( map[pos.y][pos.x] );
		final move = dirs['$tile${pos.dir}'];
		if( move == null ) return newPath;

		final nextMove:Pos = {
			x: pos.x + ( move.x == null ? 0 : move.x ),
			y: pos.y + ( move.y == null ? 0 : move.y ),
			dir: move.dir
		}
		return findRockRoute( nextMove, indy, map, newPath );
	}

	static function findRockTurns( path:Array<Pos>, map:Array<Array<Int>> ) { // find all turns that distroy the rock
		final path2 = path.slice( 1 );
		final rockTurns = path2.map( pos -> {
			final tile = map[pos.y][pos.x];
			if( tile > 1 ) {
				final turn = turns[string( tile ) + 'L'];
				// printErr( '${pos.x}:${pos.y} tile $tile turn $turn  dir ' + dirs['$turn${pos.dir}'] );
				if( dirs['$turn${pos.dir}'] == null ) {
					final turnPos:Pos = { x: pos.x, y: pos.y, dir: pos.dir, turn: 'LEFT'};
					return turnPos;
				}
				final turnPos:Pos = { x: pos.x, y: pos.y, dir: pos.dir, turn: 'RIGHT'};
				return turnPos;
			}
			return null;
		}).filter( s -> s != null );
		// for( rockTurn in rockTurns ) trace( rockTurn );
		return rockTurns;
	}
	
	static function main() {
		
		final inputs = readline().split(' ');
		final w = parseInt( inputs[0] ); // number of columns.
		final h = parseInt( inputs[1] ); // number of rows.
		final map = [for( i in 0...h ) readline().split(" ").map( a -> parseInt( a ))]; // represents a line in the grid and contains W integers. Each integer represents one room of a given type.
		final exit = parseInt( readline()); // the coordinate along the X axis of the exit (not useful for this first mission, but must be read).

		var rocksblocked = [];

		while( true ) {
			final line = readline().split(' ');
			final indy:Pos = {
				x: parseInt( line[0] ),
				y: parseInt( line[1] ),
				dir: line[2].charAt( 0 )
			}

			final rocksNum = parseInt( readline());
			final inputRocks:Array<Pos> = [for( _ in 0...rocksNum) {
				final line = readline().split(' ');
				final rock:Pos = {
					x: parseInt( line[0] ),
					y: parseInt( line[1] ),
					dir: line[2].charAt( 0 )
				}
				rock;
			}];
			
			final output = process( indy, inputRocks, exit, map );
			print( output );
		}

	}
	
	public static inline function process( indy:Pos, inputRocks:Array<Pos>, exit:Int, map:Array<Array<Int>> ) {
		
		// printErr( 'inputRocks ' + inputRocks.map( rock -> '${rock.x}:${rock.y}' ).join( ", " ));
		
		final rockRoutes = inputRocks.map( rock -> findRockRoute( rock, indy, map ));
		final rockRouteTurns = rockRoutes.map( rockPath -> findRockTurns( rockPath, map )).filter( x -> x.length > 0 );
		// for( rockRouteTurn in rockRouteTurns ) trace( rockRouteTurn );
		final path = findExit( indy, exit, map );
		if( path == null ) throw "Error: no path found";
		var turnable = path.find( x -> x.turn != null ); // find first turnable pos

		while( rockRouteTurns.length > 0 && path.indexOf( turnable ) > 1 ) { // if there are rocks and next indy pos doesn't need to be turned
			ArraySort.sort( rockRouteTurns, ( a, b ) -> a.length - b.length ); // sort rock routes by length
			final shortestRockRoute = rockRouteTurns[0]; // pick shortest rock route
			
			// printRockRoutes( rockRouteTurns );
			
			final firstRockPos = shortestRockRoute[0]; // get first rock pos
			final rocksblock = rocksblocked.find(( pos ) -> pos.x == firstRockPos.x && pos.y == firstRockPos.y ); // check if first rock pos is blocked by another rock
			
			final found = rocksblock != null;
			if( indy.x == firstRockPos.x && indy.y == firstRockPos.y || found ) { // check if indy or other rock is at nearest rock pos
				rockRouteTurns.splice( rockRouteTurns.indexOf( shortestRockRoute ), 1 ); // remove rock pos from rock route
			} else {
				turnable = firstRockPos;
				// printErr( 'set turnable to ${firstRockPos.x}:${firstRockPos.y}' );
				rocksblocked.push( turnable );
			}
		}
		
		if( turnable != null ) {
			final x = turnable.x;
			final y = turnable.y;
			final turn = turnable.turn;
			map[y][x] = turns[ string( map[y][x] ) + turn.charAt(0)];
			return '$x $y $turn';
		} else {
			return 'WAIT';
		}
	}

	static function printRockRoutes( rockRoutes:Array<Array<Pos>> ) {
		for( i in 0...rockRoutes.length ) {
			final route = rockRoutes[i];
			printErr( 'rockRoute $i ' + route.map( pos -> '${pos.x}:${pos.y}' ).join(", "));
		}
	}

}
