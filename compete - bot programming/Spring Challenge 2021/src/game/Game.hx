package game;

import Math.floor;
import Math.max;
import Math.min;
import Std.int;
import Std.string;
import game.action.Action;
import game.exception.AlreadyActivatedTree;
import game.exception.CellNotEmptyException;
import game.exception.CellNotFoundException;
import game.exception.CellNotValidException;
import game.exception.GameException;
import game.exception.NotEnoughSunException;
import game.exception.NotOwnerOfTreeException;
import game.exception.TreeAlreadyTallException;
import game.exception.TreeIsSeedException;
import game.exception.TreeNotFoundException;
import game.exception.TreeNotTallException;
import game.exception.TreeTooFarException;
import gameengine.core.GameManager;
import xa3.ArrayUtils;
import xa3.MTRandom;

using Lambda;
using xa3.MapUtils;

class Game {
	
	final gameManager:GameManager;
	final gameSummaryManager:GameSummaryManager;

	var nutrients = Config.STARTING_NUTRIENTS;

	public static var ENABLE_SEED = true;
	public static var ENABLE_GROW = true;
	public static var ENABLE_SHADOW = true;
	public static var ENABLE_HOLES = true;
	public static var MAX_ROUNDS = Config.MAX_ROUNDS;
	public static var STARTING_TREE_COUNT = 2;
	public static var STARTING_TREE_SIZE = Constants.TREE_SMALL;
	public static var STARTING_TREE_DISTANCE = 2;
	public static var STARTING_TREES_ON_EDGES = true;

	public var board:Board;
	var trees:Map<Int, Tree> = [];
	var dyingTrees:Array<CubeCoord> = [];
	var availableSun:Array<Int> = [];
	var sentSeeds:Array<Seed> = [];
	var sun = new Sun();
	var shadows:Map<Int, Int> = [];
	var cells:Array<Cell> = [];
	var round = 0;
	var turn = 0;
	public var currentFrameType = FrameType.INIT;
	var nextFrameType = FrameType.GATHERING;

	public function new( gameManager:GameManager, gameSummaryManager:GameSummaryManager ) {
		this.gameManager = gameManager;
		this.gameSummaryManager = gameSummaryManager;
	}

	public function init( seed:Int ) {
		MTRandom.initializeRandGenerator( seed );
		board = BoardGenerator.generate();
		initStartingTrees();

		if( ENABLE_SHADOW ) calculateShadows();
	}

	public static function getExpected() {
		if( !ENABLE_GROW && !ENABLE_SEED ) {
			return "COMPLETE <idx> | WAIT";
		}
		if( !ENABLE_SEED && ENABLE_GROW) {
			return "GROW <idx> | COMPLETE <idx> | WAIT";
		}
		return "SEED <from> <to> | GROW <idx> | COMPLETE <idx> | WAIT";
	}

	function getCoordByIndex( index:Int ) {
		for( coord => cell in board.map ) if( cell.index == index ) return coord;
		throw new CellNotFoundException( index );
	}

	function initStartingTrees() {
		
		final startingCoords1 = STARTING_TREES_ON_EDGES ? getBoardEdges() : board.coords;
		final startingCoords2 = startingCoords1.filter( coord -> coord.x != 0 || coord.y != 0 || coord.z == 0 );
		final startingCoords = startingCoords2.filter( coord -> board.map[coord].richness != Constants.RICHNESS_NULL );
		
		var validCoords:Array<CubeCoord> = [];
		while( validCoords.length < STARTING_TREE_COUNT * 2 ) {
			validCoords = tryInitStartingTrees( startingCoords );
		}
		
		
		for( i in 0...STARTING_TREE_COUNT ) {
			placeTree( gameManager.players[0], board.map[validCoords[2 * i]].index, STARTING_TREE_SIZE );
			placeTree( gameManager.players[1], board.map[validCoords[2 * i + 1]].index, STARTING_TREE_SIZE );
		}

	}

