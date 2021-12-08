package simAI;

import TestCases.TestCase;
import ga.Gene;
import simAI.ai.AI1;
import simAI.ai.AI;
import simAI.ai.TutorialAI1;
import simAI.ai.TutorialAI2;
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

		
		final tutorialAI1 = new TutorialAI1( new Agent( testCase, surfaceCoords, maxFrames ), surfaceCoords );
		final tutorialAI2 = new TutorialAI2( new Agent( testCase, surfaceCoords, maxFrames ), surfaceCoords );
		final ai1 = new AI1( new Agent( testCase, surfaceCoords, maxFrames ), surfaceCoords );
		final ais = [tutorialAI2, tutorialAI1, ai1];
		
		final genePools:Array<Array<Gene>> = [for( _ in 0...ais.length ) [for( i in 0...maxFrames ) { rotate: 0, power: 0}]];
		final agents = ais.map( ai -> ai.agent );

		return new AICollection( ais, genePools, agents );
	}

	public function resetAgents() for( agent in simAgents ) agent.reset();

	public function run( currentFrame:Int ) {
		for( i in 0...ais.length ) {
			final gene = genePool[i][currentFrame];
			final agent = simAgents[i];
			if( !agent.isFinished ) {
				final ai = ais[i];
				final nextGene = ai.process();
				agent.update( nextGene.rotate, nextGene.power );
				
				gene.rotate = nextGene.rotate;
				gene.power = nextGene.power;
				
				agent.checkFinishedPlay();
			}
		}
	}

}