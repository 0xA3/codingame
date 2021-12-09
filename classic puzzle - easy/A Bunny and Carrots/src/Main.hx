import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final inputs = readline().split(" ");
	final m = parseInt( inputs[0] );
	final n = parseInt( inputs[1] );
	final t = parseInt( readline() );
	final inputs = readline().split(" ");
	final choices = [for( i in 0...t ) parseInt( inputs[i] )];

	final result = process( m, n, t, choices );
	print( result );
}

function process( m:Int, n:Int, t:Int, choices:Array<Int> ) {
	
	final columns = [for( i in 0...n ) m];
	final garden = new Garden( columns );

	final perimeters = choices.mapi(( i, choice ) -> {
		garden.removeCarrot( choices[i] );
		return garden.getPerimeter();
	});

	return perimeters.join( "\n" );
}
