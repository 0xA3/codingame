package ai.versions;

import CodinGame.printErr;
import Std.int;
import ai.contexts.WarCry;
import ai.data.Board;
import ai.data.Inventory;
import ai.data.Tree;
import ai.data.Troll;
import xa3.math.Pos;
import ya.Set;

using xa3.math.IntMath;

// MOVE id x y Move troll id to cell (x, y).
// HARVEST id Make troll id harvest on its current cell.
// PLANT id type Make troll id plant a type on its current cell: PLUM, LEMON, APPLE or BANANA.
// PICK id type Make troll id pick one type from the shack: PLUM, LEMON, APPLE or BANANA.
// DROP id Make troll id drop all carried items at the shack.
// TRAIN moveSpeed carryCapacity harvestPower chopPower Train a new troll with the given attributes.
// WAIT to do nothing.
// MSG text to display a message in the replay.

class Ai2 {

	public var aiId = "Ai2";
	final outputs:Array<String> = [];

	var board:Board;
	var myInventory:Inventory;
	var myTrolls:Array<Troll>;
	var trees:Array<Tree>;
	var treesMap:Map<Pos, Tree>;
	
	var turn = 1;
	final targetTrees:Map<Pos, Bool> = [];
	final targetCells:Set<Pos> = [];
	final warCry = new WarCry();
	
	public function new() {	}

	public function setGlobalInputs( board:Board ) {
		this.board = board;
	}

	public function setInputs( myInventory:Inventory, myTrolls:Array<Troll>, trees:Array<Tree>, treesMap:Map<Pos, Tree> ) {
		this.myInventory = myInventory;
		this.myTrolls = myTrolls;
		this.trees = trees;
		this.treesMap = treesMap;
		outputs.splice( 0, outputs.length );
		targetTrees.clear();
		targetCells.clear();
	}

	public function process() {
		for( troll in myTrolls ) {
			var c = "";
			if( troll.carrySum == troll.carryCapacity ) {
				// return to shack and drop
				final pathToShack = board.getPath( troll.pos, board.myShack );
				if( pathToShack.length == 0 ) printErr( 'Error: no path from troll ${troll.id}: ${troll.pos} to ${board.myShack}' );
				else if( pathToShack.length > 2 ) {
					final nextPathPos = pathToShack[1];
					final nextPos = findNextPos( troll.pos, nextPathPos, board.myShack );
					targetCells.add( nextPos );
					
					printErr( 'troll ${troll.id} pos ${troll.pos} return to shack ${nextPos.x} ${nextPos.y}' );
					c = 'MOVE ${troll.id} ${nextPos.x} ${nextPos.y}';
				} else {
					if( !treesMap.exists( troll.pos ) ) {
						final fruit = troll.getFruit();
						if( fruit != NONE ) {
							printErr( 'troll ${troll.id} pos ${troll.pos} plant $fruit' );
							c = 'PLANT ${troll.id} ${fruit}';
						} else {
							printErr( 'troll ${troll.id} pos ${troll.pos} drop' );
							c = 'DROP ${troll.id}';
						}
					} else {
						printErr( 'troll ${troll.id} pos ${troll.pos} drop' );
						c = 'DROP ${troll.id}';
					}
				}
			} else {
				// got to tree and harvest
				final closestTree = findClosestTree( troll );
				if( closestTree != Tree.NO_TREE ) {
					targetTrees.set( closestTree.pos, true );
					if( closestTree.pos == troll.pos ) {
						printErr( 'troll ${troll.id} harvest' );
						c = 'HARVEST ${troll.id}';
					} else {
						final pathToTree = board.getPath( troll.pos, closestTree.pos );
						if( pathToTree.length == 0 ) printErr( 'Error: no path from troll ${troll.id}: ${troll.pos} to tree ${closestTree.pos}' );
						if( pathToTree.length == 1 ) printErr( 'Error: troll is already at tree' );
						else {
							final nextPathPos = pathToTree[1];
							final nextPos = findNextPos( troll.pos, nextPathPos, closestTree.pos );
							targetCells.add( nextPos );

							printErr( 'troll ${troll.id} move to tree ${nextPos.x} ${nextPos.y}' );
							c = 'MOVE ${troll.id} ${nextPos.x} ${nextPos.y}';
						}
					}
				}
	
			}
			if( c != "" ) outputs.push( c );
		}
		
		if( turn < 150 ) {
			final maxSpeed = int( Math.sqrt( myInventory.plum - myTrolls.length ));
			final maxCarry = int( Math.sqrt( myInventory.lemon - myTrolls.length ));
			final maxHarvest = int( Math.sqrt( myInventory.apple - myTrolls.length ));
			// final maxChop = int( Math.sqrt( myInventory.banana - myTrolls.length ));
			if( maxSpeed > 0 && maxCarry > 0 && maxHarvest > 0 ) {
				final c = 'TRAIN $maxSpeed $maxCarry $maxHarvest 0';
				outputs.push( c );
			}
		}

		final warcry = warCry.get();

		turn++;

		return ( warcry != "" ? 'MSG $warcry;' : "" ) + ( outputs.length == 0 ? "WAIT" : outputs.join(";"));
	}

	function findClosestTree( troll:Troll ) {
		var closestTree = Tree.NO_TREE;
		var closestDistance = board.boardWidth * board.boardHeight;
		for( tree in trees ) {
			if( tree.fruits == 0 ) continue;
			if( targetTrees.exists( tree.pos ) ) continue;

			final distance = board.getDistance( troll.pos, tree.pos );
			if( distance == -1 ) throw 'Error: no path from troll ${troll.id}: ${troll.pos} to tree ${tree.pos}';
			else if( distance < closestDistance ) {
				closestTree = tree;
				closestDistance = distance;
			}
		}

		return closestTree;
	}

	function findNextPos( trollPos:Pos, desiredPos:Pos, target:Pos ) {
		if( !targetCells.contains( desiredPos )) return desiredPos;

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
}