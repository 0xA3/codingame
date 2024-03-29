package game;

import Std.int;
import event.Animation;
import event.EventData;
import game.action.BuildAction;
import game.exception.GameException;
import game.pathfinding.PathFinder;
import gameengine.core.GameManager;
import haxe.ds.HashMap;
import viewer.CellDataset;
import xa3.MTRandom;
import xa3.MathUtils;

using Lambda;
using xa3.ArrayUtils;
using xa3.StringUtils;

class Game {

	final gameManager:GameManager;
	final endScreenModule:EndScreenModule;
	final pathFinder:PathFinder;
	final animation:Animation;
	final gameSummaryManager:GameSummaryManager;

	var random:MTRandom;
	public var grid:Grid;
	var recyclers:Array<Recycler>;
	var players:Array<Player>;

	var fightLocations:HashMap<Coord, Bool>;
	public var viewerEvents( default, null ):Array<EventData>;

	public var gameTurn:Int;
	var earlyFinishCounter = Config.EARLY_FINISH_TURNS;
	var unitStartTime:Int;

	public function new(
		gameManager:GameManager,
		endScreenModule:EndScreenModule,
		pathFinder:PathFinder,
		animation:Animation,
		gameSummaryManager:GameSummaryManager ) {
		this.gameManager = gameManager;
		this.endScreenModule = endScreenModule;
		this.pathFinder = pathFinder;
		this.animation = animation;
		this.gameSummaryManager = gameSummaryManager;
	}

	public function init() {
		players = gameManager.players;
		random = gameManager.random;
		final width = randInt( Config.MAP_MIN_WIDTH, Config.MAP_MAX_WIDTH + 1 );
		final height = int( width * Config.MAP_ASPECT_RATIO );

		grid = new Grid( random, players, width, height );
		recyclers = [];
		fightLocations = new HashMap<Coord, Bool>();
		viewerEvents = [];
		gameTurn = 0;
		initPlayers();
	}
	
	function randInt( from:Int, to:Int ) return random.nextInt( to - from ) + from;
	
	function resetEarlyTurnCounter() {
		earlyFinishCounter = Config.EARLY_FINISH_TURNS;
	}

	function initPlayers() {
		// trace( 'initPlayers ${gameManager.getActivePlayers()}' );
		for( player in gameManager.getActivePlayers()) {
			player.money = Config.PLAYER_STARTING_MONEY;
			if( grid.spawns.length > player.index ) {
				grid.spawns[player.index].iter( coord -> player.placeStartUnit( coord ));
				// trace( 'player ${player.index} placeStartUnit ${player.units}' );
			}
		}
	}

	public function resetGameTurnData() {
		viewerEvents.clear();
		animation.reset();
		players.iter( player -> player.reset());
		fightLocations.clear();
	}

	public function getGlobalInfoFor( player:Player ) {
		final lines = [];
		lines.push( Referee.join( [grid.width, grid.height] ));
		return lines;
	}

	public function getCurrentFrameInfoFor( player:Player ) {
		final coordsInRangeOfRecyclersArray = recyclers
		.flatMap( recycler -> getWithinRange( recycler.coord ))
		.filter( coord -> !grid.getCoord( coord ).isHole() );
		
		final coordsInRangeOfRecyclers = new HashMap<Coord, Bool>();
		for( coord in coordsInRangeOfRecyclersArray ) coordsInRangeOfRecyclers.set( coord, true );
		
		final lines:Array<String> = [];
		final other = players.filter( p -> p != player ).first();
		lines.push( Referee.join( [player.money, other.money] ));

		for( y in 0...grid.height ) {
			for( x in 0...grid.width ) {
				final coord = new Coord( x, y );
				final cell = grid.getCoord( coord );
				final durability = cell.durability;
				final ownerIdx = cell.owner == player ? 1 : cell.owner == other ? 0 : -1;
				final myUnit = player.getUnitAtXY( x, y );
				final oppUnit = other.getUnitAtXY( x, y );
				final excavator = getExcavatorAt( x, y );
				
				final unitStrength = ownerIdx == 1 ? myUnit.getStrength() : oppUnit.getStrength();
				final canBuildHere = ownerIdx == 1 && excavator == Recycler.NO_RECYCLER && unitStrength == 0;
				final canSpawnHere = ownerIdx == 1 && excavator == Recycler.NO_RECYCLER;
				final willGetDamaged = coordsInRangeOfRecyclers.exists( coord );

				final row = Referee.join([
					durability,
					ownerIdx,
					unitStrength,
					excavator == Recycler.NO_RECYCLER ? 0 : 1,
					canBuildHere ? 1 : 0,
					canSpawnHere ? 1 : 0,
					willGetDamaged ? 1 : 0
				]);

				lines.push( row );
			}
		}

		return lines;
	}

