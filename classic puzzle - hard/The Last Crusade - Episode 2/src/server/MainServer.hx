package server;

import Std.int;
import Std.parseInt;
import Std.string;
import Sys.println;
import data.Location;
import data.Transformations.posStringMap;
import parser.ParseLevel.parseLevel;
import sys.io.File;
import sys.io.Process;

function main() {
	
	final args = Sys.args();
	if( args.length != 2 ) {
		println( 'Usage: hl dest/server.hl hl dest/app.js');
		return;
	}

	final process = new Process( args[0], args.slice( 1 ));
	final pin = process.stdin;
	final pout = process.stdout;
	final perr = process.stderr;
	
	final levelContent = File.getContent( "./dest/levels/simple.txt" );
	final level = parseLevel( levelContent );
	
	final initializationInput = createInitializationInput( levelContent );
	
	pin.writeString( initializationInput );
	
	var indy = level.indy;
	final rocks = 0;
	// for( i in 0...100 ) {
		pin.writeString( locationToString( indy, level.width ) + string( rocks ) + "\n" );
		final response = pout.readLine();
	// }

	trace( response );
	
	process.kill();
	
}

function createInitializationInput( levelContent:String ) {
	final lines = levelContent.split( "\n" );
	final wh = lines[0].split(' ');
	final w = parseInt( wh[0] ); // number of columns.
	final h = parseInt( wh[1] ); // number of rows.
	return lines.slice( 0, h + 2 ).join( "\n" ) + "\n";
}

function locationToString( location:Location, width:Int ) {
	final x = location.index % width;
	final y = int( location.index / width );
	final pos = posStringMap[location.pos];
	return '$x $y $pos\n';
}