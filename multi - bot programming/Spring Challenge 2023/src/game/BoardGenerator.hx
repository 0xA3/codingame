package game;

import Std.int;
import haxe.ds.HashMap;
import xa3.MTRandom;
import xa3.MathUtils;

using Lambda;
using xa3.ArrayUtils;

class BoardGenerator {
	
	public static var random:MTRandom;

	public static function generate( random:MTRandom, players:Array<Player> ) {
		BoardGenerator.random = random;

		final board = createEmptyBoard( players );

		addResourceCells( board, players );

		return board;
	}

	static function createEmptyBoard( players:Array<Player> ) {
		var board:Board;
		var iterations = 1000;

		do {
			board = generatePotentiallyUnconnectedGraph( players );
			iterations--;
		} while( !board.isConnected() && iterations > 0 );

		return board;
	}

	static final VERTICAL_CUTOFF = 0.6;

	public static function generatePotentiallyUnconnectedGraph( players:Array<Player> ) {
		final cells = new HashMap<CubeCoord, Cell>();
		var nextCellIndex = 0;

		final ringCount = random.nextInt( Config.MAP_RING_COUNT_MAX - Config.MAP_RING_COUNT_MIN + 1 ) + Config.MAP_RING_COUNT_MIN;

		// Generate all coords as a hexagon
		final coordList:Array<CubeCoord> = [];
		final coordSet = new HashMap<CubeCoord, Bool>();
		final center = CubeCoord.CENTER;
		coordList.push( center );
		var cur = center.neighbor( 0 );
		final verticalLimit = Math.ceil( ringCount * VERTICAL_CUTOFF );
		for( distance in 1...ringCount ) {
			for( orientation in 0...6 ) {
				for( _ in 0...distance ) {
					if( cur.z > -verticalLimit && cur.z < verticalLimit ) {
						if( !coordSet.exists( cur )) {
							coordList.push( cur );
							coordList.push( cur.getOpposite());
							coordSet.set( cur, true );
							coordSet.set( cur.getOpposite(), true );
						}
					}
					cur = cur.neighbor(( orientation + 2 ) % 6 );
				}
			}
			cur = cur.neighbor( 0 );
		}

		// Create holes
		final coordListSize = coordList.length;
		final wantedEmptyCells = randomPercentage( Config.MIN_EMPTY_CELLS_PERCENT, Config.MAX_EMPTY_CELLS_PERCENT, coordListSize );

		final toRemove = new HashMap<CubeCoord, Bool>();
		var toRemoveSize = 0;
		while( toRemoveSize < wantedEmptyCells ) {
			final randIndex = random.nextInt( coordListSize );
			final randCoord = coordList[randIndex];
			toRemove.set( randCoord, true );
			toRemove.set( randCoord.getOpposite(), true );
			toRemoveSize += 2;

			// TODO: check it's still connected and remove it directly
		}
		for( coord in toRemove.keys()) coordList.remove( coord );

		final CORRIDOR_MODE = random.nextFloat() < 0.05; // 5% chance
		if( CORRIDOR_MODE ) {
			toRemove.clear();
			for( coord in coordList ) {
				if( hasSixNeighbours( coord, coordList )) {
					toRemove.set( coord, true );
				}
			}
			for( coord in toRemove.keys()) coordList.remove( coord );
		}

		final NO_BLOB_MODE = random.nextFloat() < 0.70; // 70% chance
		if( NO_BLOB_MODE ) {
			var changed = true;
			while( changed ) {
				changed = false;
				final blobCenter = coordList.filter( c -> hasSixNeighbours( c, coordList )).findAny();
				switch blobCenter {
				case Some( v ):
					final neighbours = v.neighbors();
					neighbours.shuffle( random );

					coordList.remove( neighbours[0] );
					coordList.remove( neighbours[0].getOpposite() );
					changed = true;
					
				case None: changed = false;
				}
			}
		}

		// Create empty Cells
		for( coord in coordList ) {
			final cell = new Cell( nextCellIndex++, coord );
			cells.set( coord, cell );
		}

		return new Board( cells, ringCount, players );
	}

