package test.ai;

import xa3.math.Pos;

using buddy.Should;

class TestTree extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Tree getSizeAfter", {
			it( "now", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getSizeAfter( 0 ).should.be( 2 );
			});
			it( "in 1 frame", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getSizeAfter( 1 ).should.be( 2 );
			});
			it( "in 2 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getSizeAfter( 2 ).should.be( 3 );
			});
			it( "in 7 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getSizeAfter( 7 ).should.be( 3 );
			});
			it( "in 8 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getSizeAfter( 8 ).should.be( 4 );
			});
			it( "in 14 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getSizeAfter( 14 ).should.be( 4 );
			});
		});
		
		describe( "Test Tree getHeath", {
			it( "now", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getHealthAfter( 0 ).should.be( 4 );
			});
			it( "in 1 frame", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getHealthAfter( 1 ).should.be( 4 );
			});
			it( "in 2 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getHealthAfter( 2 ).should.be( 5 );
			});
			it( "in 7 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getHealthAfter( 7 ).should.be( 5 );
			});
			it( "in 8 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getHealthAfter( 8 ).should.be( 6 );
			});
			it( "in 14 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getHealthAfter( 14 ).should.be( 6 );
			});
		});
		
		describe( "Test Tree getFruitsAfter", {
			it( "now", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getFruitsAfter( 0 ).should.be( 0 );
			});
			it( "in 13 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getFruitsAfter( 13 ).should.be( 0 );
			});
			it( "in 14 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getFruitsAfter( 14 ).should.be( 1 );
			});
			it( "in 19 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getFruitsAfter( 19 ).should.be( 1 );
			});
			it( "in 20 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getFruitsAfter( 20 ).should.be( 2 );
			});
			it( "in 26 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getFruitsAfter( 26 ).should.be( 3 );
			});
			it( "in 99 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getFruitsAfter( 99 ).should.be( 3 );
			});
		});

		describe( "Test Tree getCooldownAfter", {
			it( "now", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getCooldownAfter( 0 ).should.be( 2 );
			});
			it( "in 1 frame", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getCooldownAfter( 1 ).should.be( 1 );
			});
			it( "in 2 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getCooldownAfter( 2 ).should.be( 6 );
			});
			it( "in 7 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getCooldownAfter( 7 ).should.be( 1 );
			});
			it( "in 8 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getCooldownAfter( 8 ).should.be( 6 );
			});
			it( "in 14 frames", {
				final tree = new ai.data.Tree( "BANANA", Pos.NO_POS );
				tree.update( 2, 4, 0, 2 );
				tree.getCooldownAfter( 14 ).should.be( 6 );
			});
		});

	}
}