	public function getCurrentCellData() {
		final cellDatasets:Array<CellDataset> = [];
		var playerCellsSums = [for( _ in players ) 0];
		for( y in 0...grid.height ) {
			for( x in 0...grid.width ) {
				final coord = new Coord( x, y );
				final cell = grid.getCoord( coord );
				final durability = cell.durability;
				final ownerIdx = cell.owner.index;
				final myUnit = players[0].getUnitAtXY( x, y );
				final oppUnit = players[1].getUnitAtXY( x, y );
				final excavator = getExcavatorAt( x, y );

				final unitStrength = ownerIdx == 0 ? myUnit.getStrength() : oppUnit.getStrength();
				
				final cellDataset:CellDataset = {
					x: x,
					y: y,
					durability: durability,
					ownerIdx: ownerIdx,
					unitStrength: unitStrength,
					excavator: excavator != Recycler.NO_RECYCLER
				}
				if( ownerIdx != -1 ) playerCellsSums[ownerIdx] += 1;

				cellDatasets.push( cellDataset );
				// if( gameTurn == 0 ) trace( '$x:$y $cellDataset' );
			}
		}
		return { playerCellsSums: playerCellsSums, cellDatasets: cellDatasets }
	}

	public function performGameUpdate( frameIdx:Int ) {
		doBuilds();
		doUnits();
		animation.catchUp();
		doRecycle();

		gameTurn++;
		earlyFinishCounter--;
		doPassiveIncome();
		
		if (checkGameOver()) gameManager.endGame();
		
		gameManager.addToGameSummary( gameSummaryManager.toString() );
		gameSummaryManager.clear();

		computeEvents();
	}

	function getCurrentFrameData() {
		return {
			positions: [],
			messages: []
		};
	}

	function doPassiveIncome() {
		var cellCount = 0;
		for( cell in grid.cells ) if( !cell.isHole() ) cellCount++;
		for ( p in players ) {
			final passiveIncome = Config.PLAYER_MINIMAL_INCOME;
			p.money += passiveIncome;
		}

	}

	function getWithinRange( coord:Coord ) {
		final inRange = grid.getNeighbors( coord );
		inRange.push( coord );
		return inRange;
	}

	function doRecycle() {
		final excavatedByPlayer = [for( player in players ) player.index => new HashMap<Coord, Bool>()];
		
		for( e in recyclers ) {
			var nbExcavatedByRecycler = 0;
			final coords = getWithinRange( e.coord );
			coords.iter( coord -> {
				final cell = grid.getCoord( coord );
				if( !cell.isHole() ) {
					if( !excavatedByPlayer[e.getOwnerIdx()].exists( coord )) {
						nbExcavatedByRecycler++;
					}
					excavatedByPlayer[e.getOwnerIdx()].set( coord, true );
				}
			});
			
			if( nbExcavatedByRecycler > 0 ) {
				launchMatterCollectEvent( e.coord, nbExcavatedByRecycler * Config.RECYCLER_INCOME, e.getOwnerIdx() );
			}
		}

		players.iter( player -> {
			final coords = excavatedByPlayer[player.index];
			final income = [for( coord in coords.keys()) 1].sum() * Config.RECYCLER_INCOME;
			player.money += income;
		});

		final destroyedCells = new HashMap<Coord, Bool>();
		players.iter( p -> {
			final coords = excavatedByPlayer[p.index];
			for( coord in coords.keys() ) {
				final cell = grid.getCoord( coord );
				final broken = cell.damage();
				launchCellDamageEvent( cell, coord );
				if( broken ) destroyedCells.set( coord, true );

				resetEarlyTurnCounter();
			}
		});

		animation.wait( Animation.THIRD );
		animation.catchUp();

		recyclers.filter( e -> destroyedCells.exists( e.coord ))
		.iter( r -> launchRecyclerFallEvent( r ));

		recyclers.removeIf( e -> destroyedCells.exists( e.coord ) );

		players.iter( p -> {
			for( coord in destroyedCells.keys()) {
				final u = p.getUnitAt( coord );
				if( u.availableCount > 0 ) {
					p.units.remove( coord );
					launchUnitFallEvent( coord, u, p );
				}
			};
		});

		// no return value needed
	}

