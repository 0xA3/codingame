package ai.data;

import CodinGame.printErr;
import ai.data.TrollState;
import xa3.math.Pos;

class Troll {
	
	public final id:Int;
	public final index:Int;
	public final player:Int;
	public final board:Board;

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

	public var carrySum = 0;
	
	var job = Idle;
	public var state = Idle;

	public function new( id:Int, index:Int, player:Int, board:Board ) {
		this.id = id;
		this.index = index;
		this.player = player;
		this.board = board;
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

		carrySum = carryPlum + carryLemon + carryApple + carryBanana + carryIron + carryWood;
	}

	public function setJob( job:TrollState ) {
		printErr( 'troll $id setJob $job' );
		this.job = job;
	}

	public function go() {
		switch job {
			case Idle: return "";
			case Mining: return goMining();
			case Harvesting ( fruit ): return goHarvesting( fruit);
			case Chopping: return goChopping();
		}
	}

	function goChopping() {
		if( carrySum == carryCapacity ) return goToShack();
		else { // go to to tree
			final closestTree = findClosestTree( TFruit.ANY );
			if( closestTree != Tree.NO_TREE ) {
				if( closestTree.pos == pos ) {
					printErr( 'troll ${id} chop' );
					return 'CHOP ${id}';
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
			final closestTree = findClosestTree( fruit );
			if( closestTree != Tree.NO_TREE ) {
				if( closestTree.pos == pos ) {
					printErr( 'troll ${id} harvest' );
					return 'HARVEST ${id}';
				} else {
					final pathToTree = board.getPath( pos, closestTree.pos );
					return evaluatePath( pathToTree, "Tree" );
				}
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
					printErr( 'troll ${id} mine' );
					return 'MINE ${id}';
				} else {
					final pathToIron = board.getPath( pos, closestIron );
					return evaluatePath( pathToIron, "Iron" );
				}
			}
		}

		return "";
	}

	function goToShack() {
		final pathToShack = board.getPath( pos, board.myShack );
		if( pathToShack.length == 2 ) {
			return 'DROP ${id}';
		} else return evaluatePath( pathToShack, "Shack" );
	}

	function evaluatePath( path:Array<Pos>, target:String ) {
		if( path.length == 0 ) {
			printErr( 'Error: no path from troll ${id}: ${pos} to $target' );
			return "";
		} else if( path.length == 1 ) {
			printErr( 'Error: troll is already at $target' );
			return "";
		} else {
			final nextPathPos = path[1];
			final nextPos = findNextPos( pos, nextPathPos, board.myShack );
			return 'MOVE ${id} ${nextPos.x} ${nextPos.y}';
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
	
	function findClosestTree( fruit:TFruit ) {
		var closestTree = Tree.NO_TREE;
		var closestDistance = board.boardWidth * board.boardHeight;
		for( tree in board.trees ) {
			if( tree.fruits == 0 ) continue;
			if( board.targetTrees.exists( tree.pos )) continue;
			if( fruit != TFruit.ANY && tree.type != fruit ) continue;

			final distance = board.getDistance( pos, tree.pos );
			if( distance == -1 ) printErr( 'Error: no path from troll ${id}: ${pos} to tree ${tree.pos}' );
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
		for( ironNeighborPos in board.ironNeighbors ) {
			final distance = board.getDistance( pos, ironNeighborPos );
			if( distance == -1 ) printErr( 'Error: no path from troll ${id}: ${pos} to ironNeighbor $ironNeighborPos' );
			else if( distance < closestDistance ) {
				closestIronNeighborPos = ironNeighborPos;
				closestDistance = distance;
			}
		}
		
		return closestIronNeighborPos;
	}

	public function getFruit() {
		if( carryPlum > 0 ) return TFruit.PLUM;
		if( carryLemon > 0 ) return TFruit.LEMON;
		if( carryApple > 0 ) return TFruit.APPLE;
		if( carryBanana > 0 ) return TFruit.BANANA;
		return TFruit.NONE;
	}
}