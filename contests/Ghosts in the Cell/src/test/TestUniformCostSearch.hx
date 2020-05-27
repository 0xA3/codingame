package test;

using buddy.Should;
using Lambda;

@:access(Main)
class TestUniformCostSearch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test UniformCostSearch", {
			@include
			it( "3-node Graph", {
				
				final input =
				"3
				3
				0 1 8
				0 2 4
				1 2 2";

				final nodes = ParseInput.parse( input );
				final shortestPaths = UniformCostSearch.getShortestPathsBetweenNodes( nodes );
				// for( path in paths0 ) {
				// 	trace( 'id ${path.id} cost from 0: ${path.costFromStart} previous ${path.previous}' );
				// }
				trace( shortestPaths );
			});

		});
	}
}