package test;

using buddy.Should;

@:access(Main)
class TestHit extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test HitSquare", {
			
            it( "10 0 0", {
                Main.hitSquare( 10, 0, 0 ).should.be( true );
			});
            
            it( "10 11 0", {
                Main.hitSquare( 10, 11, 0 ).should.be( false );
			});
            
            it( "10 0 11", {
                Main.hitSquare( 10, 0, 11 ).should.be( false );
			});
            
            it( "10 -4 -5", {
                Main.hitSquare( 10, -4, -5 ).should.be( true );
			});
            
            it( "10 -40 -50", {
                Main.hitSquare( 10, -40, -50 ).should.be( false );
			});
            
		});

		describe( "Test HitCircle", {
			
            it( "10 0 0", {
                Main.hitCircle( 10, 0, 0 ).should.be( true );
			});
            
            it( "10 11 0", {
                Main.hitCircle( 10, 11, 0 ).should.be( false );
			});
            
            it( "10 -10 -1", {
                Main.hitCircle( 10, -10, -1 ).should.be( false );
			});
            
		});

		describe( "Test HitDiamond", {
			
            it( "10 0 0", {
                Main.hitDiamond( 10, 0, 0 ).should.be( true );
			});
            
            it( "10 11 0", {
                Main.hitDiamond( 10, 11, 0 ).should.be( false );
			});
            
            it( "10 5 5", {
                Main.hitDiamond( 10, 5, 5 ).should.be( true );
			});
            
            
		});

	}
}