	function launchUnitFallEvent( coord:Coord, u:Unit, player:Player ) {
        final e = new EventData();
        e.type = EventData.UNIT_FALL;
        e.coord = coord;
        e.amount = u.getStrength();
        e.playerIndex = player.index;
        animation.startAnim( e.animData, Animation.THIRD );
        animation.wait( Animation.TWENTIETH );
        viewerEvents.push( e );
    }

   function launchRecyclerFallEvent( r:Recycler ) {
        final e = new EventData();
        e.type = EventData.RECYCLER_FALL;
        e.coord = r.coord;
        e.playerIndex = r.getOwnerIdx();
        animation.startAnim( e.animData, Animation.THIRD );
        animation.wait(Animation.TWENTIETH);
        viewerEvents.push( e );
    }
	
	function doBuilds() {
		var buildHappened = false;
		final buildStartTime = animation.frameTime;

		for( player in players ) {
			animation.frameTime = buildStartTime;
			for( build in player.builds ) {
				final buildTarget = build.coord;

				try {
					if( !grid.isOwner( buildTarget, player )) {
						throw new GameException( 'tried to build a recycler at (${buildTarget.x}, ${buildTarget.y}), which is not owned by the player' );
					} else if( getRecyclerAt( buildTarget ) != Recycler.NO_RECYCLER ) {
						throw new GameException( 'tried to build a recycler at (${buildTarget.x}, ${buildTarget.y}), into another recycler' );
					} else if( unitExistsAt( buildTarget )) {
						throw new GameException( 'tried to build a recycler at (${buildTarget.x}, ${buildTarget.y}), where units are already present' );
					} else if( player.money < Config.COST_RECYCLER ) {
						throw new GameException( 'tried to build a recycler at (${buildTarget.x}, ${buildTarget.y}), but has not enough matter' );
					} else {
						recyclers.push( new Recycler( buildTarget, player ));
						player.money -= Config.COST_RECYCLER;

						launchBuildEvent( build, player );
						buildHappened = true;
					}
				
				} catch( e:GameException ) {
					trace( e );
					gameSummaryManager.addError( player, e.message );
				}
			}
		}

		animation.catchUp();
		return buildHappened;
	}

	function unitExistsAt( coord:Coord ) {
		for( player in players ) if( player.getUnitAt( coord ) != Unit.NO_UNIT ) return true;
		return false;
	}

	function doUnits() {
		doSpawn();
		animation.catchUp();
		doMove();
		animation.catchUp();

		resetUnits();
		doFights();

		var unitsAreFighting = false;
		for( _ in fightLocations ) { unitsAreFighting = true; break; }
		return unitsAreFighting;
	}

	function getOwnedCells( player:Player ) {
		var n = 0;
		for( cell in grid.cells ) if( cell.isOwnedBy( player )) n++;
		return n;
	}

	function mapIsFinal() {
		for( coord => cell in grid.cells ) {
			final owner = cell.owner;
			if( owner != Player.NO_PLAYER ) {
				final neighs = grid.getNeighbors( coord ).filter( n -> !grid.getCoord( n ).isHole());
				for( n in neighs ) if( grid.isOwner( n, owner )) return false;
			}
		}
		
		return true;
	}

