import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

typedef Vector = {
	final name:String;
	final components:Array<Int>;
}

function main() {
	final d = parseInt( readline() );
	final n = parseInt( readline() );
	final points = [for( _ in 0...n ) readline()];

	final result = process( points );
	print( result );
}

function process( points:Array<String> ) {
	final vectors = points.map( s -> parse( s ));
	final distanceDifferences = [];
	for( i1 in 0...vectors.length - 1 ) {
		for( i2 in i1 + 1...vectors.length ) {
			final v1 = vectors[i1];
			final v2 = vectors[i2];
			final distance = getDistance( v1, v2 );
			final difference = getDifference( v1, v2 );
			distanceDifferences.push({ distance:distance, difference: difference });
		}
	}
	distanceDifferences.sort(( a, b ) -> {
		if( a.distance < b.distance ) return -1;
		if( a.distance > b.distance ) return 1;
		return 0;
	});

	final outputs = distanceDifferences.map( dd -> '${dd.difference.name}(' + dd.difference.components.join(",") + ")" );

	return [outputs[0], outputs[outputs.length - 1]].join( "\n" );
}

function parse( s:String ) {
	final parts = s.split( "(" );
	final name = parts[0];
	final components = parts[1].substring( 0, parts[1].length - 1 ).split( "," ).map( s -> parseInt( s ));
	final vector:Vector = { name: name, components: components }

	return vector;
}

function getDistance( v1:Vector, v2:Vector ) {
	if( v1.components.length != v2.components.length ) throw 'Error: different amount of components in $v1 and v2';
	
	var sum = [for( i in 0...v1.components.length ) Math.pow( v2.components[i] - v1.components[i], 2 )]
	.fold(( v, sum ) -> sum + v, 0.0 );
	
	return Math.sqrt( sum );
}

function getDifference( v1:Vector, v2:Vector ) {
	final name = v1.name + v2.name;
	final components = v1.components.mapi(( i, _ ) -> v2.components[i] - v1.components[i] );

	final difference:Vector = { name: name, components: components }

	return difference;
}
