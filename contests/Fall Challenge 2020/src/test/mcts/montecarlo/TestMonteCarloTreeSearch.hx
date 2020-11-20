package test.mcts.montecarlo;

import game.data.Action;
import mcts.montecarlo.MonteCarloTreeSearch;
import mcts.tree.Tree;
import game.data.Player;
import game.data.Board;
import mcts.montecarlo.State;
import mcts.tree.Node;

using buddy.Should;

@:access(mcts.montecarlo.MonteCarloTreeSearch)
class TestMonteCarloTreeSearch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test MonteCarloTreeSearch", {

			it( "Test updateNode add action", {
				final rootNode = createNode();
				final tree = new Tree( rootNode );
				final mcts = new MonteCarloTreeSearch( tree );

				mcts.updateNode([1 => new Action( 1, Brew )]);
				rootNode.childArray.length.should.be( 1 );
				// trace( tree );
			});

			it( "Test updateNode remove action", {
				final rootNode = createNode();
				final tree = new Tree( rootNode );
				final mcts = new MonteCarloTreeSearch( tree );
				
				final testAction = new Action( 1, Brew );
				rootNode.state.board.actions.set( testAction.actionId, testAction );

				final childNode = createNode();
				childNode.state.board.totalMoves = 1;
				childNode.state.board.action = testAction;
				rootNode.childArray.push( childNode );
				
				// trace( tree );
				
				mcts.updateNode([]);
				rootNode.childArray.length.should.be( 0 );
			});

			it( "Test updateNode add and remove action", {
				final rootNode = createNode();
				final tree = new Tree( rootNode );
				final mcts = new MonteCarloTreeSearch( tree );

				final testAction1 = new Action( 1, Brew );
				rootNode.state.board.actions.set( testAction1.actionId, testAction1 );
				
				final testAction2 = new Action( 2, Brew );
				
				final childNode = createNode();
				childNode.state.board.totalMoves = 1;
				childNode.state.board.action = testAction1;
				rootNode.childArray.push( childNode );

				// trace( tree );
				
				mcts.updateNode([testAction2.actionId => testAction2]);
				rootNode.childArray.length.should.be( 1 );
				
				// trace( tree );
			});

		});

	}

	function createNode() {
		return new Node( new State( new Board( new Player(), new Player(), [])), []);
	}

}