	function checkGameOver() {
		if( earlyFinishCounter <= 0 ) {
			final winner = getPlayerWithMostOwnedCells();
			gameManager.addTooltip( winner, 'Field stable for ${Config.EARLY_FINISH_TURNS} turns. ${winner.name} wins!');
			trace( 'checkGameOver earlyFinishCounter ${earlyFinishCounter}' );
			return true;
		}

		for( player in players ) {
			if( getOwnedCells( player ) == 0 ) {
				trace( 'checkGameOver getOwnedCells of player ${player.name} == 0' );
				final winner = getPlayerWithMostOwnedCells();
				gameManager.addTooltip( winner, '${player.name} has no more cellDatasets and is disqualified' );
				return true;
			}
		}

		return false;
	}

	function getPlayerWithMostOwnedCells() {
		var playerWithMostOwnedCells = Player.NO_PLAYER;
		var maxOwnedCells = -1;
		for( player in players ) {
			final ownedCells = getOwnedCells( player );
			if( ownedCells > maxOwnedCells ) {
				playerWithMostOwnedCells = player;
				maxOwnedCells = ownedCells;
			}
		}
		return playerWithMostOwnedCells;
	}

	function resetUnits() {
		players.iter( player -> player.resetUnits());
	}

	function doFights() {
		for( coord in fightLocations.keys() ) {
			final player = players[0];
			final other = players[1];
			final playerUnitStrength = player.getUnitAt( coord ).availableCount;
			final otherUnitStrength = other.getUnitAt( coord ).availableCount;

			if( playerUnitStrength > 0 && otherUnitStrength > 0 ) {
				var winner =
				playerUnitStrength > otherUnitStrength ? player
				: playerUnitStrength < otherUnitStrength ? other
				: Player.NO_PLAYER;
				launchFightEvent( coord, winner, MathUtils.abs( playerUnitStrength - otherUnitStrength ));
			}

			player.removeUnits( coord, otherUnitStrength );
			other.removeUnits( coord, playerUnitStrength );

			final cell = grid.getCoord( coord );
			if( playerUnitStrength > otherUnitStrength && !cell.isOwnedBy( player )) {
				cell.owner = player;
				launchChangeOwnerEvent( coord, player );
				resetEarlyTurnCounter();
			} else if( playerUnitStrength < otherUnitStrength && !cell.isOwnedBy( other )) {
				cell.owner = other;
				launchChangeOwnerEvent( coord, other );
				resetEarlyTurnCounter();
			}
		}
	}

	function doMove() {
		final restricted:Array<Coord> = [for( coord in grid.cells.keys() ) if( getRecyclerAt( coord ) != Recycler.NO_RECYCLER ) coord];
		final moveStartTime = animation.frameTime;
		
		for( player in gameManager.getActivePlayers()) {
			animation.frameTime = moveStartTime;
			final actualMoves = new HashMap<CoordTuple, Int>();
			
			for( move in player.moves ) {
				final origin = move.from;
				final target = move.to;
				final originUnit = player.getUnitAt( origin );
				
				try {
					if( originUnit.availableCount < move.amount ) {
						throw new GameException( 'tried to move ${move.amount} units from (${origin.x}, ${origin.y}) where only ${originUnit.availableCount} were available' );
					} else if( origin.equals( target )) {
						throw new GameException( 'tried to move ${move.amount} units from (${origin.x}, ${origin.y}) to the same tile' );
					} else if( move.amount <= 0 ) {
						throw new GameException( 'tried to move a 0 amount of units from (${origin.x}, ${origin.y}) to the same tile' );
					} else {
						final pfr = pathFinder.setGrid( grid ).restrict( restricted ).from( origin ).to( target ).findPath();
						final wholePath = pfr.path;
						if( wholePath.length > 1 ) {
							final step = wholePath[1];
							originUnit.availableCount -= move.amount;
							player.placeUnits( step, move.amount );
							final key = new CoordTuple( origin, step );
							CoordTuple.compute( actualMoves, key, ( k, v:Null<Int> ) -> ( v == null ? 0 : v ) + move.amount );
						}
						
					}
				} catch( e:GameException ) {
					trace( 'turn $gameTurn ${player.name} $e' );
					gameSummaryManager.addError( player, e.message );
				}
			}

			for( path => amount in actualMoves ) {
				launchMoveEvent( path.a, path.b, amount, player );
				fightLocations.set( path.b, true );
			}
		}
	}

