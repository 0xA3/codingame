import haxe.ds.ArraySort;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final rooms = [for( i in 0...n ) readline()];
				
		final result = process( rooms );
		print( result );
	}

	static function process( rooms:Array<String> ) {
		
		final nodes = rooms.map( s -> {
			final a = s.split(" ");
			final id = parseInt( a[0] );
			final money = parseInt( a[1] );
			final neighbors = [];
			if( a[2] != "E" ) neighbors.push( parseInt( a[2] ));
			if( a[3] != "E" ) neighbors.push( parseInt( a[3] ));
			return new PathNode( id, money, neighbors );
		});

		final goals = UniformCostSearch.getGoals( nodes, 0 );
		
		if( goals.length == 0 ) throw "Error: No goals found.";
		goals.sort(( a, b ) -> {
			if( a.moneyFromStart > b.moneyFromStart ) return -1;
			if( a.moneyFromStart < b.moneyFromStart ) return 1;
			return 0;
		});
		return goals[0].moneyFromStart;
	}


}
