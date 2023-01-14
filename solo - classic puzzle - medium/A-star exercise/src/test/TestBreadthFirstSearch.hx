package test;

import Main;

using buddy.Should;

@:access( Main )
class TestBreadthFirstSearch extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test BreadthFirstSearch", {

			it( "3-node Graph", {
				
				final input =
				"3 3 0 2
				33 11 0
				0 1 10
				0 2 40
				1 2 20";

				final p = ParseInput.parse( input );
				final nodes = Main.createNodes( p.n, p.distances, p.edges );
				final path = BreadthFirstSearch.getPath( nodes, p.s, p.g );
				path.toString().should.be( "[0,2]" );
			});
	
			it( "Small Graph A", {
				
				final input =
				"5 7 0 4
				7 6 4 2 0
				0 1 1
				0 2 4
				1 2 2
				1 3 5
				1 4 12
				2 3 2
				3 4 3";

				final p = ParseInput.parse( input );
				final nodes = Main.createNodes( p.n, p.distances, p.edges );
				final path = BreadthFirstSearch.getPath( nodes, p.s, p.g );
				path.toString().should.be( "[0,1,4]" );
			});
			
			it( "Small Graph A'", {
				
				final input =
				"5 7 4 0
				0 1 3 5 7
				0 1 1
				0 2 4
				1 2 2
				1 3 5
				1 4 12
				2 3 2
				3 4 3";

				final p = ParseInput.parse( input );
				final nodes = Main.createNodes( p.n, p.distances, p.edges );
				final path = BreadthFirstSearch.getPath( nodes, p.s, p.g );
				path.toString().should.be( "[4,1,0]" );
			});

			it( "Slightly Larger Graph", {
				
				final input =
				"8 10 0 7
				15 10 11 4 4 4 1 0
				0 1 6
				0 2 5
				0 3 10
				5 1 6
				5 2 6
				5 6 4
				4 2 7
				4 3 6
				4 6 6
				6 7 3";

				final p = ParseInput.parse( input );
				final nodes = Main.createNodes( p.n, p.distances, p.edges );
				final path = BreadthFirstSearch.getPath( nodes, p.s, p.g );
				path.toString().should.be( "[0,1,5,6,7]" );
			});

			it( "From Arad To Bucharest", {
				
				final input =
				"20 23 0 1
				366 0 160 242 161 178 77 151 226 244 241 234 380 98 193 253 329 80 199 374
				12 19 71
				12 15 151
				0 19 75
				0 15 140
				0 16 118
				16 9 111
				9 10 70
				10 3 75
				3 2 120
				2 13 138
				2 14 146
				14 13 97
				14 15 80
				15 5 99
				5 1 211
				13 1 101
				1 6 90
				1 17 85
				17 7 98
				7 4 86
				17 18 142
				18 8 92
				8 11 87";

				final p = ParseInput.parse( input );
				final nodes = Main.createNodes( p.n, p.distances, p.edges );
				final path = BreadthFirstSearch.getPath( nodes, p.s, p.g );
				path.toString().should.be( "[0,15,5,1]" );
			});

			it( "Equal f-value", {
				
				final input =
				"4 4 0 3
				5 3 3 0
				0 1 2
				0 2 2
				1 3 4
				2 3 4";

				final p = ParseInput.parse( input );
				final nodes = Main.createNodes( p.n, p.distances, p.edges );
				final path = BreadthFirstSearch.getPath( nodes, p.s, p.g );
				// trace( path );
				path.toString().should.be( "[0,1,3]" );
			});
			
		});
	}
}