	function launchBuildEvent( build:BuildAction, player:Player ) {
		final e = new EventData();
		e.type = EventData.BUILD;
		e.playerIndex = player.index;
		e.coord = build.coord;
		animation.startAnim( e.animData, 2 * Animation.THIRD );
		animation.wait( Animation.THIRD );
		viewerEvents.push( e );
	}

	function launchMoveEvent( from:Coord, to:Coord, amount:Int , player:Player ) {
		final e = new EventData();
		e.type = EventData.MOVE;
		e.playerIndex = player.index;
		e.coord = from;
		e.target = to;
		e.amount = amount;
		animation.startAnim( e.animData, Animation.HALF );
		animation.wait( Animation.TWENTIETH );
		viewerEvents.push( e );
	}

	function launchCellDamageEvent( cell:Cell, coord:Coord ) {
		final e = new EventData();
		e.type = EventData.CELL_DAMAGE;
		e.coord = coord;
		e.amount = cell.durability;
		animation.startAnim( e.animData, Animation.HALF );
		animation.wait( Animation.HUNDREDTH );
		viewerEvents.push( e );
	}

	function launchMatterCollectEvent( coord:Coord, amount:Int, playerIdx:Int ) {
		final e = new EventData();
		e.type = EventData.MATTER_COLLECT;
		e.playerIndex = playerIdx;
		e.coord = coord;
		e.amount = amount;
		animation.startAnim( e.animData, Animation.WHOLE );
		animation.wait( Animation.HUNDREDTH );
		viewerEvents.push( e );
	}

	function launchFightEvent( coord:Coord, survivor:Player, amount:Int ) {
		final e = new EventData();
		e.type = EventData.FIGHT;
		e.playerIndex = survivor == null ? 2 : survivor.index;
		e.coord = coord;
		e.amount = amount;
		animation.startAnim( e.animData, Animation.THIRD );
		viewerEvents.push( e );
	}

	function launchSpawnEvent( coord:Coord, amount:Int, player:Player ) {
		final e = new EventData();
		e.type = EventData.SPAWN;
		e.playerIndex = player.index;
		e.coord = coord;
		e.amount = amount;
		animation.startAnim( e.animData, 2 * Animation.THIRD );
		animation.wait( Animation.TENTH );
		viewerEvents.push( e );
	}

	function launchChangeOwnerEvent( coord:Coord, player:Player ) {
		final e = new EventData();
		e.type = EventData.CELL_OWNER_SWAP;
		e.playerIndex = player.index;
		e.coord = coord;
		animation.startAnim( e.animData, Animation.THIRD );
		viewerEvents.push( e );
	}

	function doJump() {
		for( player in gameManager.getActivePlayers() ) {
			animation.frameTime = unitStartTime;
			for( warp in player.warps ) {
				final origin = warp.from;
				final target = warp.to;
				final originUnit = player.getUnitAt( origin );

				final cost = getWarpCost( origin, target, player );

				try {
					if( getRecyclerAt( target ) != Recycler.NO_RECYCLER ) {
						throw new GameException( 'tried to warp ${warp.amount} units from (${origin.x}, ${origin.y}) into a recycler' );
					} else if( originUnit.availableCount < warp.amount ) {
						throw new GameException( 'tried to warp ${warp.amount} units from (${origin.x}, ${origin.y}) where only ${originUnit.availableCount} were available' );
					} else if( grid.getCoord( target ) == Cell.NO_CELL ) {
						throw new GameException( 'tried to warp ${warp.amount} units from (${origin.x}, ${origin.y}) to oblivion' );
					} else if( grid.getCoord( target ).isHole()) {
						throw new GameException( 'tried to warp ${warp.amount} units from (${origin.x}, ${origin.y}) to a grass tile in (${target.x}, ${target.y})' );
					} else if( player.warpCooldown > 0 ) {
						throw new GameException( 'tried to warp ${warp.amount} units from (${origin.x}, ${origin.y}) while the cooldown wasn\'t completed' );
					} else if( origin.equals( target )) {
						throw new GameException( 'tried to warp ${warp.amount} units from (${origin.x}, ${origin.y}) to the same tile' );
					} else {
						originUnit.availableCount -= warp.amount;
						player.placeUnits( target, warp.amount );
						fightLocations.set( target, true );

						launchMoveEvent( origin, target, warp.amount, player );
						player.warpCooldown = cost;
					}
				} catch( e:GameException) {
					gameSummaryManager.addError( player, e.message );
				}
			}
			if( player.warpCooldown > 0 ) {
				player.warpCooldown--;
				resetEarlyTurnCounter();
			}
		}
	}

