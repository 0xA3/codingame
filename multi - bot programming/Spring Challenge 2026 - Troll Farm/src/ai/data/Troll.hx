package ai.data;

import CodinGame.printErr;
import ai.data.TrollState;
import xa3.math.Pos;

class Troll {
	
	public final id:Int;
	public final index:Int;
	public final player:Int;
	public final board:Board;
	public final inventory:Inventory;

	public var pos = Pos.NO_POS;
	public var movementSpeed = 0;
	public var carryCapacity = 0;
	public var harvestPower = 0;
	public var chopPower = 0;
	public var carryPlum = 0;
	public var carryLemon = 0;
	public var carryApple = 0;
	public var carryBanana = 0;
	public var carryIron = 0;
	public var carryWood = 0;

	public var carryFruitSum = 0;
	public var carrySum = 0;
	public var plantCounter = 0;
	public var chopCounter = 0;

	var job = Idle;

	public function new( id:Int, index:Int, player:Int, board:Board, inventory:Inventory ) {
		this.id = id;
		this.index = index;
		this.player = player;
		this.board = board;
		this.inventory = inventory;
	}

	public function update(
		pos:Pos,
		movementSpeed:Int,
		carryCapacity:Int,
		harvestPower:Int,
		chopPower:Int,
		carryPlum:Int,
		carryLemon:Int,
		carryApple:Int,
		carryBanana:Int,
		carryIron:Int,
		carryWood:Int
	) {
		this.pos = pos;
		this.movementSpeed = movementSpeed;
		this.carryCapacity = carryCapacity;
		this.harvestPower = harvestPower;
		this.chopPower = chopPower;
		this.carryPlum = carryPlum;
		this.carryLemon = carryLemon;
		this.carryApple = carryApple;
		this.carryBanana = carryBanana;
		this.carryIron = carryIron;
		this.carryWood = carryWood;

		carryFruitSum = carryPlum + carryLemon + carryApple + carryBanana;
		carrySum = carryPlum + carryLemon + carryApple + carryBanana + carryIron + carryWood;
	}

	public function setJob( job:TrollState ) {
		printErr( 'troll $id setJob $job' );
		this.job = job;
	}

	public function go() {
		switch job {
			case Chopping: return goChopping();
			case Idle: return "";
			case Harvesting ( fruit ): return goHarvesting( fruit);
			case Mining: return goMining();
			case Planting( fruit ): return goPlanting( fruit );
		}
	}

	function goChopping() {
		if( carrySum == carryCapacity ) return goToShack();
		else { // go to to tree
			final closestTree = findClosestTree( TFruit.ANY, 0, carryCapacity );
			if( closestTree != Tree.NO_TREE ) {
				if( closestTree.pos == pos ) {
					printErr( 'troll $id chop' );
					chopCounter++;
					return 'CHOP $id';
				} else {
					final pathToTree = board.getPath( pos, closestTree.pos );
					return evaluatePath( pathToTree, "Tree" );
				}
			}
		}

		return "";
	}

	function goHarvesting( fruit:TFruit ) {
		if( carrySum == carryCapacity ) return goToShack();
		else { // go to to tree
			final closestTree = findClosestTree( fruit, 1 );
			if( closestTree != Tree.NO_TREE ) {
				if( closestTree.pos == pos ) {
					printErr( 'troll $id harvest' );
					return 'HARVEST $id';
				} else {
					final pathToTree = board.getPath( pos, closestTree.pos );
					printErr( 'troll $id path to tree ' + pathToTree.join( "," ));
					return evaluatePath( pathToTree, "Tree" );
				}
			} else {
				printErr( 'troll $id no $fruit tree to harvest' );
			}
		}
		return "";
	}

	function goMining() {
		if( carrySum == carryCapacity ) return goToShack();
		else { // go to cell next to iron
			final closestIron = findClosestIronNeighbor();
			if( closestIron != Pos.NO_POS ) {
				if( closestIron == pos ) {
					printErr( 'troll $id mine' );
					return 'MINE $id';
				} else {
					final pathToIron = board.getPath( pos, closestIron );
					printErr( 'troll $id to to mine ' + pathToIron.join( "," ) );
					return evaluatePath( pathToIron, "Iron" );
				}
			}
		}

		return "";
	}

	function goPlanting( fruit:TFruit ) {
		final carryFruit = switch fruit {
			case TFruit.PLUM: carryPlum;
			case TFruit.LEMON: carryLemon;
			case TFruit.APPLE: carryApple;
			case TFruit.BANANA: carryBanana;
			case ANY, NONE: carryFruitSum;
		}

		if( carryFruit == 0 ) { // get fruit
			if( inventory.getFruit( fruit ) == 0 ) { // no fruit in inventory
				printErr( 'troll $id no $fruit fruit in inventory' );
				return goHarvesting( fruit );
			} else {
				return getFruit( fruit );
			}
		} else {
			printErr( 'troll $id is carrying $fruit' );
			for( plantPos in board.plantPositions ) {
				// printErr( 'plantPos $plantPos hasTree ${board.treePositionsMap.exists( pos )}' );
				if( !board.treePositionsMap.exists( plantPos )) {
					if( pos == plantPos ) {
						final fruitToPlant = fruit == TFruit.ANY ? getAnyFruit() : fruit;
						printErr( 'troll $id plant $fruitToPlant' );
						if( fruitToPlant == TFruit.NONE ) {
							printErr( 'Error: troll $id has no fruit to plant' );
							return "";
						}
						return 'PLANT $id $fruitToPlant';
					}
					
					final pathToPlant = board.getPath( pos, plantPos );
					printErr( 'troll $id go to plant location ' + pathToPlant.join( "," ) );
					return evaluatePath( pathToPlant, "Plant" );
				}
			}
		}

		return "";
	}

