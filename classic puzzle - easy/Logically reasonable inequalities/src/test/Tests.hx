package test;
import Main;
using buddy.Should;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Tests", {
			
			it( "Test case1", {
				final rows = ['A > B', 'B > C'];
				Main.process( rows ).should.be( "consistent" );
			});
			
			it( "Test case2", {
				final rows = ['A > B', 'B > C', 'C > A'];
				Main.process( rows ).should.be( "contradiction" );
			});

			it( "Test case3", {
				final rows = ['L > Z', 'Z > F', 'F > E', 'E > K', 'L > E'];
				Main.process( rows ).should.be( "consistent" );
			});

			it( "Test case4", {
				final rows = ['Z > F', 'B > Z', 'F > E', 'E > K', 'L > E', 'Z > K', 'K > B', 'B > I', 'P > I', 'I > X'];
				Main.process( rows ).should.be( "contradiction" );
			});

			it( "Test case5", {
				final rows = [ 'B > C', 'A > C', 'C > B' ];
				Main.process( rows ).should.be( "contradiction" );
			});

		});
	}

}

