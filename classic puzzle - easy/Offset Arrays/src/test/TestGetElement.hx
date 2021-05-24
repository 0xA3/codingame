package test;

using buddy.Should;

@:access(Main)
class TestGetElement extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test getElement", {
			
			final assignments = Main.mapAssignments([
				"A[0..2] = 1 2 3",
				"B[-1..1] = 1 2 3",
				"C[3..7] = 3 4 5 6 7",
				"D[-2..1] = 1 2 3 4",
				"ARR[-5..-3] = 11 22 33"
			]);
			
			it( "A", { Main.getElement( "A", 0 ).should.be( 1 ); });
			it( "B", { Main.getElement( "B", 0 ).should.be( 2 ); });
			it( "C", { Main.getElement( "C", 4 ).should.be( 4 ); });
			it( "D", { Main.getElement( "D", 0 ).should.be( 3 ); });
			it( "ARR", { Main.getElement( "ARR", -4 ).should.be( 22 ); });


		});
			
	}

}