	function getFruit( fruit:TFruit ) {
		printErr( 'troll $id has fruit in inventory' );
		final shackDistance = board.getDistance( pos, board.myShack );
		
		if( shackDistance <= 1 ) {
			final fruitToPick = fruit == ANY ? inventory.getAnyFruit() : fruit;
			printErr( 'troll $id pick fruit from shack' );
			return fruitToPick == NONE ? "" : 'PICK $id $fruitToPick';
		}
		
		// troll is not at shack
		final closestTree = findClosestTree( fruit, 1 );
		if( closestTree == Tree.NO_TREE ) return goToShack();
		
		final treeDistance = board.getDistance( pos, closestTree.pos );

		// compare shack distance with tree distance
		if( shackDistance < treeDistance ) {
			return goToShack();
		} else {
			return goHarvesting( fruit );
		}
	}

	function goToShack() {
		final pathToShack = board.getPath( pos, board.myShack );
		if( pathToShack.length == 2 ) {
			return 'DROP $id';
		} else {
			printErr( 'troll $id path to shack ' + pathToShack.join( "," ) );
			return evaluatePath( pathToShack, "Shack" );
		}
	}

	function evaluatePath( path:Array<Pos>, target:String ) {
		if( path.length == 0 ) {
			printErr( 'Error: no path from troll $id: ${pos} to $target' );
			return "";
		} else if( path.length == 1 ) {
			printErr( 'Error: troll is already at $target' );
			return "";
		} else {
			final nextPathPos = path[1];
			final nextPos = findNextPos( pos, nextPathPos, board.myShack );
			printErr( 'troll $id nextPos $nextPos' );
			return 'MOVE $id ${nextPos.x} ${nextPos.y}';
		}
	}

	function findNextPos( trollPos:Pos, desiredPos:Pos, target:Pos ) {
		if( !board.targetCells.contains( desiredPos )) return desiredPos;

		final neighbors = board.getWalkableNeighbors( trollPos );
		if( neighbors.length == 0 ) return trollPos;

		neighbors.sort(( a, b ) -> {
			final d1 = a.manhattanDistance( target );
			final d2 = b.manhattanDistance( target );
			if( d1 < d2 ) return -1;
			else if( d1 > d2 ) return 1;
			else return 0;
		});
		
		return neighbors[0];
	}
	
	function findClosestTree( fruit:TFruit, minFruits = 1, minSize = 1 ) {
		var closestTree = Tree.NO_TREE;
		var closestDistance = board.boardWidth * board.boardHeight;
		for( tree in board.trees ) {
			if( tree.size < minSize ) continue;
			if( tree.fruits < minFruits ) continue;
			if( board.targetTrees.exists( tree.pos )) continue;
			if( fruit != TFruit.ANY && tree.type != fruit ) continue;

			final distance = board.getDistance( pos, tree.pos );
			if( distance == -1 ) printErr( 'Error: no path from troll $id: ${pos} to tree ${tree.pos}' );
			else if( distance < closestDistance ) {
				closestTree = tree;
				closestDistance = distance;
			}
		}

		return closestTree;
	}

	function findClosestIronNeighbor() {
		var closestIronNeighborPos = Pos.NO_POS;
		var closestDistance = board.boardWidth * board.boardHeight;
		// printErr( 'ironNeighbors ' + board.ironNeighbors.join( "," ) );
		for( ironNeighborPos in board.ironNeighbors ) {
			final distance = board.getDistance( pos, ironNeighborPos );
			// printErr( 'ironNeighbor $ironNeighborPos distance $distance' );
			if( distance == -1 ) printErr( 'Error: no path from troll $id: ${pos} to ironNeighbor $ironNeighborPos' );
			else if( distance < closestDistance ) {
				closestIronNeighborPos = ironNeighborPos;
				closestDistance = distance;
			}
		}
		// printErr( 'troll $id closestIronNeighborPos $closestIronNeighborPos' );
		return closestIronNeighborPos;
	}

	public function getAnyFruit() {
		if( carryPlum > 0 ) return TFruit.PLUM;
		if( carryLemon > 0 ) return TFruit.LEMON;
		if( carryApple > 0 ) return TFruit.APPLE;
		if( carryBanana > 0 ) return TFruit.BANANA;
		return TFruit.NONE;
	}
}