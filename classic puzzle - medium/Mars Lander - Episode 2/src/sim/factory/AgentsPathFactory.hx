package sim.factory;

import sim.data.Position;

class AgentsPathFactory {
	
	public static function create( numChromosomes:Int, numGenes:Int ) {
		final agentsPaths = [];
		for( i in 0...numChromosomes ) {
			final positions = [];
			for( o in 0...numGenes ) positions[o] = new Position( 0, 0 );
			agentsPaths[i] = positions;
		}
		return agentsPaths;
	}
}