	static function randomPercentage( min:Int, max:Int, total:Int ) {
		final percentage = min + random.nextInt(( max + 1 ) - min );
		return int( percentage * total / 100 );
	}

	static function hasSixNeighbours( coord:CubeCoord, coordList:Array<CubeCoord> ) {
		return coord.neighbors().filter( c -> coordList.contains( c )).length == 6;
	}

	static function addResourceCells( board:Board, players:Array<Player> ) {
		// Fill center cell
		if( random.nextBool()) {
			final centerCell = board.get( CubeCoord.CENTER );
			if( centerCell == Cell.NO_CELL ) {
				centerCell.setFoodAmount( getLargeFoodAmount());
			}
		}

		// Place anthills
		final hillsPerPlayer = Config.FORCE_SINGLE_HILL ? 1 : ( random.nextFloat() < .33 ? 2 : 1 );

		final validCoords = selectAnthillCoords( board, hillsPerPlayer );

		final player1 = players[0];
		final player2 = players[1];
		for( i in 0...MathUtils.min( hillsPerPlayer, validCoords.length )) {
			final coord = validCoords[i];

			final cell1 = board.map[coord];
			cell1.setAnthill( player1 );
			player1.addAnthill( cell1.getIndex());

			final cell2 = board.map[coord];
			cell2.setAnthill( player2 );
			player2.addAnthill( cell2.getIndex());
		}

		// Place food
		final SURPLUS_MODE = Config.FORCE_SINGLE_HILL ? true : ( random.nextFloat() < 0.1 ); // 10% chance
        final HUNGRY_MODE = Config.FORCE_SINGLE_HILL ? false : ( !SURPLUS_MODE && random.nextFloat() < 0.08 ); // 8% chance
        final FAMINE_MODE = Config.FORCE_SINGLE_HILL ? false : ( !SURPLUS_MODE && !HUNGRY_MODE && random.nextFloat() < 0.04 ); // 4% chance

		if( !FAMINE_MODE ) {
			final validFoodCoords = board.coords.filter( coord -> board.get( coord ).getAnthill() == null );
			var wantedFoodCells = randomPercentage( Config.MIN_FOOD_CELLS_PERCENT, Config.MAX_FOOD_CELLS_PERCENT, validFoodCoords.length );
			wantedFoodCells = MathUtils.max( 2, wantedFoodCells );

			ArrayUtils.shuffle( validFoodCoords, random );
			var i = 0;
			while( i < wantedFoodCells ) {
				final coord = validCoords[i];
				final cell = board.get( coord );
				final roll = random.nextFloat();
				if( roll < 0.65 ) {
					var amount = HUNGRY_MODE ? getSmallFoodAmount() : getLargeFoodAmount();
					if( SURPLUS_MODE ) {
						amount *= Config.FORCE_SINGLE_HILL ? 5 : 10;
					}
					cell.setFoodAmount( amount );
					board.get( coord.getOpposite()).setFoodAmount( amount );
				} else {
					var amount = HUNGRY_MODE ? getSmallFoodAmount() : int( getLargeFoodAmount() / 2 );
					if( SURPLUS_MODE ) {
						amount *= Config.FORCE_SINGLE_HILL ? 5 : 10;
					}
					cell.setFoodAmount( amount );
					board.get( coord.getOpposite()).setFoodAmount( amount );
				}

				i += 2;
			}
		}
		// Make sure there is food on the board
		final boardHasFood = board.cells.anyMatch( cell -> cell.getType() == FOOD );
		if( !boardHasFood ) {
			final emptyCells = board.cells.filter( cell -> cell.getType() == EMPTY && cell.isValid() && cell.getAnthill() == null );
			final randomIndex = random.nextInt( emptyCells.length );
			final emptyCell = emptyCells[randomIndex];
			var amount = getLargeFoodAmount();
			if( SURPLUS_MODE ) {
				amount *= 10;
			}
			emptyCell.setFoodAmount( amount );
			final oppositeCell = board.get( emptyCell.getCoord().getOpposite());
			if( !oppositeCell.getCoord().equals( emptyCell.getCoord())) {
				oppositeCell.setFoodAmount( amount );
			}
		}

		var antPotential = 0;
		if( Config.ENABLE_EGGS ) {
			// Place egg
			final validEggCoords = board.coords.filter( coord -> board.get( coord ).getAnthill() == null && board.get(coord).getRichness() == 0 );
			final wantedEggCells = randomPercentage( Config.MIN_EGG_CELLS_PERCENT, Config.MAX_EGG_CELLS_PERCENT, validEggCoords.length );

			ArrayUtils.shuffle( validEggCoords, random );
			var i = 0;
			while( i < wantedEggCells ) {
				final coord = validEggCoords[i];
				final cell = board.get( coord );
				final roll = random.nextFloat();
				if( roll < 0.4 ) {
					final amount = getLargeEggsAmount();
					cell.setSpawnPower( amount );
					board.get( coord.getOpposite()).setSpawnPower( amount );
					antPotential += amount * 2;
				} else {
					final amount = getSmallEggsAmount();
                    cell.setSpawnPower( amount );
                    board.get( coord.getOpposite()).setSpawnPower( amount );
                    antPotential += amount * 2;
				}
				i += 2;
			}
		}

		// Place ants;
		final antsPerHill = MathUtils.max( 10, 60 - antPotential );
		players.iter( player -> {
			player.anthills.iter( idx -> {
				board.getByIndex( idx ).placeAnts( player, antsPerHill );
			});
		});

		board.setInitialFood( board.getRemainingFood());
	}

