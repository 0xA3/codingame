package ai.data;

import CodinGame.printErr;
import ai.data.Task;
import xa3.math.Pos;

using xa3.math.IntMath;

class Troll {
	
	public final id:Int;
	public final index:Int;
	public final player:Player;
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

	public final tasks = [];
	public var isDoing = Nothing;

	var turn = 0;

	public function new( id:Int, index:Int, player:Player, board:Board, inventory:Inventory ) {
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

		turn++;
	}

	public function addTask( task:Task ) {
		printErr( 'troll $id addTask $task' );
		tasks.push( task );
	}

	public function insertTask( task:Task ) {
		printErr( 'troll $id insertTask $task' );
		tasks.unshift( isDoing );
		isDoing = task;
	}

	public function go() {
		if( isDoing == Nothing ) {
			if( tasks.length > 0 ) {
				isDoing = tasks.shift();
				printErr( 'troll $id change isDoing to $isDoing' );
				printErr( 'troll $id remaining tasks ' + tasks.join( "," ) );
			} else {
				printErr( 'troll $id has no tasks' );
				return "";
			}
		}

		switch isDoing {
			case Chop( player ): return goChopping( player );
			case Drop: return drop();
			case Harvest ( fruit ): return goHarvesting( fruit);
			case Mine: return goMining();
			case Move( targetPos ): return moveTo( targetPos );
			case Nothing: return "";
			case Plant( fruit ): return goPlanting( fruit );
		}
	}

	function drop() {
		printErr( 'troll $id drop' );
		return 'DROP $id';
	}

	function moveTo( targetPos:Pos ) {
		printErr( 'troll $id move to $targetPos' );
		final distance = board.getDistance( pos, targetPos );
		if( distance <= movementSpeed ) finishTask();
		return 'MOVE $id ${targetPos.x} ${targetPos.y}';
	}

	function goChopping( player:Player ) {
		if( carrySum == carryCapacity ) {
			return returnToShack();
		} else { // go to to tree
			final closestTree = findClosestTree( TResource.ANY, player, 0, carryCapacity );
			if( closestTree != Tree.NO_TREE ) {
				if( closestTree.pos == pos ) {
					printErr( 'troll $id chop' );
					if( closestTree.health <= chopPower ) chopCounter++;
					return 'CHOP $id';
				} else {
					final pathToTree = board.getPath( pos, closestTree.pos );
					return evaluatePath( pathToTree, "Tree" );
				}
			}
		}

		return "";
	}

	function goHarvesting( fruit:TResource ) {
		if( carrySum == carryCapacity ) return returnToShack();
		else { // go to to tree
			final closestTree = findClosestTree( fruit, AnyPlayer, 1 );
			if( closestTree != Tree.NO_TREE ) {
				if( closestTree.pos == pos ) {
					printErr( 'troll $id harvest' );
					return 'HARVEST $id';
				} else {
					final pathToTree = board.getPath( pos, closestTree.pos );
					printErr( 'troll $id $isDoing path to tree ${closestTree.pos}' );
					return evaluatePath( pathToTree, "Tree" );
				}
			} else {
				printErr( 'troll $id no $fruit tree to harvest' );
				// if( tasks.length > 0 ) {
				// 	tasks.push( isDoing );
				// 	isDoing = tasks.shift();
				// 	go();
				// } else {
					switch isDoing {
					case Harvest( ANY ): return "";
					default:
						isDoing = Harvest( ANY );
						go();
					}
				// }
			}
		}
		return "";
	}

	function goMining() {
		if( carrySum == carryCapacity ) return returnToShack();
		else { // go to cell next to iron
			final closestIron = findClosestIronNeighbor();
			if( closestIron != Pos.NO_POS ) {
				if( closestIron == pos ) {
					printErr( 'troll $id mine' );
					return 'MINE $id';
				} else {
					final pathToIron = board.getPath( pos, closestIron );
					printErr( 'troll $id to to mine $closestIron' );
					return evaluatePath( pathToIron, "Iron" );
				}
			}
		}

		return "";
	}

