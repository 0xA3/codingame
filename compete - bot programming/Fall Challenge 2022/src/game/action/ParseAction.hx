package game.action;

import Std.parseInt as p;
import game.action.Action;
import view.Coord;

class ParseAction {
	
	static final rMove = ~/^MOVE (\d+) (\d+) (\d+) (\d+) (\d+)/;
	static final rWarp = ~/^WARP (\d+) (\d+) (\d+) (\d+) (\d+)/;
	static final rSpawn = ~/^SPAWN (\d+) (\d+) (\d+)/;
	static final rBuild = ~/^BUILD (\d+) (\d+)/;
	static final rMessage = ~/^MESSAGE (.*)/;
	static final rWait = ~/^WAIT/;

	public static function parse( s:String ) {
		
		if( rMove.match( s )) {
			final amount = rMove.matched( 1 );
			final x1 = rMove.matched( 2 );
			final y1 = rMove.matched( 3 );
			final x2 = rMove.matched( 4 );
			final y2 = rMove.matched( 5 );
			return Move( p( amount ), new Coord( p( x1 ), p( y1 )), new Coord( p( x2 ), p( y2 )) );
		
		} else if( rWarp.match( s )) {
			final amount = rWarp.matched( 1 );
			final x1 = rWarp.matched( 2 );
			final y1 = rWarp.matched( 3 );
			final x2 = rWarp.matched( 4 );
			final y2 = rWarp.matched( 5 );
			return Warp( p( amount ), new Coord( p( x1 ), p( y1 )), new Coord( p( x2 ), p( y2 )) );
		
		} else if( rSpawn.match( s )) {
			final amount = rSpawn.matched( 1 );
			final x = rSpawn.matched( 2 );
			final y = rSpawn.matched( 3 );
			return Spawn( p( amount ), new Coord( p( x ), p( y )) );

		} else if( rBuild.match( s )) {
			final x = rBuild.matched( 1 );
			final y = rBuild.matched( 2 );
			return Build( new Coord( p( x ), p( y )) );

		} else if( rMessage.match( s )) {
			final text = rMessage.matched( 1 );
			return Message( text );
		
		} else if( rWait.match( s )) {
			return Wait;
		
		} else {
			throw 'Error: unknown command $s';
		}
	}
}