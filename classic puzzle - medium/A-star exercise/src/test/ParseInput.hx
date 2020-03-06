package test;

import PathNode;

typedef ParsedInput = {
	final n:Int;
	final s:Int;
	final g:Int;
	final distances:Array<Int>;
	final edges:Map<Int, Array<Edge>>;
}

class ParseInput {
	
	public static function parse( s:String ) {
		final lines = s.split( "\n" );
		
		final inputs = lines[0].split(' ');
		final n = Std.parseInt( inputs[0] );
		final e = Std.parseInt( inputs[1] );
		final s = Std.parseInt( inputs[2] );
		final g = Std.parseInt( inputs[3] );

		final inputs = lines[1].split(' ');
		final distances = [for( i in 0...n ) Std.parseInt( inputs[i] )];

		final edges:Map<Int, Array<PathNode.Edge>> = [];
		for( i in 0...n ) edges.set( i, [] );
		for( i in 0...e ) {
			var inputs = lines[i + 2].split(' ');
			final x = Std.parseInt( inputs[0] );
			final y = Std.parseInt( inputs[1] );
			final c = Std.parseInt( inputs[2] );
			edges.get( x ).push({ to: y, cost:c });
			if( x != s ) edges.get( y ).push({ to: x, cost: c });
		}

		final parsedInput:ParsedInput = { n:n, s: s, g: g, distances: distances, edges:edges };
		return parsedInput;
	}
}