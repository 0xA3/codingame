package test;

using buddy.Should;

class TestGetPath extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test TestGetPath", {

			it( "test horizontal middle", {
				// Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
				final lines = ["###", " # ", "###"];
				final grid = GridFactory.createGrid( lines[0].length, lines.length, lines );
				final fromIndex = grid.getCellIndex( 0, 1 );
				final toIndex = grid.getCellIndex( 2, 1 );
				final path = grid.getPath( fromIndex, toIndex );
				
				path.cost.should.be( 1 );
			});
		});
	}
}
