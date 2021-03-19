package server;

import Std.int;
import Std.parseInt;
import Sys.print;
import Sys.println;
import data.Level;
import data.Location;
import data.Transformations.posStringMap;
import haxe.Timer;
import hl.UI.Window;
import parser.ParseLevel.parseLevel;
import sys.io.File;
import sys.io.Process;

function main() {
	
	final args = Sys.args();
	if( args.length != 2 ) {
		println( 'Usage: hl dest/server.hl node dest/client_app.js');
		return;
	}

	final process = new Process( args[0], args.slice( 1 ));
	final pin = process.stdin;
	final pout = process.stdout;
	final perr = process.stderr;
	
	final levelContent = File.getContent( "./dest/levels/rocks_2.txt" );
	final level = parseLevel( levelContent );

	final cells = level.cells;
	final tunnel = new Tunnel( level.locked, level.width );
	
	final initializationInput = createInitializationInput( levelContent );
	
	pin.writeString( initializationInput );
	

	var indy = level.indy;
	var rollingRocks:Array<Location> = [];
	for( i in 0...100 ) {
		for( rockLocation in level.rocks ) {
			if( rockLocation.start == i ) rollingRocks.push({ index: rockLocation.index, pos: rockLocation.pos });
		}

		final rocksString = rollingRocks.map( rock -> tunnel.locationToString( rock )).join( "\n" ) + "\n";
		final clientInput = '${tunnel.locationToString( indy )}\n${rollingRocks.length}\n' + ( rollingRocks.length > 0 ? rocksString : "" );
		print( 'clientInput\n$clientInput' );
		
		final startTime = Timer.stamp();
		
		try { pin.writeString( clientInput ); }
		catch( e ) {
			println( '\nError: $e' );
			printCurrentState( tunnel, level, indy, rollingRocks );
			break;
		}
		
		while( true ) {
			
			var response = "";
			try { response = pout.readLine(); }
			catch( e ) {
				println( 'Error $e' );
				printCurrentState( tunnel, level, indy, rollingRocks );
				break;
			}

			if( response == "WAIT" ) {
				println( response );
				break;

			} else if( response.indexOf( "LEFT" ) != -1 ) {
				final index = tunnel.getIndexOfAction( response );
				tunnel.turnTileLeft( cells, index );
				println( response );
				break;

			} else if( response.indexOf( "RIGHT" ) != -1 ) {
				final index = tunnel.getIndexOfAction( response );
				tunnel.turnTileRight( cells, index );
				println( response );
				break;
				
			} else { // Response is no command. Print it and continue while loop
				println( response );
			}
		}
		println( 'time ${Timer.stamp() - startTime}' );
		println( tunnel.cellsToString3x3( cells, indy, rollingRocks ));
		
		final nextLocation = tunnel.incrementLocation( cells, indy );
		
		if( indy.index == level.exit ) {
			println( "Indy reached the exit" );
			break;
		}
		if( nextLocation == Tunnel.noLocation ) {
			println( 'Indy crashed' );
			break;
		}
		indy = nextLocation;
		rollingRocks = rollingRocks.map( rock -> tunnel.incrementLocation( cells, rock )).filter( rock -> rock != Tunnel.noLocation );
		
		final char = Sys.getChar( false );
		if( char == 27 || char == 3 ) break;

	}

	process.kill();
}

function createInitializationInput( levelContent:String ) {
	final lines = levelContent.split( "\n" );
	final wh = lines[0].split(' ');
	final w = parseInt( wh[0] ); // number of columns.
	final h = parseInt( wh[1] ); // number of rows.
	return lines.slice( 0, h + 2 ).join( "\n" ) + "\n";
}

function printCurrentState( tunnel:Tunnel, level:Level, indy:Location, rollingRocks:Array<Location> ) {
	println( "Current state" );
	println( '${level.width} ${level.height}' );
	println( tunnel.cellsToString( level.cells ));
	println( tunnel.getX( level.exit ));
	println( tunnel.locationToString( indy ));
	println( rollingRocks.length );
	for( rock in rollingRocks ) println( tunnel.locationToString( rock ));
}