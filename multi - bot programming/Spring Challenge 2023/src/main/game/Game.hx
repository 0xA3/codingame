package main.game;

import gameengine.core.MultiplayerGameManager;
import gameengine.module.endscreen.EndScreenModule;
import haxe.ds.HashMap;
import main.event.Animation;
import main.event.EventData;
import main.game.move.AntAllocater;
import main.game.move.AntMove;
import xa3.MTRandom;
import xa3.MathUtils;

using Lambda;
using xa3.ArrayUtils;
using xa3.StringUtils;

class Game {
	
	var gameManager:MultiplayerGameManager;
	var endScreenModule:EndScreenModule;
	var animation:Animation;
	var gameSummaryManager:GameSummaryManager;

	var STARTING_HILL_DISTANCE = 2;

	var random:MTRandom;

	var players:Array<Player>;

	var viewerEvents:Array<EventData> = [];

	var gameTurn:Int;
	var board:Board;
	var moveAnimatedThisTurn:Bool;

	public function new(
		gameManager:MultiplayerGameManager,
		endScreenModule:EndScreenModule,
		animation:Animation,
		gameSummaryManager:GameSummaryManager
	) {
		this.gameManager = gameManager;
		this.endScreenModule = endScreenModule;
		this.animation = animation;
		this.gameSummaryManager = gameSummaryManager;
	}

	public function init() {
		players = gameManager.getPlayers().map ( p -> cast( p ));
		random = gameManager.getRandom();
		viewerEvents.splice( 0, viewerEvents.length );
		gameTurn = 0;
		board = BoardGenerator.generate( random, players );
	}

	public function isKeyFrame() {
		return gameTurn % Config.FRAMES_PER_TURN == 0;
	}

	public function resetGameTurnData() { //trace( "resetGameTurnData" );
		if( isKeyFrame()) {
			board.cells.iter( cell -> cell.removeBeacons());
		}
		viewerEvents.splice( 0, viewerEvents.length );
		animation.reset();
		players.iter( player -> player.reset());
		moveAnimatedThisTurn = false;
		board.resetAttackCache();
	}

	public function getGlobalInfoFor( player:Player ) {
		final lines:Array<String> = [];
		lines.push( '${board.coords.length}' );
		board.coords.iter( coord -> {
			final cell = board.map[coord];
			final type = cell.getType() == EGG ? 1 : cell.getType() == FOOD ? 2 : 0;
			lines.push( '$type ${cell.getRichness()} ${board.getNeighbourIds( coord )}' );
		});

		final other = getOpponent( player );
		lines.push( '${player.anthills.length}' );
		lines.push( player.anthills.join(" ") );
		lines.push( other.anthills.join(" ") );

		return lines;
	}

	function getOpponent( player:Player ) {
		return players[1 - player.getIndex()];
	}

	public function getCurrentFrameInfoFor( player:Player ) {
		final lines:Array<String> = [];
		final other = getOpponent( player );
		if( Config.SCORES_IN_IO ) {
			lines.push( '${player.points} ${other.points}' );
		}
		for( coord in board.coords ) {
			final cell = board.get( coord );
			lines.push( '${cell.getRichness()} ${cell.getAntsPlayer( player )} ${cell.getAntsPlayer( other )}' );
		}

		return lines;
	}

	function doBuild() {
		final eggCells = board.getEggCells();
		final builds:Array<AntConsumption> = [];
		for( player in players ) {
			builds.addAll( computeCellConsumption( player, eggCells ));
		}
		for( build in builds ) {
			for( idx in build.player.anthills ) {
				board.getByIndex( idx ).placeAnts( build.player, build.amount );
			}
			launchBuildEvent( build.amount, build.player.getIndex(), build.path );
			build.cell.deplete( build.amount );
			gameSummaryManager.addBuild( build );
		}
	}

	function doFights() {
		if( Config.FIGHTING_ANTS_KILL ) {
			for( coord in board.coords ) {
				final cell = board.get( coord );
				final ants0 = cell.getAntsId( 0 );
				final ants1 = cell.getAntsId( 1 );
				cell.removeAntsId( 0, MathUtils.min( Config.MAX_ANT_LOSS, ants1 ));
				cell.removeAntsId( 1, MathUtils.min( Config.MAX_ANT_LOSS, ants0 ));
			}
		}
	}

	public function performGameUpdate( frameIdx:Int ) {
		doLines();
		doBeacons();
		doMove();
		animation.catchUp();
		if( moveAnimatedThisTurn ) {
			animation.wait( Animation.THIRD );
		}
		doFights();
		doBuild();
		animation.catchUp();
		board.resetAttackCache();
		doScore();
		animation.catchUp();
		gameTurn++;
		if( checkGameOver()) {
			gameManager.endGame();
		}

		gameManager.addToGameSummary( gameSummaryManager.toString());
		gameSummaryManager.clear();

		final frameTime = animation.computeEvents();
		gameManager.setFrameDuration( frameTime );
	}