	function tryInitStartingTrees( startingCoords:Array<CubeCoord> ) {
		final coordinates:Array<CubeCoord> = [];
		
		var availableCoords = startingCoords.copy();
		for( _ in 0...STARTING_TREE_COUNT ) {
			if( availableCoords.length == 0 ) return coordinates;
			
			final r = MTRandom.quickIntRand( availableCoords.length );
			final normalCoord = availableCoords[r];
			final oppositeCoord = normalCoord.getOppositeFromArray( availableCoords );

			availableCoords = availableCoords.filter( coord ->
				coord.distanceTo( normalCoord ) <= STARTING_TREE_DISTANCE ||
				coord.distanceTo( oppositeCoord ) <= STARTING_TREE_DISTANCE );

			coordinates.push( normalCoord );
			coordinates.push( oppositeCoord );

		}
		
		return coordinates;
	}

	function calculateShadows() {
		shadows.clear();
		for( index => tree in trees ) {
			final coord = board.coords[index];
			for( i in 1...tree.size ) {
				final tempCoord = coord.neighbor( sun.orientation, i );
				if( board.map.exists( tempCoord )) {
					shadows.compute( board.map[tempCoord].index, ( key:Int, value:Null<Int> ) -> value == null ? tree.size : int( max( value, tree.size )));
				}
			}
		}
	}

	function getBoardEdges() {
		final centre = new CubeCoord( 0, 0, 0 );
		final coords = board.coords.filter( coord -> coord.distanceTo( centre ) == Config.MAP_RING_COUNT );

		return coords;
	}

	public function getCurrentFrameInfoFor( player:Player ) {
		final lines:Array<String> = [];
		lines.push( string( round ));
		lines.push( string( nutrients ));

		//Player information, receiving player first
		final other = gameManager.players[1 - player.index];
		lines.push( '${player.sun} ${player.score}' );
		lines.push( '${other.sun} ${other.score} ${other.isWaiting ? 1 : 0}' );
		lines.push( string( trees.size ));
		for( index => tree in trees ) lines.push( '$index ${tree.size} ${tree.owner == player ? 1 : 0} ${tree.isDormant ? 1 : 0}' );

		final possibleMoves = getPossibleMoves( player );
		lines.push( string( possibleMoves.length ));
		
		return lines;
	}

	public function getCurrentFrameDatasetFor( player:Player ) {
		final other = gameManager.players[2 - player.index];
		return {
			day: round,
			nutrients: nutrients,
			myInputs: [ string( player.sun ), string( player.score )],
			otherInputs: [ string( other.sun), string( other.score ), string( other.isWaiting ? 1 : 0 )],
			treesInputs: [for( index => tree in trees ) [string( index ), string( tree.size ), string( tree.owner == player ? 1 : 0 ), string( tree.isDormant ? 1 : 0 )]],
			possibleActions: getPossibleMoves( player )
		}
	}

	function cubeAdd( a:CubeCoord, b:CubeCoord ) return new CubeCoord( a.x + b.x, a.y + b.y, a.z + b.z );
	
	function getCoordsInRange( center:CubeCoord, n:Int ) {
		final results:Array<CubeCoord> = [];
		for( x in -n...n ) {
			for( y in int( max( -n, -x -n ))...int( min( n, -x + n ))) {
				final z = -x - y;
				results.push( cubeAdd( center, new CubeCoord( x, y, z )));
			}
		}
		return results;
	}

