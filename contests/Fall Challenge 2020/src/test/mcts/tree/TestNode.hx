package test.mcts.tree;

import game.data.Player;
import game.data.Board;
import mcts.montecarlo.State;
import mcts.tree.Node;
using buddy.Should;

class TestNode extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Node", {

			it( "Test clone", {
				final node = createNode();
				final nodeClone = node.clone();
				nodeClone.should.not.be( node );
			});

			it( "Test clone", {
				final node = createNode();
				node.childArray.push( createNode());
				final nodeClone = node.clone();
				nodeClone.childArray.length.should.be( 1 );
			});

		});

	}

	function createNode() {
		return new Node( new State( new Board( new Player(), new Player(), [])), []);
	}

}