	function computeCellConsumption( player:Player, targetCells:Array<Cell> ) {
		final anthills = player.anthills;
		final meals:Array<AntConsumption> = [];

		for( foodCell in targetCells ) {
			final allPaths:Array<Array<Cell>> = [];
			for( anthill in anthills ) {
				final anthillCell = board.getByIndex( anthill );

				// Dijkstra from food to anthill
				final bestPathToHill = board.getBestPath( foodCell, anthillCell, player.getIndex(), Config.LOSING_ANTS_CANT_CARRY );

				if( bestPathToHill.length != 0 ) {
					allPaths.push( bestPathToHill );
				}
			}

			// For this particular foodSource, this is the best path back to an anthill
			allPaths.sort(( a, b ) -> {
				final pathValueA = pathValue( player, a );
				final pathValueB = pathValue( player, b );
				if( pathValueA < pathValueB ) return 1;
				if( pathValueA > pathValueB ) return -1;

				return a.length - b.length;
			});

			final bestPath = allPaths.length > 0 ? allPaths[0] : [];

			final maxMin = bestPath.length > 0 ? pathValue( player, bestPath ) : 0;

			// What if there's only 1 food on a cell and both players eat it at the same time?
			// => it gets duplicated and they both eat 1
			final foodEaten = MathUtils.min( maxMin, foodCell.getRichness());
			if( foodEaten > 0 ) {
				meals.push({ player: player, amount: foodEaten, cell: foodCell, path: bestPath });
			}
		}
		return meals;
	}

	function pathValue( player:Player, list:Array<Cell> ) {
		if( list.length == 0 ) return 0;
		return list.map( cell -> cell.getAntsPlayer( player )).min();
	}

	function doScore() {
		final foodCells = board.getFoodCells();
		final meals:Array<AntConsumption> = [];
		for( player in players ) {
			// For each food output, find best path that leads to one of the player's anthills.
			// The best path is the one with the largest minimum amount of ants on a node of the path.
			// e.g.   food--- 10 --- 2 --- 10 --- hill
			//         \            /      /
			//          \---5------7----6-/                 should retrieve the path food-5-7-6-10-hill
			// the player should then be given as many points as the lowest node: 5 points.
			// This repeats for each food source.
			meals.addAll( computeCellConsumption( player, foodCells ));
		}

		for( meal in meals ) {
			launchFoodEvent( meal );
			gameSummaryManager.addMeal( meal );

			meal.player.addPoints( meal.amount );
			meal.cell.deplete( meal.amount );
		}
	}

	function launchFoodEvent( meal:AntConsumption ) {
		final e = new EventData();
		e.type = EventData.FOOD;
		e.playerIdx = meal.player.getIndex();
		e.path = meal.path.map( cell -> cell.getIndex());

		e.amount = meal.amount;
		animation.startAnim( e.animData, Animation.HALF );
		viewerEvents.push( e );
	}

	function doMove() {
		for( player in players ) {
			final playerAntCells = getPlayerAntCells( player );
			final playerBeaconCells = getPlayerBeaconCells( player );
			final allocations = AntAllocater.allocateAnts( playerAntCells, playerBeaconCells, player.getIndex(), board );

			final moves = new HashMap<AntMove, Int>();

			for( alloc in allocations ) {
				// Get next step in path
				final path = board.findShortestPath( alloc.getAntIndex(), alloc.getBeaconIndex(), player.getIndex());

				if( path.length > 1 ) {
					final neighbor = path[1];
					final from = alloc.getAntIndex();
					final to = neighbor;
					final amount = alloc.getAmount();

					final antMove = new AntMove( from, to );
					antMoveCompute( moves, antMove, (k, v:Null<Int>) -> v == null ? amount : v + amount );
				}
			}

			for( move => amount in moves ) {
				applyMove( move.getFrom(), move.getTo(), amount, player.getIndex());
			}
		}
	}

	function antMoveCompute( map:HashMap<AntMove, Int>, key:AntMove, remappingFunction:( k:AntMove, v:Int ) -> Null<Int> ) {
		final result = try {
			remappingFunction( key, map[key] );
		} catch( e:Dynamic ) {
			throw e;
		}
		if( result == null ) map.remove( key );
		else map.set( key, result );
	}
	

	function applyMove( fromIdx:Int, toIdx:Int, amount:Int, playerIdx:Int ) {
		final source = board.getByIndex( fromIdx );
		final target = board.getByIndex( toIdx );

		source.removeAntsId( playerIdx, amount );
		source.placeAntsId( playerIdx, amount );

		// viewer animation
		launchMoveEvent( source.getIndex(), target.getIndex(), amount, playerIdx );
		moveAnimatedThisTurn = true;
	}

