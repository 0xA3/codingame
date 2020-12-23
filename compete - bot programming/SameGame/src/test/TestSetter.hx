package test;
import Main;
using buddy.Should;

@:access(Setter)
class TestSetter extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Setter", {

			it( "Test initVisited", {
				final setter = new Setter( 1, [[0]] );
				setter.initVisited();
				setter.visited.toString().should.be( "[[false]]" );
			});

			it( "Test check", {
				final setter = new Setter( 2, [[0, 1], [2, 3]] );
				setter.initVisited();
				setter.check( 0, 0, 0 ).should.be( true );
				setter.check( 1, 1, 3 ).should.be( true );
			});

			it( "Test addNeighbor", {
				final setter = new Setter( 2, [[0, 1], [2, 3]] );
				setter.initVisited();
				final set = [];
				setter.addTile( set, 0, 0 );
				set.length.should.be( 1 );
				set[0].x.should.be( 0 );
				set[0].y.should.be( 0 );
			});

			it( "Test no neighbors with same color", {
				final setter = new Setter( 2, [[0, 1], [1, 1]] );
				setter.initVisited();
				final set = [];
				setter.addTile( set, 0, 0 );
				setter.addSameColorNeighbors( set, 0, 0, 0 );
				set.length.should.be( 1 );
			});
			
			it( "Test addSameColorNeighbors", {
				final setter = new Setter( 3, [[0, 0, 0], [1, 1, 0], [0, 0, 0]] );
				setter.initVisited();
				final set = [];
				setter.addTile( set, 0, 0 );
				setter.addSameColorNeighbors( set, 0, 0, 0 );
				set.length.should.be( 7 );
			});

			it( "Test getSets", {
				final setter = new Setter( 3, [[0, 0, 0], [1, 1, 0], [0, 0, 0]] );
				final sets = setter.getSets();
			});


		});
	}


}