package test;

using buddy.Should;

@:access(Main)
class TestRivers extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Rivers", {
			
            it( "Value 20 NO", {
				Main.checkRiversBelow( 20 ).should.be( false );
			});
            
            it( "Value 13 YES", {
				Main.checkRiversBelow( 13 ).should.be( true );
			});
            
            it( "Value 984 NO", {
				Main.checkRiversBelow( 984 ).should.be( false );
			});
            
            it( "Value 1006 NO", {
				Main.checkRiversBelow( 1006 ).should.be( false );
			});
            
            it( "Value 9915 YES", {
				Main.checkRiversBelow( 9915 ).should.be( true );
			});
            
		});

	}
}