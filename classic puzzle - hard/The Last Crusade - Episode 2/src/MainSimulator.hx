import Sys.println;
import data.Location;
import haxe.Timer;
import parser.ParseLevel.parseLevel;
import sys.io.File;

// Local simulator

function main() {
	
	// final levelContent = File.getContent( "./dest/levels/avoiding_rocks.txt" );
	// final levelContent = File.getContent( "./dest/levels/broken_mausoleum.txt" );
	// final levelContent = File.getContent( "./dest/levels/broken_secret_passages.txt" );
	// final levelContent = File.getContent( "./dest/levels/broken_sewer.txt" );
	// final levelContent = File.getContent( "./dest/levels/broken_well.txt" );
	// final levelContent = File.getContent( "./dest/levels/multiple_choice_and_rocks.txt" );
	// final levelContent = File.getContent( "./dest/levels/only_one_way_validator.txt" );
	// final levelContent = File.getContent( "./dest/levels/only_one_way.txt" );
	// final levelContent = File.getContent( "./dest/levels/rock_interception.txt" );
	final levelContent = File.getContent( "./dest/levels/rocks_1.txt" );
	// final levelContent = File.getContent( "./dest/levels/rocks_2.txt" );
	// final levelContent = File.getContent( "./dest/levels/rocks_2_test.txt" );
	// final levelContent = File.getContent( "./dest/levels/simple.txt" );
	// final levelContent = File.getContent( "./dest/levels/underground_complex.txt" );
	
	final level = parseLevel( levelContent );
	final cells = level.cells.copy();
	final exit = level.exit;
	final tunnel = new Tunnel( level.locked, level.width );

	final crusade = new Crusade( level.cells.copy(), tunnel, exit );

	var indy:Location = { index: level.indy.index, pos: level.indy.pos };
	var rollingRocks:Array<Location> = [];
	
	for( i in 0...100 ) {
		for( rockLocation in level.rocks ) {
			if( rockLocation.start == i ) rollingRocks.push({ index: rockLocation.index, pos: rockLocation.pos });
		}

		println( tunnel.cellsToString3x3( cells, indy, rollingRocks ));
	
		final startTime = Timer.stamp();
		final action = crusade.getAction( indy, rollingRocks );
		println( 'time ${Timer.stamp() - startTime}' );
		
		if( action == "WAIT" ) {
			println( action );

		} else if( action.indexOf( "LEFT" ) != -1 ) {
			final index = tunnel.getIndexOfAction( action );
			tunnel.turnTileLeft( cells, index );
			println( action );

		} else if( action.indexOf( "RIGHT" ) != -1 ) {
			final index = tunnel.getIndexOfAction( action );
			tunnel.turnTileRight( cells, index );
			println( action );
			
		} else { // Response is no command. Print it and continue while loop
			println( action );
		}
		
		final nextLocation = tunnel.incrementLocation( indy.index, indy.pos, cells );
		
		if( indy.index == level.exit ) {
			println( "Indy reached the exit" );
			println( tunnel.cellsToString3x3( cells, indy, rollingRocks ));
			break;
		}
		if( nextLocation == Tunnel.noLocation ) {
			println( 'Indy crashed' );
			println( tunnel.cellsToString3x3( cells, indy, rollingRocks ));
			break;
		}
		indy = nextLocation;
		rollingRocks = rollingRocks.map( rock -> tunnel.incrementLocation( rock.index, rock.pos, cells )).filter( rock -> rock != Tunnel.noLocation );
		
		final char = Sys.getChar( false );
		if( char == 27 || char == 3 ) break;

	}

}
