package ai.versions;

import CodinGame.printErr;
import ai.data.Board;
import ai.data.Tree;
import ai.data.Troll;
import xa3.math.Pos;
import ya.Set;

class AiWood2 {

	public var aiId = "AiWood2";
	final outputs:Array<String> = [];
	
	var board:Board;
	var myTrolls:Array<Troll>;
	var trees:Array<Tree>;
	
	var turn = 1;

	public function new() { }

	public function setGlobalInputs( board:Board ) {
		this.board = board;
	}

	public function setInputs( myTrolls:Array<Troll>, trees:Array<Tree> ) {
		this.myTrolls = myTrolls;
		this.trees = trees;
		outputs.splice( 0, outputs.length );
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
						printErr( 'troll ${troll.id} drop' );
						c = 'DROP ${troll.id}';
					}
				}
			} else {
				// got to tree and harvest
				final closestTree = findClosestTree( troll );
				if( closestTree != Tree.NO_TREE ) {
					if( closestTree.pos == troll.pos ) {
						printErr( 'troll ${troll.id} harvest' );
						c = 'HARVEST ${troll.id}';
					} else {
						printErr( 'troll ${troll.id} move to tree ${closestTree.pos.x} ${closestTree.pos.y}' );
						c = 'MOVE ${troll.id} ${closestTree.pos.x} ${closestTree.pos.y}';
					}
				}
	
			}
			if( c != "" ) outputs.push( c );
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

	function findClosestTree( troll:Troll ) {
		var closestTree = Tree.NO_TREE;
		var closestDistance = board.boardWidth * board.boardHeight;
		for( tree in trees ) {
			if( tree.fruits == 0 ) continue;
			final distance = troll.pos.manhattanDistance( tree.pos );
			if( distance < closestDistance ) {
				closestTree = tree;
				closestDistance = distance;
			}
		}

		return closestTree;
	}
}