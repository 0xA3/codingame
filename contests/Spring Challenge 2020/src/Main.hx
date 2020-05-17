
import PacType;
import haxe.ds.Vector;
using Lambda;

class Main {
	
	public static var frame = 0;

	static var grid:Grid;
	static final myPacs:Map<Int, Pac> = [];
	static final pacPelletManagers:Map<Int, PelletManager> = [];
	static final enemyPacs:Map<Int, EnemyPac> = [];
	static final superPellets:Map<Int, Bool> = [];
	
	static var pelletBuffer:Vector<Bool>;
	static var visibleCellIndices:Array<Int>;
	static var nonEmptyVisibleCellIds:Array<Int>;
	
	static function main() {
		
		/**
		 * Grab the pellets as fast as you can!
		 **/

		var inputs = CodinGame.readline().split( ' ' );
		final width = Std.parseInt( inputs[0] ); // size of the grid
		final height = Std.parseInt( inputs[1] ); // top left corner is( x=0, y=0 )
		final lines = [for( _ in 0...height ) CodinGame.readline()];
		// CodinGame.printErr( 'width $width' );

		grid = GridFactory.createGrid( width, height, lines );
		pelletBuffer = new Vector<Bool>( width * height );
		final coordinator = new Coordinator( grid, myPacs, superPellets );

		updatePacs();
		for( pacId => pac in myPacs ) {
			if( !enemyPacs.exists( pacId )) {
				final enemyPac = pac.mirrorToEnemy();
				enemyPac.reset();
				enemyPac.update( enemyPac.x, enemyPac.y, pac.type, 0, 0 );
				enemyPacs.set( pacId, enemyPac );
			}
		}
		updatePellets( width );
		coordinator.navigate();
		output();
		frame++;

		// game loop
		while( true ) {
			// CodinGame.printErr( 'frame $frame' );
			reset();
			updatePacs();
			updatePellets( width );
			coordinator.navigate();
			output();
			frame++;
		}
	}

	static inline function reset() {
		for( pac in myPacs ) pac.reset();
		for( pac in enemyPacs ) pac.reset();
		for( key in superPellets.keys()) superPellets.set( key, false );
	}

	static inline function updatePacs() {

		var inputs = CodinGame.readline().split(' ');
		final myScore = Std.parseInt( inputs[0] );
		final opponentScore = Std.parseInt( inputs[1] );
		final visiblePacCount = Std.parseInt( CodinGame.readline()); // all your pacs and enemy pacs in sight
		for( _ in 0...visiblePacCount ) {
			var inputs = CodinGame.readline().split( ' ' );
			final pacId = Std.parseInt( inputs[0] ); // pac number( unique within a team )
			final myFaction = inputs[1] != '0' ? true : false; // true if this pac is yours
			final x = Std.parseInt( inputs[2] ); // position in the grid
			final y = Std.parseInt( inputs[3] ); // position in the grid
			final typeId:PacType = switch inputs[4] { // ROCK PAPER SCISSORS
				case "ROCK": ROCK;
				case "PAPER": PAPER;
				case "SCISSORS": SCISSORS;
				default: DEAD;
			};
			final speedTurnsLeft = Std.parseInt( inputs[5] );
			final abilityCooldown = Std.parseInt( inputs[6] );

			if( myFaction ) {
				if( !myPacs.exists( pacId )) {
					final pelletManager = new PelletManager( pacId, grid );
					pacPelletManagers.set( pacId, pelletManager );
					myPacs.set( pacId, new Pac( pacId, pelletManager, grid, x, y, enemyPacs ) );
				}
				myPacs[pacId].update( x, y, typeId, speedTurnsLeft, abilityCooldown );
			} else {
				if( !enemyPacs.exists( pacId ))	enemyPacs.set( pacId, new EnemyPac( pacId, grid, x, y ));
				enemyPacs[pacId].update( x, y, typeId, speedTurnsLeft, abilityCooldown );
			}
		}
		visibleCellIndices = myPacs.filter( pac -> pac.type != DEAD ).flatMap( pac -> pac.getVisibleCellIndices());
	}

	static inline function updatePellets( width:Int ) {

		nonEmptyVisibleCellIds = visibleCellIndices.filter( cellId -> grid.getCell( cellId ) != Empty );

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
	}

	static inline function output() {
		CodinGame.print( myPacs.map( pac -> pac.go()).join( "|" ));     // MOVE <pacId> <x> <y>
	}
}
