
import Pac.PacType;
import Pac.PacFaction;
import haxe.ds.Vector;
using Lambda;

class Main {
	
	public static var frame = 0;

	static function main() {
		
		/**
		 * Grab the pellets as fast as you can!
		 **/

		var inputs = CodinGame.readline().split( ' ' );
		final width = Std.parseInt( inputs[0] ); // size of the grid
		final height = Std.parseInt( inputs[1] ); // top left corner is( x=0, y=0 )
		final lines = [for( _ in 0...height ) CodinGame.readline()];
		// CodinGame.printErr( 'width $width' );

		final grid = GridFactory.createGrid( width, height, lines );
		final pelletBuffer = new Vector<Bool>( width * height );

		final myPacs:Map<Int, Pac> = [];
		final enemyPacs:Map<Int, Pac> = [];
		final superPellets:Map<Int, Bool> = [];

		// game loop
		while( true ) {
			// CodinGame.printErr( 'frame $frame' );
			
			////////////////////////////////////////////////////////////////////////////////////////
			// Cleanup


			for( pac in myPacs ) pac.cleanUp();
			for( key in superPellets.keys()) superPellets.set( key, false );
			for( pac in enemyPacs ) pac.cleanUp();

			////////////////////////////////////////////////////////////////////////////////////////
			// Update

			var inputs = CodinGame.readline().split(' ');
			final myScore = Std.parseInt( inputs[0] );
			final opponentScore = Std.parseInt( inputs[1] );
			final visiblePacCount = Std.parseInt( CodinGame.readline()); // all your pacs and enemy pacs in sight
			for( _ in 0...visiblePacCount ) {
				var inputs = CodinGame.readline().split( ' ' );
				final pacId = Std.parseInt( inputs[0] ); // pac number( unique within a team )
				final faction:PacFaction = inputs[1] != '0' ? Me : Enemy; // true if this pac is yours
				final x = Std.parseInt( inputs[2] ); // position in the grid
				final y = Std.parseInt( inputs[3] ); // position in the grid
				final typeId:PacType = switch inputs[4]{
					case "ROCK": ROCK;
					case "PAPER": PAPER;
					default: SCISSORS;
				}; // ROCK PAPER SCISSORS
				final speedTurnsLeft = Std.parseInt( inputs[5] );
				final abilityCooldown = Std.parseInt( inputs[6] );

				var pacs = faction == Me ? myPacs : enemyPacs;
				if( !pacs.exists( pacId )) {
					final pac = new Pac( pacId, faction, grid, x, y );
					pacs.set( pacId, pac );
				}
				pacs[pacId].update( x, y, typeId, speedTurnsLeft, abilityCooldown );
			}

			
			// remove dead pacs
			for( pac in myPacs ) if( !pac.isVisible ) myPacs.remove( pac.id );
			final visibleCellIndices = myPacs.flatMap( pac -> pac.getVisibleCellIndices());
			final nonEmptyVisibleCellIds = visibleCellIndices.filter( cellId -> grid.getCell( cellId ) != Empty );
			
			
			////////////////////////////////////////////////////////////////////////////////////////
			// Pellets


			for( i in 0...pelletBuffer.length ) pelletBuffer[i] = false;
			final visiblePelletCount = Std.parseInt( CodinGame.readline()); // all pellets in sight
			for( i in 0...visiblePelletCount ) {
				var inputs = CodinGame.readline().split(' ');
				final x = Std.parseInt( inputs[0] );
				final y = Std.parseInt( inputs[1] );
				final value = Std.parseInt( inputs[2] ); // amount of points this pellet is worth
				
				// if(frame >= 9 && frame < 15 ) CodinGame.printErr( 'visible pellet $x $y' );
				pelletBuffer[grid.getCellIndex( x, y )] = true;
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
					superPellets.remove( id );
				}
			}
			
			// clear empty cells
			for( cellId in nonEmptyVisibleCellIds ) {
				// CodinGame.printErr( 'cell ${grid.getCellX( cellId )} ${grid.getCellY( cellId )} ${pelletBuffer[cellId]}' );
				if( !pelletBuffer[cellId] ) {
					grid.setCell( cellId, Empty );
					// CodinGame.printErr( 'clear empty cells set ${grid.getCellX( cellId )} ${grid.getCellY( cellId )} Empty' );
				}
			}

			// CodinGame.printErr( grid.toString() );
			
			
			////////////////////////////////////////////////////////////////////////////////////////
			// Navigation
			
			for( pac in enemyPacs ) if( pac.isVisible ) pac.placeInGrid();
			for( pac in myPacs ) {
				pac.placeInGrid();
				pac.addSuperPellets( superPellets );
				pac.addTargetsAroundPosition( 64 );
				pac.addEnemies( enemyPacs );
			}
			
			final pacs = Lambda.array( myPacs );
			DistributeTargets.distribute( pacs );
			for( pac in pacs ) pac.navigate();
			
			CodinGame.print( myPacs.map( pac -> pac.go()).join( "|" ));     // MOVE <pacId> <x> <y>
		
			// CodinGame.printErr( "Standard Output" );
			// CodinGame.print( myPacs[0].go());
			frame++;
		}
	}



}
