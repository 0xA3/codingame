package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import ai.IAi;
import ai.data.ArcheryDataset;
import ai.data.ArcheryInputDataset;
import ai.data.Constants.D;
import ai.data.Constants.L;
import ai.data.Constants.LEFT;
import ai.data.Constants.NUM_PLAYERS;
import ai.data.Constants.R;
import ai.data.Constants.U;
import ai.data.Constants.directionMap;
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

class Ai3 implements IAi {
	
	public var aiId = "Ai3";

	var playerIdx:Int;
	var nbGames:Int;
	final scoreInfos:Array<ScoreInfo> = [];
	final hurdleInputDataset = new HurdleInputDataset();
	final archeryInputDataset = new ArcheryInputDataset();
	final skatingInputDataset = new SkatingInputDataset();
	final divingInputDataset = new DivingInputDataset();

	final actions = [L, D, U, R];
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
			nodePool.dispose( node );
		}
		/*
		final frontier = new List<Node>();
		frontier.add( root );

		while( !frontier.isEmpty()) {
			final current = frontier.pop();
			if( current.playerDataset.hurdlePosition == hurdleDataset.racetrack.length ) {

			}
		*/
		for( action in actions ) {
			final next = nodePool.get();
			nodes.push( next );

			next.action = action;
			HurdleGame.process( action, rootHurdleDataset, next.hurdleDataset, hurdleInputDataset.racetrack );
			ArcherGame.process( action, rootArcheryDataset, next.archeryDataset, archeryInputDataset.winds[0] );
			SkatingGame.process( action, rootSkatingDataset, next.skatingDataset, skatingInputDataset.risks, skatingInputDataset.turnsLeft );
			DivingGame.process( action, rootDivingDataset, next.divingDataset, divingInputDataset.divingGoal[0] );
			// next.parent = current;
		}

		// printErr( getVisualRacetrack( hurdleInputDataset.racetrack, rootHurdleDataset.position ) );
		// printErr( 'inputPos ${rootArcheryDataset.position}  wind ${archeryInputDataset.winds[0]}' );
		// printErr( 'spacesTravelled: ${rootSkatingDataset.spacesTravelled}  riskOrStun: ${rootSkatingDataset.riskOrStun}  risks ${skatingInputDataset.risks}' );
		// printErr( '${divingInputDataset.divingGoal.join( "" )} points: ${rootDivingDataset.points}  combos: ${rootDivingDataset.combos}' );
		for( node in nodes ) {
			// final hurdleDataset = node.hurdleDataset;
			// printErr( '${node.action} ${getVisualRacetrack( hurdleInputDataset.racetrack, hurdleDataset.position )}  position: ${hurdleDataset.position}  stun: ${hurdleDataset.stunTimer}' );
			// printErr( '${node.action} ${node.archeryDataset.position}  dist ${Math.sqrt( dist2( 0, 0, node.archeryDataset.position.x, node.archeryDataset.position.y ))}' );
			// printErr( '${node.action}  spacesTravelled: ${node.skatingDataset.spacesTravelled}  riskOrStun: ${node.skatingDataset.riskOrStun}' );
			// printErr( '${node.action}  points: ${node.divingDataset.points}  combos: ${node.divingDataset.combos}' );
		}

		final gameScores = [for( i in 0...Constants.id2Game.length ) {game: Constants.id2Game[i], score: scoreInfos[playerIdx].getMinigameScore( i ) }];
		ArraySort.sort( gameScores, ( a, b ) -> a.score - b.score );

		turn++;
		
		for( gameScore in gameScores ) printErr( '${gameScore.game} ${gameScore.score}' );
		
		final gameWithLowestScore = gameScores[0].game;
		switch gameWithLowestScore {
			case Hurdle:
			ArraySort.sort( nodes, ( a, b ) -> {
				if( a.hurdleDataset.stunTimer < b.hurdleDataset.stunTimer ) return -1;
				if( a.hurdleDataset.stunTimer > b.hurdleDataset.stunTimer ) return 1;
				
				if( a.hurdleDataset.position < b.hurdleDataset.position ) return 1;
				if( a.hurdleDataset.position > b.hurdleDataset.position ) return -1;
				return 0;
			});
			
			// printErr( getVisualRacetrack( hurdleInputDataset.racetrack, rootHurdleDataset.position ) );
			// for( node in nodes ) {
			// 	final hurdleDataset = node.hurdleDataset;
			// 	printErr( '${node.action} ${getVisualRacetrack( hurdleInputDataset.racetrack, hurdleDataset.position )}  position: ${hurdleDataset.position}  stun: ${hurdleDataset.stunTimer}' );
			// }
			
			return directionMap[nodes[0].action];
			
			case Archery:
			// [L, D, U, R]
			final distLeft = dist2( 0, 0, nodes[0].archeryDataset.position.x, nodes[0].archeryDataset.position.y );
			final distDown = dist2( 0, 0, nodes[1].archeryDataset.position.x, nodes[1].archeryDataset.position.y );
			final distUp = dist2( 0, 0, nodes[2].archeryDataset.position.x, nodes[2].archeryDataset.position.y );
			final distRight = dist2( 0, 0, nodes[3].archeryDataset.position.x, nodes[3].archeryDataset.position.y );

			final dists = [
				{ action: U, dist: distUp },
				{ action: D, dist: distDown },
				{ action: L, dist: distLeft },
				{ action: R, dist: distRight }
			];
			dists.sort(( a, b ) -> a.dist - b.dist );
			
			// printErr( 'inputPos ${rootArcheryDataset.position}  wind ${archeryInputDataset.winds[0]}' );
			// for( node in nodes ) {
			// 	printErr( '${node.action} ${node.archeryDataset.position}  dist ${Math.sqrt( dist2( 0, 0, node.archeryDataset.position.x, node.archeryDataset.position.y ))}' );
			// }
			
			return directionMap[dists[0].action];
			
			case Skating:
			ArraySort.sort( nodes, ( a, b ) -> b.skatingDataset.spacesTravelled - a.skatingDataset.spacesTravelled );
			
			// printErr( 'spacesTravelled: ${rootSkatingDataset.spacesTravelled}  riskOrStun: ${rootSkatingDataset.riskOrStun}  risks ${skatingInputDataset.risks}' );
			// for( node in nodes ) {
			// 	printErr( '${node.action}  spacesTravelled: ${node.skatingDataset.spacesTravelled}  riskOrStun: ${node.skatingDataset.riskOrStun}' );
			// }
			
			return directionMap[nodes[0].action];

			case Diving:
			ArraySort.sort( nodes, ( a, b ) -> b.divingDataset.points - a.divingDataset.points );
			
			// printErr( '${divingInputDataset.divingGoal.join( "" )} points: ${rootDivingDataset.points}  combos: ${rootDivingDataset.combos}' );
			// for( node in nodes ) {
			// 	printErr( '${node.action}  points: ${node.divingDataset.points}  combos: ${node.divingDataset.combos}' );
			// }
			
			return directionMap[nodes[0].action];
		}
	}

	function getVisualRacetrack( racetrack:Array<String>, position:Int ) {
		final copy = racetrack.copy();
		copy[position] = '@';

		return copy.join( "" ) ;
	}

	public function backtrack( node:Node ) {
		final path = new List<Node>();
		
		var current = node;
		while( current.parent != Node.NO_NODE )	{
			path.add( current );
			current = current.parent;
		}

		final aPath = Lambda.array( path );
		aPath.reverse();
		
		return aPath;
	}

}