	function doSpawn() {
		final spawnStartTime = animation.frameTime;
		for( player in gameManager.getActivePlayers()) {
			animation.frameTime = spawnStartTime;

			final actualSpawns = new HashMap<Coord, Int>();

			for( spawn in player.spawns ) {
				final spawnCost = Config.COST_UNIT * spawn.amount;
				final target = spawn.pos;

				try {
					if( !grid.isOwner( target, player )) {
						throw new GameException( 'tried to spawn ${spawn.amount} units at (${target.x}, ${target.y}), which is not owned by the player' );
					} else if( getRecyclerAt( target ) != Recycler.NO_RECYCLER ) {
						throw new GameException( 'tried to spawn ${spawn.amount} units at (${target.x}, ${target.y}), into a recycler' );
					} else if( player.money < spawnCost ) {
						throw new GameException( 'tried to spawn ${spawn.amount} units at (${target.x}, ${target.y}), but has not enough matter' );
					} else if( spawn.amount == 0 ) {
						throw new GameException( 'tried to spawn a 0 amount of units at (${target.x}, ${target.y})' );
					} else {
						player.placeUnits( target, spawn.amount );
						player.money -= spawnCost;
						Coord.compute( actualSpawns, target, ( k, v:Null<Int> ) -> ( v == null ? 0 : v ) + spawn.amount );
					}
				} catch( e:GameException ) {
					gameSummaryManager.addError( player, e.message );
				}
			}

			for( coord => amount in actualSpawns ) {
				launchSpawnEvent( coord, amount, player );
				fightLocations.set( coord, true );
			}
		}
	}
	
	public function onEnd() {
		for( player in players ) {
			if( player.isActive ) player.score = getOwnedCells( player );
			else player.score = -1;
		}

		endScreenModule.setScores( players.map( player -> player.score ));
	}

	public function getRecyclerAt( coord:Coord ) {
		for( recycler in recyclers ) if( recycler.coord.equals( coord )) return recycler;
		return Recycler.NO_RECYCLER;
	}
	
	function getExcavatorAt( x:Int, y:Int ) {
		final coord = new Coord(x, y);
		return getRecyclerAt(coord);
	}

	public function getWarpCost( origin:Coord, target:Coord, player:Player ) {
		final targetOwner = grid.getCoord( target ).owner;
		var coeff = 0.0;
		if( targetOwner != Player.NO_PLAYER ) {
			coeff = 1;
		} else if( targetOwner == player ) {
			coeff = 0.5;
		} else {
			coeff = 2;
		}
		
		return MathUtils.max(0, int( Config.COST_WARP * (origin.manhattanTo( target.x, target.y ) - 1) * coeff ));
	}

	function computeEvents() {
		final minTime = 1000;

		animation.catchUp();

		final frameTime = MathUtils.max( animation.frameTime, minTime );
		gameManager.frameDuration = frameTime;
	}

	public function isKeyFrame() return true;

	public static function getExpected( playerOutput:String ) {
		final attempt = playerOutput.toUpperCase();
		
		if (attempt.startsWith("MOVE")) return "MOVE <n> <x1> <y1> <x2> <y2>";
		if (attempt.startsWith("SPAWN")) return "SPAWN <n> <x> <y>";
		if (attempt.startsWith("BUILD")) return "BUILD <x> <y>";
		if (attempt.startsWith("MESSAGE")) return "MESSAGE <text>";
		if (attempt.startsWith("WAIT")) return "WAIT";
		
		return "MOVE |"
			+ " SPAWN |"
			+ " BUILD |"
			+ " MESSAGE |"
			+ " WAIT";
	}
}