	static function getSmallEggsAmount() {
		return 10 + random.nextInt( 10 );
	}

	static function getLargeEggsAmount() {
		return 20 + random.nextInt( 20 );
	}

	static function getSmallFoodAmount() {
		return 10 + random.nextInt( 30 );
	}

	static function getLargeFoodAmount() {
		return 40 + random.nextInt( 20 );
	}

	static function selectAnthillCoords( board:Board, hillsPerPlayer:Int ) {
		var validCoords:Array<CubeCoord> = [];

		var iter = 1000;
		while( validCoords.length < hillsPerPlayer && iter > 0 ) {
			iter--;
			validCoords = trySelectAnthillCoords( board, hillsPerPlayer );
		}
		// Failsafes
		if( validCoords.length < hillsPerPlayer ) {
			validCoords = board.getEdges();
		}
		if( validCoords.length < hillsPerPlayer ) {
			validCoords = board.coords;
		}
		return validCoords;
	}
	
	/**
	 * Select hill positions for player 1 on board edges without food
	 */
	static function trySelectAnthillCoords( board:Board, startingHillCount:Int ) {
		final coordinates:Array<CubeCoord> = [];

		final availableCoords:Array<CubeCoord> = [];
		availableCoords.removeIf( coord -> board.get( coord ).getIndex() == 0 );
		availableCoords.removeIf( coord -> board.get( coord ).getRichness() > 0 );
		var i = 0;
		while( i < startingHillCount && !availableCoords.isEmpty() ) {
			final r = random.nextInt( availableCoords.length );
			final normalCoord = availableCoords[r];
			final oppositeCoord = normalCoord.getOpposite();
			availableCoords.removeIf( coord -> {
				return coord.distanceTo( normalCoord ) <= Config.STARTING_HILL_DISTANCE ||
					coord.distanceTo( oppositeCoord ) <= Config.STARTING_HILL_DISTANCE;
			});
			coordinates.push( normalCoord );
			i++;
		}
		return coordinates;
	 }
}