	function getPlayerAntCells( player:Player ) {
		return board.cells.filter( cell -> cell.getAntsId( player.getIndex()) > 0 );
	}

	function getPlayerBeaconCells( player:Player ) {
		return board.cells.filter( cell -> cell.getBeaconPowerId( player.getIndex()) > 0 );
	}

	function launchMoveEvent( fromIdx:Int, toIdx:Int, amount:Int, playerIdx:Int ) {
		final e = new EventData();
		e.type = EventData.MOVE;
		e.playerIdx = playerIdx;
		e.cellIdx = fromIdx;
		e.targetIdx = toIdx;
		e.amount = amount;
		animation.startAnim( e.animData, Animation.HALF );
		viewerEvents.push( e );
	}

	function launchBuildEvent( amount:Int, playerIdx:Int, path:Array<Cell> ) {
		final e = new EventData();
		e.type = EventData.BUILD;
		e.playerIdx = playerIdx;
		e.amount = amount;
		e.path = path.map( cell -> cell.getIndex());
		animation.startAnim( e.animData, Animation.HALF );
		viewerEvents.push( e );
	}

	function doBeacons() {
		for( player in players ) {
			for( beacon in player.beacons ) {
				final cellIdx = beacon.cellIndex;
				final power = beacon.power;
				setBeaconPower( cellIdx, player, power );
			}
		}
	}

	function setBeaconPower( cellIndex:Int, player:Player, power:Int ) {
		final cell = board.getByIndex( cellIndex );
		if( !cell.isValid()) {
			gameSummaryManager.addError(
				player,
				'cannot find cell $cellIndex'
			);
			return;
		}
		cell.setBeaconPower( player.getIndex(), MathUtils.max( 1, power ));
	}

	function launchBeaconEvent( playerIdx:Int, power:Int, cellIdx:Int ) {
		final e = new EventData();
		e.type = EventData.BEACON;
		e.playerIdx = playerIdx;
		e.cellIdx = cellIdx;
		e.amount = power;
		animation.startAnim( e.animData, Animation.HALF );
		viewerEvents.push( e );
	}

	function doLines() {
		for( player in players ) {
			for( line in player.lines ) {
				final from = line.from;
				final to = line.to;
				final beaconPower = line.ants;
				if( !board.getByIndex( from ).isValid()) {
					gameSummaryManager.addError(
						player,
						'cannot find cell $from'
					);
					continue;
				}
				if( !board.getByIndex( to ).isValid()) {
					gameSummaryManager.addError(
						player,
						'cannot find cell $to'
					);
					continue;
				}
				final path = board.findShortestPath( from, to );
				for( cellIndex in path ) {
					setBeaconPower( cellIndex, player, beaconPower );
				}
			}
		}
	}

	function checkGameOver() {
		final remainingFood = board.getRemainingFood();

		if( remainingFood == 0 ) {
			gameSummaryManager.addNoMoreFood();
			return true;
		}
		if( players[0].points >= players[1].points + remainingFood ) {
			gameSummaryManager.addNotEnoughFoodLeft( players[0] );
			return true;
		} else if( players[1].points >= players[0].points + remainingFood ) {
			gameSummaryManager.addNotEnoughFoodLeft( players[1] );
			return true;
		}
		return false;
	}

	public function onEnd() {
		players.iter( p -> {
			if( p.isActive()) {
				p.setScore( p.points );
			} else {
				p.setScore( -1 );
			}
		});

		if( players[0].getScore() == players[1].getScore() && players[0].getScore() != -1 ) {
			players.iter( p -> p.setScore( getAntTotal( p )));
			endScreenModule.setScoresAndDisplayedText(
				players.map( p -> p.getScore()),
				players.map( p -> '${p.points} points and ${p.getScore()} ants' )
			);
		} else {
			endScreenModule.setScores(
				players.map( p -> p.getScore())
			);
		}
	}

	function getAntTotal( p:Player ) {
		return board.cells.map( cell -> cell.getAntsPlayer( p )).sum();
	}

	public function getViewerEvents() {
		return viewerEvents;
	}

	public static function getExpected( playerOutput:String ) {
		final attempt = playerOutput.toUpperCase();

		if( attempt.startsWith( "BEACON" )) {
			return "BEACON <cell_index> <beacon_strength>";
		}
		if( attempt.startsWith( "LINE" )) {
			return "LINE <from_index> <to_index> <beacon_strength>";
		}
		if( attempt.startsWith( "MESSAGE" )) {
			return "MESSAGE <text>";
		}
		if( attempt.startsWith( "WAIT" )) {
			return "WAIT";
		}
		return "BEACON |"
			+ " LINE |"
			+ " MESSAGE |"
			+ " WAIT";
	}

	public function getBoard() {
		return board;
	}

	public function getBoardCoords() {
		trace( board );
		return board.coords;
	}
}