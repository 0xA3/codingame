import haxe.ds.ArraySort;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

import Direction;
import Mode;
import Bender;

using Lambda;

class Main {
	
	static function main() {
		
		final inputs = readline().split(' ');
		final l = parseInt( inputs[0] );
		final c = parseInt( inputs[1] );
		final rows = [for( i in 0...l ) readline()];
				
		final result = process( rows );
		print( result );
	}

	static function process( rows:Array<String> ) {
		
		final map = rows.flatMap( row -> row.split( "" ));
		final mapWidth = rows[0].length;

		final pos = map.indexOf( "@" );
		final direction = 0;
		final inputdirections = [South, East, North, West];
		final mode = Normal;
		final booth = map.indexOf( "$" );

		final positions:Map<String, Bool> = [];
		var bender = new Bender( map, mapWidth, pos, direction, inputdirections, mode, positions );
		// trace( bender.getMapOutput());

		final directions = [];
		// for( _ in 0...5 ) {
		while( true ) {
			bender = bender.move();
			directions.push( bender.getDirection());
			// trace( bender.getMapOutput());
			// trace( directions );
			if( bender.pos == booth ) break;
			
			final position = bender.createPosition();
			if( bender.positions.exists( position )) return "LOOP";
			bender.positions.set( position, true );
			
		}

		return directions.map( d -> PrintDirection.print( d )).join( "\n" );
	}


}
