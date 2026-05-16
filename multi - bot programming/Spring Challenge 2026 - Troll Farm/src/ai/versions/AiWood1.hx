package ai.versions;

import CodinGame.printErr;
import Std.int;
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

class AiWood1 {

	public var aiId = "AiWood1";
	final outputs:Array<String> = [];
	
	var board:Board;
	var myInventory:Inventory;
	var myTrolls:Array<Troll>;
	var trees:Array<Tree>;
	var treePositionsMap:Map<Pos, Tree>;
	
	var turn = 1;
	final targeTFruits:Map<Pos, Bool> = [];

	public function new() { }

	public function setGlobalInputs( board:Board ) {
		this.board = board;
	}

	public function setInputs( myInventory:Inventory, myTrolls:Array<Troll>, trees:Array<Tree>, treePositionsMap:Map<Pos, Tree> ) {
		this.myInventory = myInventory;
		this.myTrolls = myTrolls;
		this.trees = trees;
		this.treePositionsMap = treePositionsMap;
		outputs.splice( 0, outputs.length );
		targeTFruits.clear();
	}

	public function process() {
		for( troll in myTrolls ) {
			var c = "";
			if( troll.carrySum == troll.carryCapacity ) {
				final closestShackPos = findClosestShackPos( troll );
				if( closestShackPos != Pos.NO_POS ) {
					// return to shack and drop
					final shackDistance = closestShackPos.manhattanDistance( troll.pos );
					if( shackDistance > 1 ) {
						printErr( 'troll ${troll.id} return to shack ${closestShackPos.x} ${closestShackPos.y}' );
						c = 'MOVE ${troll.id} ${closestShackPos.x} ${closestShackPos.y}';
					} else {
						if( !treePositionsMap.exists( troll.pos ) ) {
							final fruit = troll.getFruit();
							if( fruit != NONE ) {
								printErr( 'troll ${troll.id} plant $fruit' );
								c = 'PLANT ${troll.id} ${fruit}';
							} else {
								printErr( 'troll ${troll.id} drop' );
								c = 'DROP ${troll.id}';
							}
						} else {
							printErr( 'troll ${troll.id} drop' );
							c = 'DROP ${troll.id}';
						}
					}
				}
			} else {
				// got to tree and harvest
				final closesTFruit = findClosesTFruit( troll );
				if( closesTFruit != Tree.NO_TREE ) {
					targeTFruits.set( closesTFruit.pos, true );
					if( closesTFruit.pos == troll.pos ) {
						printErr( 'troll ${troll.id} harvest' );
						c = 'HARVEST ${troll.id}';
					} else {
						printErr( 'troll ${troll.id} move to tree ${closesTFruit.pos.x} ${closesTFruit.pos.y}' );
						c = 'MOVE ${troll.id} ${closesTFruit.pos.x} ${closesTFruit.pos.y}';
					}
				}
	
			}
			if( c != "" ) outputs.push( c );
		}
		
		if( myTrolls.length < 3 ) {
			final maxSpeed = int( Math.sqrt( myInventory.plum - myTrolls.length ));
			final maxCarry = int( Math.sqrt( myInventory.lemon - myTrolls.length ));
			final maxHarvest = int( Math.sqrt( myInventory.apple - myTrolls.length ));
			// final maxChop = int( Math.sqrt( myInventory.banana - myTrolls.length ));
			if( maxSpeed > 0 && maxCarry > 0 && maxHarvest > 0 ) {
				final c = 'TRAIN $maxSpeed $maxCarry $maxHarvest 0';
				outputs.push( c );
			}
		}

		turn++;

		return outputs.length == 0 ? "WAIT" : outputs.join(";");
	}

	function findClosestShackPos( troll:Troll ) {
		var closestShack = Pos.NO_POS;
		var closestDistance = board.boardWidth * board.boardHeight;
		for( shack in board.myShacks ) {
			final distance = troll.pos.manhattanDistance( shack );
			if( distance < closestDistance ) {
				closestShack = shack;
				closestDistance = distance;
			}
		}

		return closestShack;
	}

	function findClosesTFruit( troll:Troll ) {
		var closesTFruit = Tree.NO_TREE;
		var closestDistance = board.boardWidth * board.boardHeight;
		for( tree in trees ) {
			if( tree.fruits == 0 ) continue;
			if( targeTFruits.exists( tree.pos ) ) continue;

			final distance = troll.pos.manhattanDistance( tree.pos );
			if( distance < closestDistance ) {
				closesTFruit = tree;
				closestDistance = distance;
			}
		}

		return closesTFruit;
	}
}