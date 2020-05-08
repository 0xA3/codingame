
import haxe.ds.Vector;
using Lambda;

class Main {
	
	static function main() {
		
		/**
		 * Grab the pellets as fast as you can!
		 **/

		var inputs = CodinGame.readline().split( ' ' );
		final width = Std.parseInt( inputs[0] ); // size of the grid
		final height = Std.parseInt( inputs[1] ); // top left corner is( x=0, y=0 )
		final lines = [for( _ in 0...height ) CodinGame.readline()];

		final grid = GridFactory.createGrid( width, height, lines );

		final pelletBuffer = new Vector<Bool>( width * height );

		CodinGame.printErr( lines );

		final myPacs:Map<Int, Pac> = [];
		final enemyPacs:Map<Int, Pac> = [];

		// game loop
		while( true ) {
			
			for( pac in myPacs ) pac.isVisible = false;

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
					final pac = new Pac( pacId, grid );
					pacs.set( pacId, pac );
				}
				pacs[pacId].update( x, y, typeId, speedTurnsLeft, abilityCooldown );
			}

			final visibleCellIds = myPacs.flatMap( pac -> pac.getVisibleCellIds());
			final nonEmptyVisibleCellIds = visibleCellIds.filter( cellId -> grid.getCell( cellId ) != Empty );

			for( i in 0...pelletBuffer.length ) pelletBuffer[i] = false;
			final visiblePelletCount = Std.parseInt( CodinGame.readline()); // all pellets in sight
			for( i in 0...visiblePelletCount ) {
				var inputs = CodinGame.readline().split(' ');
				final x = Std.parseInt( inputs[0] );
				final y = Std.parseInt( inputs[1] );
				final value = Std.parseInt( inputs[2] ); // amount of points this pellet is worth
				
				final cell = grid.cells[y * width + x];
				switch cell {
					case Unknown: grid.cells[y * width + x] = Food( value );
					default: // no-op
				}
				pelletBuffer[y * width + x] = true;
			}
			// clear empty cells
			for( cellId in nonEmptyVisibleCellIds ) if( !pelletBuffer[cellId] ) grid.setCell( cellId, Empty );
			for( pac in myPacs ) pac.addPellets();

			CodinGame.printErr( grid.toString() );
			// Write an action using console.log()
			// To debug: console.error( 'Debug messages...' );
		
			final myVisiblePacs = myPacs.filter( pac -> pac.isVisible );
			CodinGame.print( myVisiblePacs.map( pac -> pac.move()).join( " | " ));     // MOVE <pacId> <x> <y>
		
		}
	}



}
