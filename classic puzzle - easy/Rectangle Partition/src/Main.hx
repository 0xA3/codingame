using Lambda;
using com.hexA3.ArrayUtils;

class Main {
	
	static function main() {
		
		final inputs = CodinGame.readline().split(' ');
		final w = Std.parseInt(inputs[0]);
		final h = Std.parseInt(inputs[1]);
		final countX = Std.parseInt(inputs[2]);
		final countY = Std.parseInt(inputs[3]);
		final xInputs = CodinGame.readline().split(' ');
		final yInputs = CodinGame.readline().split(' ');
		
		final xMeasurements = xInputs.map( s -> Std.parseInt( s ));
		xMeasurements.push( w );
		final yMeasurements = yInputs.map( s -> Std.parseInt( s ));
		yMeasurements.push( h );

		final xPartitions = getPartitions( xMeasurements );
		final yPartitions = getPartitions( yMeasurements );

		final quads = getQuadCount( xPartitions, yPartitions );

		CodinGame.print( quads );

	}

	static function getPartitions( measurements:Array<Int>) {
		
		final zm = [0].concat( measurements );
		final partitions:Array<Int> = [];
		for( i in 0...zm.length - 1 ) {
			final a = zm[i];
			for( o in i+1...zm.length ) {
				final b = zm[o];
				// trace( '$b - $a = ${b - a}' );
				partitions.push( b - a );
			}
		}
		return partitions;
	}

	static function getQuadCount( xPartitions:Array<Int>, yPartitions:Array<Int> ) {
		
		var count = 0;
		for( x in xPartitions ) {
			for( y in yPartitions ) {
				// trace( 'x:$x y:$y == ${x == y}' );
				if( x == y ) count++;
			}
		}
		return count;
	}
		
}