package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import ai.IAi;
import ai.data.ArcheryDataset;
import ai.data.ArcheryInputDataset;
import ai.data.Constants.D;
import ai.data.Constants.L;
import ai.data.Constants.NUM_PLAYERS;
import ai.data.Constants.R;
import ai.data.Constants.U;
import ai.data.Constants.direction;
import ai.data.DivingDataset;
import ai.data.DivingInputDataset;
import ai.data.HurdleDataset;
import ai.data.HurdleInputDataset;
import ai.data.Node;
import ai.data.NodePool;
import ai.data.RegisterDataset;
import ai.data.ScoreInfo;
import ai.data.SkatingDataset;
import ai.data.SkatingInputDataset;
import haxe.Timer;
import sim.ArcherGame;
import sim.DivingGame;
import sim.HurdleGame;
import sim.SkatingGame;
import xa3.MathUtils.dist2;

using Lambda;
using xa3.ArrayUtils;

class AiSearch implements IAi {
	
	public var aiId = "AiSearchs";

	var playerIdx:Int;
	var nbGames:Int;
	final scoreInfos:Array<ScoreInfo> = [];
	final hurdleInputDataset = new HurdleInputDataset();
	final archeryInputDataset = new ArcheryInputDataset();
	final skatingInputDataset = new SkatingInputDataset();
	final divingInputDataset = new DivingInputDataset();

	final actions = [U, L, D, R];
	final nodePool = new NodePool();
	final root = new Node();
	final rootHurdleDataset:HurdleDataset;
	final rootArcheryDataset:ArcheryDataset;
	final rootSkatingDataset:SkatingDataset;
	final rootDivingDataset:DivingDataset;
	final nodes:Array<Node> = [];
	final valuations = [for( _ in 0...4 ) { action: "", sum: 0.0 }];
	final hurdleValuations = [0, 0, 0, 0];
	final archeryValuations = [0, 0, 0, 0];
	final skatingValuations = [0, 0, 0, 0];
	final divingValuations = [0, 0, 0, 0];

	final scoreWeights = [1.0, 1.0, 1.0, 1.0];

	var startTime:Float;
	var turn = 1;

	public function new() {
		rootHurdleDataset = root.hurdleDataset;
		rootArcheryDataset = root.archeryDataset;
		rootSkatingDataset = root.skatingDataset;
		rootDivingDataset = root.divingDataset;
	}
	
	public function setGlobalInputs( playerIdx:Int, nbGames:Int ) {
		this.playerIdx = playerIdx;
		this.nbGames = nbGames;
		for( _ in 0...NUM_PLAYERS ) scoreInfos.push( new ScoreInfo() );
		turn = 1;
	}
	
	public function setInputs( scoreInfoStrings:Array<String>, registerDatasets:Array<RegisterDataset>	) {
		startTime = Timer.stamp();
		
		for( i in 0...NUM_PLAYERS ) scoreInfos[i].set( scoreInfoStrings[i] );

		hurdleInputDataset.set( registerDatasets[0] );
		archeryInputDataset.set( registerDatasets[1] );
		skatingInputDataset.set( registerDatasets[2] );
		divingInputDataset.set( registerDatasets[3] );

		rootHurdleDataset.copyFrom( hurdleInputDataset.playerDatasets[playerIdx] );
		rootArcheryDataset.copyFrom( archeryInputDataset.playerDatasets[playerIdx] );
		rootSkatingDataset.copyFrom( skatingInputDataset.playerDatasets[playerIdx] );
		rootDivingDataset.copyFrom( divingInputDataset.playerDatasets[playerIdx] );
	}

	public function process() {
		nodePool.reset();

		final actionSequence = searchSequence();

		turn++;
		
		final nextAction = actionSequence[actionSequence.length - 1];
		return direction[nextAction];
	}

	function searchSequence() {
		final frontier = new List<Node>();
		frontier.add( root );

		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			
			if( current.depth > 0 ) {
				frontier.push( current );
				break;
			}

			for( action in actions ) {
				final next = nodePool.get();
				next.parent = current;
				next.depth = current.depth + 1;
				
				next.action = action;
				HurdleGame.process( action, current.hurdleDataset, next.hurdleDataset, hurdleInputDataset.racetrack );
				ArcherGame.process( action, current.archeryDataset, next.archeryDataset, archeryInputDataset.winds[0] );
				SkatingGame.process( action, current.skatingDataset, next.skatingDataset, skatingInputDataset.risks, skatingInputDataset.turnsLeft );
				DivingGame.process( action, current.divingDataset, next.divingDataset, divingInputDataset.divingGoal[0] );

				frontier.add( next );
			}
		}
		printErr( 'frontier length: ${frontier.length}' );
		// for( node in frontier ) {
		// 	printErr( '${node.action} ${node.hurdleDataset.position} ${node.archeryDataset.position} ${node.skatingDataset.spacesTravelled} ${node.divingDataset.points}' );
		// }

		printErr( 'Time ${Timer.stamp() - startTime}' );

		return ["L"];
	}
}
