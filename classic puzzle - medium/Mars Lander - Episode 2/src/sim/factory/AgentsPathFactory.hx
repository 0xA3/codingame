package sim.factory;

import haxe.ds.Vector;
import sim.data.Position;

class AgentsPathFactory {
	
	public static function create( numChromosomes:Int, numGenes:Int ) {
		final agentsPaths = new Vector<Vector<Position>>( numChromosomes );
		for( i in 0...agentsPaths.length ) {
			final positions = new Vector<Position>( numGenes );
			for( o in 0...numGenes ) positions[o] = new Position( 0, 0 );
			agentsPaths[i] = positions;
		}
		return agentsPaths;
	}
}