	function getPossibleMoves( player:Player ) {
		final lines:Array<String> = ["WAIT"];

		if( player.isWaiting ) return lines;

		final possibleSeeds:Array<String> = [];
		final possibleGrows:Array<String> = [];
		final possibleCompletes:Array<String> = [];

		// For each tree, where they can seed.
		// For each tree, if they can grow.
		final seedCost = getSeedCost( player );
		final playerTrees:Map<Int, Tree> = [];
		for( index => tree in trees ) if( tree.owner == player ) playerTrees.set( index, tree );
		for( index => tree in playerTrees ) {
			final coord = board.coords[index];

			if( playerCanSeedFrom( player, tree, seedCost )) {
				for( targetCoord in getCoordsInRange( coord, tree.size )) {
					final targetCell = board.map.getOrDefault( targetCoord, Cell.NoCell );
					if( playerCanSeedTo( targetCell, player )) {
						possibleSeeds.push( '$index ${targetCell.index}' );
					}
				}
			}

			final growCost  = getGrowthCost( tree );
			if( growCost <= player.sun  && !tree.isDormant ) {
				if( tree.size == Constants.TREE_TALL ) {
					possibleCompletes.push( 'COMPLETE $index' );
				} else if( ENABLE_GROW ) {
					possibleGrows.push( 'GROW $index' );
				}
			}
		}
		// trace( 'player ${player.index} possible seeds ' + possibleSeeds );
		// trace( 'player ${player.index} possible grows ' + possibleGrows );
		// trace( 'player ${player.index} possible completes ' + possibleCompletes );
		return [lines, possibleSeeds, possibleGrows, possibleCompletes].flatten();
	}

	inline function playerCanSeedFrom( player:Player, tree:Tree, seedCost:Int ) {
		return	ENABLE_SEED &&
				seedCost <= player.sun &&
				tree.size > Constants.TREE_SEED &&
				!tree.isDormant;
	}

	inline function playerCanSeedTo( targetCell:Cell, player:Player ) {
		return 	targetCell.isValid &&
				targetCell.richness != Constants.RICHNESS_NULL &&
				!trees.exists( targetCell.index );
	}

	public function getGlobalInfoFor( player:Player ) {
		final lines:Array<String> = [];
		lines.push( string( board.coords.length ));
		for( coord in board.coords ) {
			final cell = board.map[coord];
			lines.push( '${cell.index} ${cell.richness} ${getNeighborIds( coord )}');
		}

		return lines;
	}

	function getNeighborIds( coord:CubeCoord ) {
		final orderedNeighborIds:Array<Int> = [];
		for( i in 0...CubeCoord.directions.length ) { // TODO test this -java uses ++i
			orderedNeighborIds.push( board.map.getOrDefault( coord.neighbor( i ), Cell.NoCell ).index );
		}
		return orderedNeighborIds;
	}

	public function resetGameTurnData() {
		dyingTrees.splice( 0, dyingTrees.length );
		availableSun.splice( 0, availableSun.length );
		sentSeeds.splice( 0, sentSeeds.length );
		for( p in gameManager.players ) {
			availableSun[p.index] = p.sun;
			p.reset();
		}
		currentFrameType = nextFrameType;
	}

	function getGrowthCost( targetTree:Tree ) {
		final targetSize = targetTree.size + 1;
		return targetSize > Constants.TREE_TALL ? Constants.LIFECYCLE_END_COST : getCostFor( targetSize, targetTree.owner );
	}

	function getSeedCost( player:Player ) return getCostFor( 0, player );
	
	function doGrow( player:Player, action:Action ) {
		final coord = getCoordByIndex( action.targetId );
		final cell = board.map.get( coord );
		final targetTree = trees[cell.index];
		if( targetTree == null ) throw new TreeNotFoundException( cell.index );
		if( targetTree.owner != player ) throw new NotOwnerOfTreeException( cell.index, targetTree.owner );
		if( targetTree.isDormant ) throw new AlreadyActivatedTree( cell.index );
		if( targetTree.size >= Constants.TREE_TALL ) throw new TreeAlreadyTallException( cell.index );
		
		final costOfGrowth = getGrowthCost( targetTree );
		final currentSun = availableSun[player.index];
		// trace( 'targetTree $targetTree cost $costOfGrowth sun $currentSun' );
		if( currentSun < costOfGrowth ) throw new NotEnoughSunException( costOfGrowth, player.sun );
		
		availableSun[player.index] = currentSun - costOfGrowth;


		targetTree.grow();
		gameSummaryManager.addGrowTree( player, cell );

		targetTree.setDormant();
	}

