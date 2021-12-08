package simGA.factory;

import simGA.data.AgentPath;
import simGA.data.Position;

class AgentsPathFactory {
	
	public static function create( numChromosomes:Int, numGenes:Int, color:Int ) {
		final agentsPaths:Array<AgentPath> = [];
		for( i in 0...numChromosomes ) {
			final positions = [];
			for( o in 0...numGenes ) positions[o] = new Position( 0, 0 );
			agentsPaths[i] = { color: color, positions: positions };
		}
		return agentsPaths;
	}
}