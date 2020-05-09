
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
		// CodinGame.printErr( lines );

		final grid = GridFactory.createGrid( width, height, lines );
		final pelletBuffer = new Vector<Bool>( width * height );

		final myPacs:Map<Int, Pac> = [];
		final enemyPacs:Map<Int, Pac> = [];
		final superPellets:Map<Int, Bool> = [];

		var frame = 0;
		// game loop
		while( true ) {
			frame++;
			// CodinGame.printErr( 'frame $frame' );
			for( pac in myPacs ) pac.cleanUp();
			for( key in superPellets.keys()) superPellets.set( key, false );
			// for( pac in enemyPacs ) pac.cleanUp();

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
				final typeId = inputs[4]; // ROCK PAPER SCISSORS
				final speedTurnsLeft = Std.parseInt( inputs[5] );
				final abilityCooldown = Std.parseInt( inputs[6] );

				var pacs = mine ? myPacs : enemyPacs;
				if( !pacs.exists( pacId )) {
					final pac = new Pac( pacId, grid, x, y );
					pacs.set( pacId, pac );
				}
				pacs[pacId].update( x, y, typeId, speedTurnsLeft, abilityCooldown );
			}

			for( pac in myPacs ) if( !pac.isVisible ) myPacs.remove( pac.id );

			final visibleCellIds = myPacs.flatMap( pac -> pac.getVisibleCellIds());
			final nonEmptyVisibleCellIds = visibleCellIds.filter( cellId -> grid.getCell( cellId ) != Empty );
			// for( cellId in nonEmptyVisibleCellIds ) {
			// 	if( grid.getCellY( cellId ) == 3 ) {
			// 		CodinGame.printErr( 'nonEmptyVisible ${grid.getCellX( cellId )} ${grid.getCellY( cellId )}' );
			// 	}
			// }
			// if( frame == 9 ) for( cellId in visibleCellIds ) CodinGame.printErr( 'visible ${grid.getCellX( cellId )} ${grid.getCellY( cellId )}' );

			
			for( i in 0...pelletBuffer.length ) pelletBuffer[i] = false;
			final visiblePelletCount = Std.parseInt( CodinGame.readline()); // all pellets in sight
			for( i in 0...visiblePelletCount ) {
				var inputs = CodinGame.readline().split(' ');
				final x = Std.parseInt( inputs[0] );
				final y = Std.parseInt( inputs[1] );
				final value = Std.parseInt( inputs[2] ); // amount of points this pellet is worth
				
				// if(frame >= 9 && frame < 15 ) CodinGame.printErr( 'visible pellet $x $y' );
				pelletBuffer[grid.getCellId( x, y )] = true;
				final cell = grid.getCell2d( x, y );
				switch cell {
					case Unknown:
						// CodinGame.printErr( 'set $x $y Food($value)' );
						grid.setCell2d( x, y, value == 1 ? Food : Superfood );
					default: // no-op
				}
				if( value > 1 ) superPellets.set( y * width + x, true );
			}
			
			// remove disappeared superPellets
			for( id in superPellets.keys() ) {
				if( !superPellets.get( id )) {
					grid.setCell( id, Empty );
					// CodinGame.printErr( 'remove superPellet ${grid.getCellX( id )} ${grid.getCellY( id )} Empty' );
				}
			}
			
			// final id1 = grid.getCellId( 1, 1 );
			// clear empty cells
			for( cellId in nonEmptyVisibleCellIds ) {
				// CodinGame.printErr( 'cell ${grid.getCellX( cellId )} ${grid.getCellY( cellId )} ${pelletBuffer[cellId]}' );
				if( !pelletBuffer[cellId] ) {
					grid.setCell( cellId, Empty );
					// CodinGame.printErr( 'clear empty cells set ${grid.getCellX( cellId )} ${grid.getCellY( cellId )} Empty' );
				}
			}

			// CodinGame.printErr( grid.toString() );
			// Write an action using console.log()
			// To debug: console.error( 'Debug messages...' );
		
			for( pac in myPacs ) pac.addPellets();
			final sortedPacs = Lambda.array( myPacs );
			sortedPacs.sort( Pac.sortByPelletPriority );
			for( pac in sortedPacs ) pac.navigate();
			CodinGame.print( myPacs.map( pac -> pac.go()).join( "|" ));     // MOVE <pacId> <x> <y>
		
			// CodinGame.printErr( "Standard Output" );
			// CodinGame.print( myPacs[0].go());
		}
	}



}
