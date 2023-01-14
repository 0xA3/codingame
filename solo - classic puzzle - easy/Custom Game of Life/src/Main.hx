import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final inputs = readline().split(' ');
	final h = parseInt( inputs[0] );
	final w = parseInt( inputs[1] );
	final n = parseInt( inputs[2] );
	final alive = readline();
	final dead = readline();
	final lines = [for( i in 0...h ) readline()];
	
	final result = process( w, h, n, alive, dead, lines );
	print( result );
}

function process( width:Int, height:Int, numberOfTurns:Int, aliveInput:String, deadInput:String, lines:Array<String> ) {
	final alive = aliveInput.split( "" ).map( s -> s == "1" ? true : false );
	final dead = deadInput.split( "" ).map( s -> s == "1" ? true : false );
	
	var grid = Grid.create( width, height, lines );
	for( i in 0...numberOfTurns ) grid = grid.evolve( alive, dead );
	
	return grid.toString();
}
