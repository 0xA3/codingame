package simAI;

import TestCases.TestCase;
import ga.Gene;
import simAI.ai.AI1;
import simAI.ai.AI;
import simAI.ai.TutorialAI1;
import simGA.data.Agent;
import simGA.data.SurfaceCoords;

class AICollection {
	
	public final ais:Array<AI>;
	public final genePool:Array<Array<Gene>>;
	public final simAgents:Array<Agent>;

	public function new( ais:Array<AI>, genePool:Array<Array<Gene>>, simAgents:Array<Agent> ) {
		if( ais.length != genePool.length || ais.length != simAgents.length ) throw 'Error: ais length ${ais.length} must match simAgents length ${simAgents.length}';
		this.ais = ais;
		this.genePool = genePool;
		this.simAgents = simAgents;	
	}

	public static function create( testCase:TestCase, surfaceCoords:SurfaceCoords, maxFrames:Int ) {
		final simAgent = new Agent( testCase, surfaceCoords, maxFrames );
		final ai = new TutorialAI1( simAgent, surfaceCoords );
		final genePool:Array<Gene> = [for( i in 0...maxFrames ) { rotate: 0, power: 0}];
		return new AICollection( [ai], [genePool], [simAgent] );
	}

	public function resetAgents() for( agent in simAgents ) agent.reset();

	public function run( currentFrame:Int ) {
		for( i in 0...ais.length ) {
			final gene = genePool[i][currentFrame];
			final agent = simAgents[i];
			if( agent.isFinished ) {
				gene.rotate = 0;
				gene.power = 0;
			} else {
				final ai = ais[i];
				final nextGene = ai.process();
				gene.rotate = nextGene.rotate;
				gene.power = nextGene.power;

				agent.update( gene.rotate, gene.power );
				agent.checkFinishedPlay();
			}
		}
	}

}