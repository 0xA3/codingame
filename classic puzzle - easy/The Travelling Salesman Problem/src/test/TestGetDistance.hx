package test;

using buddy.Should;

@:access(Main)
class TestGetDistance extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test GetDistance", {
			
            it( "0,0 - 0,0", {
                Main.distance({ x: 0, y: 0 }, { x: 0, y: 0 }).should.be( 0 );
			});
            
            it( "0,0 - 1,0", {
                Main.distance({ x: 0, y: 0 }, { x: 1, y: 0 }).should.be( 1 );
			});
            
            it( "0,0 - 1,1", {
                Main.distance({ x: 0, y: 0 }, { x: 1, y: 1 }).should.be( Math.sqrt( 2 ));
			});
            
            it( "0,0 - -1,-1", {
                Main.distance({ x: 0, y: 0 }, { x: -1, y: -1 }).should.be( Math.sqrt( 2 ));
			});
            
            it( "10,10 - 20, 20", {
                Main.distance({ x: 10, y: 10 }, { x: 20, y: 20 }).should.be( Math.sqrt( 200 ));
			});
            
            
		});

	}
}