	function goPlanting( fruit:TResource ) {
		final carryFruit = switch fruit {
			case PLUM: carryPlum;
			case LEMON: carryLemon;
			case APPLE: carryApple;
			case BANANA: carryBanana;
			case IRON: throw 'Error: troll $id cannot plant iron';
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
			final plantPos = board.getPlantPosition( pos );
			if( pos == plantPos ) {
				final fruitToPlant = fruit == TResource.ANY ? getAnyFruit() : fruit;
				printErr( 'troll $id plant $fruitToPlant' );
				if( fruitToPlant == TResource.NONE ) {
					printErr( 'Error: troll $id has no fruit to plant' );
					return "";
				}
				finishTask();
				plantCounter++;
				return 'PLANT $id $fruitToPlant';
			}
			
			printErr( 'troll $id plant $plantPos distance ${board.getDistance( pos, plantPos )}' );
			final pathToPlant = board.getPath( pos, plantPos );
			return evaluatePath( pathToPlant, "Plant" );
		}

		return "";
	}

	function getFruit( fruit:TResource ) {
		printErr( 'troll $id has fruit in inventory' );
		final shackDistance = board.getDistance( pos, board.myShack );
		final closestTree = findClosestTree( fruit, AnyPlayer, 1 );
		
		if( closestTree == Tree.NO_TREE ) return getFruitFromShack( fruit );
		final treeDistance = board.getDistance( pos, closestTree.pos );

		// compare shack distance with tree distance
		if( shackDistance < treeDistance ) {
			return getFruitFromShack( fruit);
		} else {
			return goHarvesting( fruit );
		}
	}

	function getFruitFromShack( fruit:TResource ) {
		final shackDistance = board.getDistance( pos, board.myShack );
		if( shackDistance <= 1 ) {
			final fruitToPick = fruit == ANY ? inventory.getAnyFruit() : fruit;
			printErr( 'troll $id pick fruit from shack' );
			return fruitToPick == NONE ? "" : 'PICK $id $fruitToPick';
		} else {
			final pathToShack = board.getPath( pos, board.myShack );
			printErr( 'troll $id go to my shack' );
			return evaluatePath( pathToShack, "Shack" );
		}
	}

	function returnToShack() {
		final pathToShack = board.getPath( pos, board.myShack );
		if( pathToShack.length == 2 ) {
			finishTask();
			return 'DROP $id';
		} else {
			printErr( 'troll $id return to my shack' );
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
			final step = movementSpeed.min( path.length - 1 );
			final nextPathPos = path[step];
			final nextPos = nextPathPos;
			// final nextPos = findNextPos( pos, nextPathPos, board.myShack );
			// if( board.occupiedPositions.contains( nextPathPos ) ) printErr( 'troll $id $nextPathPos is OCCUPIED change to $nextPos' );

			board.occupiedPositions.add( nextPos );
			printErr( 'troll $id nextPos $nextPos' );
			return 'MOVE $id ${nextPos.x} ${nextPos.y}';
		}
	}

	function findNextPos( trollPos:Pos, desiredPos:Pos, target:Pos ) {
		if( !board.occupiedPositions.contains( desiredPos )) return desiredPos;

		final neighbors = board.getReacheableNeighbors( trollPos, movementSpeed );
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
	
	function findClosestTree( fruit:TResource, nearPlayer:Player, minFruits = 1, minSize = 1 ) {
		var closestTree = Tree.NO_TREE;
		var closestDistance = board.boardWidth * board.boardHeight;
		for( tree in board.trees ) {
			if( fruit != TResource.ANY && tree.type != fruit ) continue;
			if( board.targetTrees.exists( tree.pos )) continue;
			if( board.occupiedPositions.contains( tree.pos )) continue;
			
			switch nearPlayer {
				case Me: if( tree.isNearPlayer != Me ) continue;
				case Opp: if( tree.isNearPlayer != Opp ) continue;
				default: // no_op
			}

			final distance = board.getDistance( pos, tree.pos );
			if( distance == -1 ) {
				printErr( 'Error: no path from troll $id: ${pos} to tree ${tree.pos}' );
				continue;
			}
			
			final framesToTree = Math.ceil( distance / movementSpeed );
			final futureSize = tree.getSizeAfter( framesToTree );
			final futureFruits = tree.getFruitsAfter( framesToTree );
			// printErr( 'tree at ${tree.pos} distance $distance size ${tree.size} fruits ${tree.fruits} futureSize $futureSize futureFruits $futureFruits' );
			if( futureSize < minSize ) continue;
			if( futureFruits < minFruits ) continue;

			if( distance < closestDistance ) {
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
		if( carryPlum > 0 ) return TResource.PLUM;
		if( carryLemon > 0 ) return TResource.LEMON;
		if( carryApple > 0 ) return TResource.APPLE;
		if( carryBanana > 0 ) return TResource.BANANA;
		return TResource.NONE;
	}

	inline function finishTask() {
		printErr( 'troll $id completed task $isDoing' );
		isDoing = Nothing;
	}
}