	function doComplete( player:Player, action:Action ) {
		final coord = getCoordByIndex( action.targetId );
		final cell = board.map.get( coord );
		final targetTree = trees[cell.index];
		if( targetTree == null) throw new TreeNotFoundException( cell.index );
		if( targetTree.owner != player ) throw new NotOwnerOfTreeException( cell.index, targetTree.owner );
		if( targetTree.size < Constants.TREE_TALL) throw new TreeNotTallException( cell.index );
		if( targetTree.isDormant ) throw new AlreadyActivatedTree( cell.index );
		
		final costOfGrowth = getGrowthCost(targetTree);
		final currentSun = availableSun[player.index];
		if( currentSun < costOfGrowth ) throw new NotEnoughSunException(costOfGrowth, player.sun );

		availableSun[player.index] = currentSun - costOfGrowth;

		dyingTrees.push( coord );

		targetTree.setDormant();
	}

	function getCostFor( size:Int, owner:Player ) {
		final baseCost = Constants.TREE_BASE_COST[size];
		final sameTreeCount = [for( tree in trees ) tree].filter( t -> t.size == size && t.owner == owner ).length;
		
		return baseCost + sameTreeCount;
	}

	function doSeed( player:Player, action:Action ) {
		final targetCoord = getCoordByIndex( action.targetId );
		final sourceCoord = getCoordByIndex( action.sourceId );

		final targetCell = board.map[targetCoord];
		final sourceCell = board.map[sourceCoord];

		if( aTreeIsOn( targetCell )) throw new CellNotEmptyException( targetCell.index );
		
		final sourceTree = trees[sourceCell.index];
		if( sourceTree == null ) throw new TreeNotFoundException( sourceCell.index );
		if( sourceTree.size == Constants.TREE_SEED ) throw new TreeIsSeedException( sourceCell.index );
		if( sourceTree.owner != player ) throw new NotOwnerOfTreeException( sourceCell.index, sourceTree.owner );
		if( sourceTree.isDormant ) throw new AlreadyActivatedTree( sourceCell.index );
		

		final distance = sourceCoord.distanceTo(targetCoord);
		if( distance > sourceTree.size ) throw new TreeTooFarException( sourceCell.index, targetCell.index );
		if( targetCell.richness == Constants.RICHNESS_NULL ) throw new CellNotValidException( targetCell.index );
		
		final costOfSeed = getSeedCost(player);
		final currentSun = availableSun[player.index];
		if( currentSun < costOfSeed) throw new NotEnoughSunException( costOfSeed, player.sun );
		
		availableSun[player.index] = currentSun - costOfSeed;
		sourceTree.setDormant();
		final seed = new Seed( player.index, sourceCell.index, targetCell.index );
		sentSeeds.push( seed );
		gameSummaryManager.addPlantSeed(player, targetCell, sourceCell);

	}

	inline function aTreeIsOn( cell:Cell ) return trees.exists( cell.index );

	function giveSun() {
		final givenToPlayer:Array<Int> = [];
		for( index => tree in trees ) {
			if( !shadows.exists( index ) || shadows.get( index ) < tree.size ) {
				final owner = tree.owner;
				owner.addSun( tree.size );
				givenToPlayer[owner.index] += tree.size;
			}
		};
		for( player in gameManager.players ) {
			final given = givenToPlayer[player.index];
			if( given > 0) gameSummaryManager.addGather(player, given);
		};
	}

	function removeDyingTrees() {
		for( coord in dyingTrees ) {
			final cell = board.map.get(coord);
			final points = nutrients;
			if( cell.richness == Constants.RICHNESS_OK) {
				points += Constants.RICHNESS_BONUS_OK;
			} else if( cell.richness == Constants.RICHNESS_LUSH) {
				points += Constants.RICHNESS_BONUS_LUSH;
			}
			final player = trees.get(cell.index).owner;
			player.addScore(points);
			gameManager.addTooltip( player, 'player ${player.index} scores $points points' );
			trees.remove(cell.index);
			gameSummaryManager.addCutTree(player, cell, points);
		}
	}

	function updateNutrients() for( coord in dyingTrees ) nutrients = int( max( 0, nutrients - 1 ));

