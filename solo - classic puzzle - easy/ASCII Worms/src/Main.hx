import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

function main() {

	final thickness = parseInt( readline() );
	final length = parseInt( readline() );
	final turns = parseInt( readline() );

	final result = process( thickness, length, turns );
	print( result );
}

function process( thickness:Int, length:Int, turns:Int ) {
	final lines = [];
	
	// Top
	var line = "";
	for( i in 0...int( turns / 2 + 1 )) {
		line += " ";
		if( i == 0 ) for( _ in 0...thickness ) line += "_";
		else for( _ in 0...thickness * 2 + 1 ) line += "_";
	}
	if( turns % 2 == 1 ) {
		line += " ";
		for( _ in 0...thickness ) line += "_";
	}
	lines.push( line );
	
	
	// First line
	var line = "";
	for( i in 0...int( turns / 2 + 1 )) {
		line += "|";
		if( i == 0 ) for( _ in 0...thickness ) line += " ";
		else for( _ in 0...thickness * 2 + 1 ) line += " ";
	}
	if( turns % 2 == 1 ) {
		line += "|";
		for( _ in 0...thickness ) line += " ";
	}
	lines.push( line + "|" );
	
	
	// Center lines
	for( _ in 0...length - 2 ) {
		var line = "";
		for( _ in 0...turns + 1 ) {
			line += "|";
			for( _ in 0...thickness ) line += " ";
		}
		lines.push( line + "|" );
	}
	

	// Bottom Line
	var line = "";
	for( i in 0...int( turns / 2 + 1 )) {
		line += "|";
		if( i == int( turns / 2 ) && turns % 2 == 0 ) for( _ in 0...thickness ) line += "_";
		else for( _ in 0...thickness * 2 + 1 ) line += "_";
	}
	lines.push( line + "|" );

	// trace( "\n" + lines.join( "\n" ) );

	return lines.join( "\n" );
}
