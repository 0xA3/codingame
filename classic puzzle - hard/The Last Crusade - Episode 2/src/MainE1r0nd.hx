import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.abs;
import Std.parseInt;
import Std.string;

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
			
			// trace( 'dirsTurnsStoneL $dirsTurnsStoneL' );
			// trace( 'dirsDoubleTurnsStoneL $dirsDoubleTurnsStoneL' );
			// trace( 'dirsTurnsStoneR $dirsTurnsStoneR' );

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

	static function findRockRoute( pos:Pos, ?newPath:Array<Pos>, map:Array<Array<Int>> ) {
		if( newPath == null ) newPath = [];
		if( pos.y >= map.length || pos.x < 0 || pos.x >= map[0].length ) return newPath;

		newPath.push({ x: pos.x, y: pos.y, dir: pos.dir });
		final move = dirs[string( abs( map[pos.y][pos.x])) + pos.dir];
		if( move == null ) return newPath;

		final nextMove:Pos = {
			x: pos.x + ( move.x == null ? 0 : move.x ),
			y: pos.y + ( move.y == null ? 0 : move.y ),
			dir: move.dir
		}
		return findRockRoute( nextMove, newPath, map );
	}

	static function findStone( path:Array<Pos>, map:Array<Array<Int>> ) {
		final path2 = path.slice( 1 );
		final stones = path2.map( pos -> {
			final stone = map[pos.y][pos.x];
			if( stone > 1 ) {
				if( dirs[string( turns[string( stone ) + 'L'] ) + pos.dir] == null ) {
					final pos:Pos = { x: pos.x, y: pos.y, dir: pos.dir, turn: 'LEFT'};
					return pos;
				}
				final pos:Pos = { x: pos.x, y: pos.y, dir: pos.dir, turn: 'RIGHT'};
				return pos;
			}
			return null;
		}).filter( s -> s != null );
		return stones;
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
			
			final output = process( indy, inputRocks, exit, map, rocksblocked );
			print( output );
		}

	}
	
	public static inline function process( indy:Pos, inputRocks:Array<Pos>, exit:Int, map:Array<Array<Int>>, rocksblocked:Array<Pos> ) {
		
		final rockPaths = inputRocks.map( rock -> findRockRoute( rock, map ));
		final rocks = rockPaths.map( rockPath -> findStone( rockPath, map )).filter( x -> x.length > 0 );
		
		final path = findExit( indy, exit, map );
		if( path == null ) throw "Error: no path found";
		var turnable = path.find( x -> x.turn != null );

		while( rocks.length > 0 && path.indexOf( turnable ) > 1 ) {
			rocks.sort(( a, b ) -> a.length - b.length );
			final crushed = rocks[0];
			final curr = crushed[0];
			final rocksblock = rocksblocked.find(( pos ) -> pos.x == curr.x && pos.y == curr.y );
			final found = rocksblock != null;
			if( indy.x == curr.x && indy.y == curr.y || found ) {
				rocks.splice( rocks.indexOf( crushed ), 1 );
			} else {
				turnable = curr;
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

}