	public function performGameUpdate() {
		turn++;

		switch currentFrameType {
		case GATHERING:
			gameSummaryManager.addRound( round );
			performSunGatheringUpdate();
			nextFrameType = FrameType.ACTIONS;

		case ACTIONS:
			gameSummaryManager.addRound( round );
			performActionUpdate();
			if( allPlayersAreWaiting()) nextFrameType = FrameType.SUN_MOVE;

		case SUN_MOVE:
			gameSummaryManager.addRoundTransition( round );
			performSunMoveUpdate();
			nextFrameType = FrameType.GATHERING;

		default:
			trace( "Error: " + currentFrameType );

		}

		gameManager.addToGameSummary( gameSummaryManager.toString());
		gameSummaryManager.clear();

		if( gameOver()) {
			gameManager.endGame();
		} else {
			gameManager.maxTurns = turn + 1;
		}
	}

	public function performSunMoveUpdate() {
		round++;
		if( round < MAX_ROUNDS ) {
			sun.move();
			if( ENABLE_SHADOW ) calculateShadows();
		}
		gameManager.frameDuration = Constants.DURATION_SUNMOVE_PHASE;
	}

	public function performSunGatheringUpdate() {
		// Wake gameManager.players
		for( p in gameManager.players ) p.isWaiting = false;
		for( tree in trees ) tree.reset();
		
		// Harvest
		giveSun();

		gameManager.frameDuration = Constants.DURATION_GATHER_PHASE;
	}

	public function performActionUpdate() {
		for( player in gameManager.players ) {
			// trace( 'performActionUpdate player ${player.index} isWaiting ${player.isWaiting}' );
			if( !player.isWaiting ) {
				try {
					final action = player.action;
					if( action.isGrow()) doGrow( player, action );
					else if( action.isSeed()) doSeed( player, action );
					else if( action.isComplete()) doComplete( player, action );
				 	else {
						player.isWaiting = true;
						gameSummaryManager.addWait( player );
					}
				} catch ( e:GameException ) {
					// trace( Error player ${player.index}: ${e.message}' );
					gameSummaryManager.addError( player.index + ": " + e.message );
					player.isWaiting = true;
				}
			}
		}
	
		if( seedsAreConflicting()) gameSummaryManager.addSeedConflict( sentSeeds[0] );
		else {
			for( seed in sentSeeds ) plantSeed( gameManager.players[seed.owner], seed.targetCell, seed.sourceCell );
			for( player in gameManager.players ) player.sun = availableSun[player.index];
		}
		removeDyingTrees();

		updateNutrients();

		gameManager.frameDuration = Constants.DURATION_ACTION_PHASE;

	}

	function seedsAreConflicting() {
		final seedTargetCells = sentSeeds.map( seed -> seed.targetCell );
		seedTargetCells.sort(( a, b ) -> a - b );
		final uniqueSeedTargetCells = ArrayUtils.uniquify( seedTargetCells );

		return sentSeeds.length != uniqueSeedTargetCells.length;
	}

	function allPlayersAreWaiting() {
		for( p in gameManager.players ) if( !p.isWaiting ) return false;
		return true;
	}

	function plantSeed( player:Player, index:Int, fatherIndex:Int ) {
		final seed = placeTree( player, index, Constants.TREE_SEED );
		seed.setDormant();
		seed.fatherIndex = fatherIndex;
	}

	function placeTree( player:Player, index:Int, size:Int ) {
		final tree = new Tree( player, index );
		tree.size = size;

		trees.set( index, tree );
		return tree;
	}

	public function onEnd() {
		for( player in gameManager.players ) player.addScore( int( floor( player.sun / 3 )));
		
		if( gameManager.players.length != 2 ) throw "Error: game should have two gameManager.players";
		
		if( gameManager.players[0].score == gameManager.players[1].score ) {
			for( tree in trees ) {
				if (tree.owner.isActive ) {
					tree.owner.bonusScore = 1;
					tree.owner.addScore( 1 );
				}
			}
		}
	}

	function gameOver() {
		final activePlayers = gameManager.players.filter( p -> p.isActive );
		// trace( 'activePlayers ${activePlayers.length} round $round max_rounds $MAX_ROUNDS' );
		return activePlayers.length <= 1 || round >= MAX_ROUNDS;
	}

}