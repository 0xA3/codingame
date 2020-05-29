package test;

using buddy.Should;
using Lambda;

@:access(Main)
class TestUniformCostSearch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test UniformCostSearch", {

			it( "3-node Graph 0-2-1 < 0-1", {
				
				final input =
				"3
				3
				0 1 8
				0 2 4
				1 2 2";

				final nodes = ParseInput.parse( input );
				final shortestPaths = UniformCostSearch.getShortestPathsBetweenNodes( nodes );
				shortestPaths["0-1"].length.should.be( 7 );
				shortestPaths["0-1"].edges.length.should.be( 2 );
			});

			it( "3-node Graph 0-2-1 > 0-1", {
				
				final input =
				"3
				3
				0 1 5
				0 2 4
				1 2 2";

				final nodes = ParseInput.parse( input );
				final shortestPaths = UniformCostSearch.getShortestPathsBetweenNodes( nodes );
				shortestPaths["0-1"].length.should.be( 5 );
				shortestPaths["0-1"].edges.length.should.be( 1 );
			});
			@include			
			it( "3-node Graph 0-2-1 = 0-1", {
				
				final input =
				"3
				3
				0 1 7
				0 2 4
				1 2 2";

				final nodes = ParseInput.parse( input );
				final shortestPaths = UniformCostSearch.getShortestPathsBetweenNodes( nodes );
				// trace( shortestPaths );
				shortestPaths["0-1"].length.should.be( 7 );
				shortestPaths["0-1"].edges.length.should.be( 2 );
			});

		});
	}
}