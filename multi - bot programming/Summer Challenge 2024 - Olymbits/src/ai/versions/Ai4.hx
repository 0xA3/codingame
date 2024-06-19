package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import ai.IAi;
import ai.data.ArcheryDataset;
import ai.data.ArcheryInputDataset;
import ai.data.Constants.D;
import ai.data.Constants.L;
import ai.data.Constants.LEFT;
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
import haxe.ds.ArraySort;
import sim.ArcherGame;
import sim.DivingGame;
import sim.HurdleGame;
import sim.SkatingGame;
import xa3.MathUtils.dist2;

using Lambda;

class Ai4 implements IAi {
	
	public var aiId = "Ai4";

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
		for( i in 0...NUM_PLAYERS ) scoreInfos[i].set( scoreInfoStrings[i] );

		hurdleInputDataset.set( registerDatasets[0] );
		archeryInputDataset.set( registerDatasets[1] );
		skatingInputDataset.set( registerDatasets[2] );
		divingInputDataset.set( registerDatasets[3] );
		
		rootHurdleDataset.copy( hurdleInputDataset.playerDatasets[playerIdx] );
		rootArcheryDataset.copy( archeryInputDataset.playerDatasets[playerIdx] );
		rootSkatingDataset.copy( skatingInputDataset.playerDatasets[playerIdx] );
		rootDivingDataset.copy( divingInputDataset.playerDatasets[playerIdx] );
	}

	public function process() {
		
		while( nodes.length > 0 ) {
			final node = nodes.pop();
			nodePool.dump( node );
		}
		
		printErr( '        U L D R' );
		for( action in actions ) {
			final next = nodePool.get();
			nodes.push( next );

			next.action = action;
			HurdleGame.process( action, rootHurdleDataset, next.hurdleDataset, hurdleInputDataset.racetrack );
			ArcherGame.process( action, rootArcheryDataset, next.archeryDataset, archeryInputDataset.winds[0] );
			SkatingGame.process( action, rootSkatingDataset, next.skatingDataset, skatingInputDataset.risks, skatingInputDataset.turnsLeft );
			DivingGame.process( action, rootDivingDataset, next.divingDataset, divingInputDataset.divingGoal[0] );
		}

		final valuations = evaluate( nodes );
		final output = [for( valuation in valuations ) '${valuation.sum}'].join(" ");
		printErr( 'Sum     $output' );
		
		ArraySort.sort( valuations, ( a, b ) -> b.sum - a.sum );

		final bestAction = valuations[0].action;
		turn++;
		
		return direction[bestAction];
	}

	function getVisualRacetrack( racetrack:Array<String>, position:Int ) {
		final copy = racetrack.copy();
		copy[position] = '@';

		return copy.join( "" ) ;
	}

	//             U  L  D  R
	// hurdle  ->  1  0  0  2
	// archery ->  0  0  1  1
	// skating ->  0  1  0 -1
	// diving  ->  0  3  0  0
	//           + ==========
	// 			   1  4  1  2

	function evaluate( nodes:Array<Node> ) {
		
		final hurdleEvaluations = evaluateHurdleActions( nodes );
		final archeryEvaluations = evaluateArcheryActions( nodes );
		final skatingEvaluations = evaluateSkatingActions( nodes );
		final divingEvaluations = evaluateDivingActions( nodes );
		
		final valuations = [for( i in 0...nodes.length ) { action: nodes[i].action, sum: hurdleEvaluations[i] + archeryEvaluations[i] + skatingEvaluations[i] + divingEvaluations[i] }];

		return valuations;
	}

	function evaluateHurdleActions( nodes:Array<Node> ) {
		final hurdleValuations = [0, 0, 0, 0];
		
		if( rootHurdleDataset.stunTimer == 0 ) {
			final previousPosition = rootHurdleDataset.position;
			for( i in 0...nodes.length ) {
				final hurdleDataset = nodes[i].hurdleDataset;
				if( hurdleDataset.stunTimer > 0 ) {
					hurdleValuations[i] = -1;
				} else {
					hurdleValuations[i] = hurdleDataset.position - previousPosition;
				}
			}
		}

		final output = [for( i in 0...nodes.length ) '${hurdleValuations[i]}'].join(" ");
		printErr( 'Hurdle  $output' );

		return hurdleValuations;
	}

	function evaluateArcheryActions( nodes:Array<Node> ) {
		final previousDist = dist2( 0, 0, rootArcheryDataset.position.x, rootArcheryDataset.position.y );
		// [U, L, D, R]
		final nextDists = [for( i in 0...nodes.length ) dist2( 0, 0, nodes[i].archeryDataset.position.x, nodes[i].archeryDataset.position.y )];
		final archeryValuations = [for( i in 0...nextDists.length ) nextDists[i] < previousDist ? 1 : 0];
		
		final output = [for( i in 0...nodes.length ) '${archeryValuations[i]}'].join(" ");
		printErr( 'Archery $output' );

		return archeryValuations;
	}

	function evaluateSkatingActions( nodes:Array<Node> ) {
		final skatingValuations = [0, 0, 0, 0];
		
		if( rootSkatingDataset.riskOrStun >= 0 ) {
			final previousPosition = rootSkatingDataset.spacesTravelled;
			for( i in 0...nodes.length ) {
				final skatingDataset = nodes[i].skatingDataset;
				if( skatingDataset.riskOrStun < 0 ) {
					skatingValuations[i] = -1;
				} else {
					skatingValuations[i] = Math.round(( skatingDataset.spacesTravelled - previousPosition ) / 2 );
				}
			}
		}
		
		final output = [for( i in 0...nodes.length ) '${skatingValuations[i]}'].join(" ");
		printErr( 'Skating $output' );

		return skatingValuations;
	}

	function evaluateDivingActions( nodes:Array<Node> ) {
		final previousPoints = rootDivingDataset.points;
		final divingValuations = [for( i in 0...nodes.length ) nodes[i].divingDataset.points > previousPoints ? 4 : 0];

		final output = [for( i in 0...nodes.length ) '${divingValuations[i]}'].join(" ");
		printErr( 'Diving  $output' );
		
		return divingValuations;
	}
}
