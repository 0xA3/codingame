package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import ai.IAi;
import ai.contexts.GetBestHurdleActions;
import ai.contexts.GetWorstHurdleActions;
import ai.data.ArcheryDataset;
import ai.data.ArcheryInputDataset;
import ai.data.Constants.D;
import ai.data.Constants.HURDLE;
import ai.data.Constants.L;
import ai.data.Constants.NUM_PLAYERS;
import ai.data.Constants.R;
import ai.data.Constants.U;
import ai.data.Constants.direction;
import ai.data.Constants;
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
using xa3.ArrayUtils;
using xa3.MathUtils;

class Ai6 implements IAi {
	
	public var aiId = "Ai6";

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
		
		rootHurdleDataset.copyFrom( hurdleInputDataset.playerDatasets[playerIdx] );
		rootArcheryDataset.copyFrom( archeryInputDataset.playerDatasets[playerIdx] );
		rootSkatingDataset.copyFrom( skatingInputDataset.playerDatasets[playerIdx] );
		rootDivingDataset.copyFrom( divingInputDataset.playerDatasets[playerIdx] );
	}

	public function process() {
		nodePool.reset();
		nodes.splice( 0, nodes.length );

		// printErr( '        U L D R' );
		for( action in actions ) {
			final next = nodePool.get();
			nodes.push( next );

			next.action = action;
			HurdleGame.process( action, rootHurdleDataset, next.hurdleDataset, hurdleInputDataset.racetrack );
			ArcherGame.process( action, rootArcheryDataset, next.archeryDataset, archeryInputDataset.winds[0] );
			SkatingGame.process( action, rootSkatingDataset, next.skatingDataset, skatingInputDataset.risks, skatingInputDataset.turnsLeft );
			DivingGame.process( action, rootDivingDataset, next.divingDataset, divingInputDataset.divingGoal[0] );
		}

		final gameScores = [for( i in 0...Constants.id2Game.length ) scoreInfos[playerIdx].getMinigameScore( i )];
		final maxScore = gameScores.max();
		if( maxScore > 0 ) for( i in 0...4 ) scoreWeights[i] = maxScore / ( gameScores[i] + 1 );
		
		// final output = [for( i in 0...4 ) '${Constants.id2Game[i]} s: ${gameScores[i]} w: ${scoreWeights[i]}'].join( ", " );
		// printErr( output );
		getHurdleOdds();
		
		final valuations = evaluate( nodes, scoreWeights );
		
		// final output = [for( valuation in valuations ) '${valuation.sum}'].join(" ");
		// printErr( 'Sum     $output' );
		
		ArraySort.sort( valuations, ( a, b ) -> {
			if( b.sum < a.sum ) return -1;
			if( b.sum > a.sum ) return 1;
			return 0;
		});

		final bestAction = valuations[0].action;
		turn++;
		
		return direction[bestAction];
	}

	function getVisualRacetrack( racetrack:Array<String>, position:Int ) {
		final copy = racetrack.copy();
		copy[position] = '@';

		return copy.join( "" ) ;
	}

	function getHurdleOdds() {
		// final bestHurdleActions = hurdleInputDataset.playerDatasets.map( playerDataset -> GetBestHurdleActions.get( playerDataset, hurdleInputDataset.racetrack ));
		// final worstHurdleActions = hurdleInputDataset.playerDatasets.map( playerDataset -> GetWorstHurdleActions.get( playerDataset, hurdleInputDataset.racetrack ));

		// final myBestHurdleActions = bestHurdleActions[playerIdx].length;
		// final myWorstHurdleActions = worstHurdleActions[playerIdx].length;

		// final othersBestHurdleActions = [for( i in 0...bestHurdleActions.length ) if( i != playerIdx ) bestHurdleActions[i]];
		// final othersWorstHurdleActions = [for( i in 0...worstHurdleActions.length ) if( i != playerIdx ) worstHurdleActions[i]];

		// final othersShortestBestHurdleActions = othersBestHurdleActions.map( actions -> actions.length ).min();
		// final othersLongestBestHurdleActions = othersBestHurdleActions.map( actions -> actions.length ).max();
		// final othersShortestWorstHurdleActions = othersWorstHurdleActions.map( actions -> actions.length ).min();
		// final othersLongestWorstHurdleActions = othersWorstHurdleActions.map( actions -> actions.length ).max();

		// printErr( 'my range ${myBestHurdleActions} - ${myWorstHurdleActions}' );

		// printErr( 'others $othersShortestBestHurdleActions - $othersShortestWorstHurdleActions' );
		// if( myBestHurdleActions > othersShortestWorstHurdleActions ) return 0;

		/*

		other player 1  (player_id + 1)%3
		other player 2  (player_id + 2)%3

		*/

		final otherPositions = [for( i in 0...hurdleInputDataset.playerDatasets.length ) if( i != playerIdx ) hurdleInputDataset.playerDatasets[i].position];
		final bestOtherPosition = otherPositions.max();
		final myLead = rootHurdleDataset.position - bestOtherPosition;
		printErr( 'myLead $myLead' );

		return 1;
	}

	function checkIgnoreHurdle() {
		final myPosition = rootHurdleDataset.position;
		final otherPositions = [for( i in 0...hurdleInputDataset.playerDatasets.length ) if( i != playerIdx ) hurdleInputDataset.playerDatasets[i].position];
		final distanceToOtherPlayers = otherPositions.map( p -> myPosition - p );
		final distance1 = distanceToOtherPlayers.min();
		final distance2 = distanceToOtherPlayers.max();
		final lastHurdlePosition = hurdleInputDataset.racetrack.lastIndexOf( HURDLE );
		final isAfterLastHurdle = myPosition > lastHurdlePosition;
		final distanceToGoal = hurdleInputDataset.racetrack.length - myPosition;

		printErr( 'myPosition: ${myPosition} distance1: ${distance1} distance2: ${distance2} lastHurdlePosition: ${lastHurdlePosition} isAfterLastHurdle: ${isAfterLastHurdle} distanceToGoal: ${distanceToGoal}' );
	}

	//             U  L  D  R
	// hurdle  ->  1  0  0  2
	// archery ->  0  0  1  1
	// skating ->  0  1  0 -1
	// diving  ->  0  3  0  0
	//           + ==========
	// 			   1  4  1  2

	function evaluate( nodes:Array<Node>, scoreWeights:Array<Float> ) {
		final hurdleEvaluations = evaluateHurdleActions( nodes ).map( v -> v * scoreWeights[0] );
		final archeryEvaluations = evaluateArcheryActions( nodes ).map( v -> v * scoreWeights[1] );
		final skatingEvaluations = evaluateSkatingActions( nodes ).map( v -> v * scoreWeights[2] );
		final divingEvaluations = evaluateDivingActions( nodes ).map( v -> v * scoreWeights[3] );

		// final hurdleOutput = [for( i in 0...nodes.length ) '${hurdleEvaluations[i]}'].join(" ");
		// printErr( 'Hurdle  $hurdleOutput' );
		// final archeryOutput = [for( i in 0...nodes.length ) '${archeryEvaluations[i]}'].join(" ");
		// printErr( 'Archery $archeryOutput' );
		// final skatingOutput = [for( i in 0...nodes.length ) '${skatingEvaluations[i]}'].join(" ");
		// printErr( 'Skating $skatingOutput' );
		// final divingOutput = [for( i in 0...nodes.length ) '${divingEvaluations[i]}'].join(" ");
		// printErr( 'Diving  $divingOutput' );

		for( i in 0...nodes.length ) {
			valuations[i].action = nodes[i].action;
			valuations[i].sum = hurdleEvaluations[i] + archeryEvaluations[i] + skatingEvaluations[i] + divingEvaluations[i];
		}

		return valuations;
	}

	function evaluateHurdleActions( nodes:Array<Node> ) {
		if( rootHurdleDataset.stunTimer == 0 ) {
			final previousPosition = rootHurdleDataset.position;
			for( i in 0...nodes.length ) {
				final hurdleDataset = nodes[i].hurdleDataset;
				if( hurdleDataset.stunTimer > 0 ) {
					hurdleValuations[i] = -2;
				} else {
					hurdleValuations[i] = hurdleDataset.position - previousPosition;
				}
			}
		}

		return hurdleValuations;
	}

	function evaluateArcheryActions( nodes:Array<Node> ) {
		final previousDist = dist2( 0, 0, rootArcheryDataset.position.x, rootArcheryDataset.position.y );
		// [U, L, D, R]
		final nextDists = [for( i in 0...nodes.length ) dist2( 0, 0, nodes[i].archeryDataset.position.x, nodes[i].archeryDataset.position.y )];
		for( i in 0...nextDists.length ) archeryValuations[i] = nextDists[i] < previousDist ? 1 : 0;
		
		return archeryValuations;
	}

	function evaluateSkatingActions( nodes:Array<Node> ) {
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
		
		return skatingValuations;
	}

	function evaluateDivingActions( nodes:Array<Node> ) {
		final previousPoints = rootDivingDataset.points;
		for( i in 0...nodes.length ) divingValuations[i] = nodes[i].divingDataset.points > previousPoints ? 4 : 0;

		return divingValuations;
	}
}
