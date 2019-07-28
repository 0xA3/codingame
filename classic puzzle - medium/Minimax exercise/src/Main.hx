using Lambda;

class Main {
	
	static function main() {

		final inputs = CodinGame.readline().split(' ');
		final d = Std.parseInt( inputs[0] );
		final b = Std.parseInt( inputs[1] );
		final leafs = CodinGame.readline().split(' ').map( s -> Std.parseInt( s ));

		CodinGame.printErr( 'inputs: $inputs' );
		CodinGame.printErr( 'd: $d' );
		CodinGame.printErr( 'b: $b' );
		CodinGame.printErr( 'leafs: $leafs' );

		final miniMax = new MiniMax( d, b, leafs );
		final result = miniMax.evaluate();
		CodinGame.print( '$result ${miniMax.visitedNodesQuantity}' );
	}

}
