import haxe.ds.ArraySort;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using ArrayUtils;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final rooms = [for( i in 0...n ) readline()];
				
		final result = process2( rooms );
		print( result );
	}

	// solution with UniformCostSearch and priority queue
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

	// simple solution without priority queue
	static function process2( incomingRooms:Array<String> ) {
		final rooms:Array<Room> = [for( i in 0...incomingRooms.length) { money: 0, parents: [] }];
		var max = 0;
		for( i in 0...incomingRooms.length ) {
			final a = incomingRooms[i].split(" ").map( s -> parseInt( s ));
			final parentsMaxMoney = rooms[i].parents.map( room -> room.money ).max();
			rooms[i].money = parentsMaxMoney;
			if( max < parentsMaxMoney ) max = parentsMaxMoney;
			if( a[2] != null ) rooms[a[2]].parents.push( rooms[i] );
			if( a[3] != null ) rooms[a[3]].parents.push( rooms[i] );
		}

		return max;
	}

}

typedef Room = {
	var money:Int;
	final parents:Array<Room>;
}