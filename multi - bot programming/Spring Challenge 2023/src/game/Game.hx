package game;

import event.Animation;
import event.EventData;
import gameengine.core.MultiplayerGameManager;
import gameengine.module.endscreen.EndScreenModule;
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

	public function resetGameTurnData() {
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
			lines.push( '${player.getPoints()} ${other.getPoints()}' );
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
		for( player in gameManager.getPlayers()) {
			builds.addAll( computeCellConsumption( cast player, eggCells ));
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
		
	}

	public function performGameUpdate( frameIdx:Int ) {
		
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
		return 0;
	}

	function doScore() {
		
	}

	function launchFoodEvent( meal:AntConsumption ) {
		
	}

	function doMove() {
		
	}

	function applyMove( fromIdx:Int, toIdx:Int, amount:Int, playerIdx:Int ) {
		
	}

	function getPlayerAntCells( player:Player ) {
		
	}

	function getPlayerBeaconCells( player:Player ) {
		
	}

	function launchMoveEvent( fromIdx:Int, toIdx:Int, amount:Int, playerIdx:Int ) {
		
	}

	function launchBuildEvent( amount:Int, playerIdx:Int, path:Array<Cell> ) {
		
	}

	function doBeacons() {
		
	}

	function setBeaconPower() {
		
	}

	function launchBeaconEvent( playerIdx:Int, power:Int, cellIdx:Int ) {
		
	}

	function doLines() {
		
	}

	function checkGameOver() {
		
	}

	public function onEnd() {
		
	}

	function getAntTotal( p:Player ) {
		
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
		return board.coords;
	}
}