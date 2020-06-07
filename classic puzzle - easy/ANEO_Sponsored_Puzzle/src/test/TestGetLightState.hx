package test;
import Main;
using buddy.Should;

@:access(Main)
class TestGetLightState extends buddy.BuddySuite {
	
	public function new() {

		describe( "TestGetLightState", {

			it( "Test getLightState 1 0 1", {
				Main.isRed( 1, 0, 1 ).should.be( false );
			});

			it( "Test getLightState 1 1 1", {
				Main.isRed( 1, 1, 1 ).should.be( true );
			});

			it( "Test getLightState 1 2 1", {
				Main.isRed( 1, 2, 1 ).should.be( true );
			});

			it( "Test getLightState 1 3 1", {
				Main.isRed( 1, 3, 1 ).should.be( false );
			});

			it( "Test getLightState 1 3 2", {
				Main.isRed( 1, 3, 2 ).should.be( true );
			});

		});
	}

}