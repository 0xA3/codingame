using Lambda;

class Main {
	
	static var width:Int;
	static var height:Int;
	static var grid:Array<Bool>;

	static function main() {
		
		/**
		 * Grab the pellets as fast as you can!
		 **/

		var inputs = CodinGame.readline().split( ' ' );
		width = Std.parseInt( inputs[0] ); // size of the grid
		height = Std.parseInt( inputs[1] ); // top left corner is( x=0, y=0 )
		final lines = [for( _ in 0...height ) CodinGame.readline()];
		grid = lines.map( line -> line.split("").map( cell -> cell == " " ? true : false )).flatten();

		CodinGame.printErr( lines );

		// game loop
		while( true ) {
			
			final myPacs:Map<Int, Pac> = [];
			final enemyPacs:Map<Int, Pac> = [];

			var inputs = CodinGame.readline().split(' ');
			final myScore = Std.parseInt( inputs[0] );
			final opponentScore = Std.parseInt( inputs[1] );
			final visiblePacCount = Std.parseInt( CodinGame.readline()); // all your pacs and enemy pacs in sight
			for( _ in 0...visiblePacCount ) {
				var inputs = CodinGame.readline().split( ' ' );
				final pacId = Std.parseInt( inputs[0] ); // pac number( unique within a team )
				final mine = inputs[1] != '0'; // true if this pac is yours
				final x = Std.parseInt( inputs[2] ); // position in the grid
				final y = Std.parseInt( inputs[3] ); // position in the grid
				final typeId = inputs[4]; // unused in wood leagues
				final speedTurnsLeft = Std.parseInt( inputs[5] ); // unused in wood leagues
				final abilityCooldown = Std.parseInt( inputs[6] ); // unused in wood leagues

				var pacs = mine ? myPacs : enemyPacs;
				if( !pacs.exists( pacId )) {
					final pac = new Pac( pacId );
					pacs.set( pacId, pac );
				}
				pacs[pacId].update( x, y, typeId, speedTurnsLeft, abilityCooldown );
			}

			final visiblePelletCount = Std.parseInt( CodinGame.readline()); // all pellets in sight
			for( i in 0...visiblePelletCount ) {
				var inputs = CodinGame.readline().split(' ');
				final x = Std.parseInt( inputs[0] );
				final y = Std.parseInt( inputs[1] );
				final value = Std.parseInt( inputs[2] ); // amount of points this pellet is worth

				for( pac in myPacs ) pac.addPellet( x, y, value );
			}
		
			// Write an action using console.log()
			// To debug: console.error( 'Debug messages...' );
		
			CodinGame.print( myPacs.map( pac -> pac.move()).join( " | " ));     // MOVE <pacId> <x> <y>
		
		}
	}

	static function getGridPoint( x:Int, y:Int ) {
		return grid[y * height + x];
	}
}
