package test;

using buddy.Should;

@:access(Main)
class TestIsInPolygon extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Quad -100, -100 to 100, 100 ", {
			
               final polygon = [{ x: -100, y: -100 }, { x: 100, y: -100 }, { x: 100, y: 100 }, { x: -100, y: 100 }, ];
                
            it( "test x: 0, y: 0", {
                Main.isInConvexPolygon({ x: 0, y: 0 }, polygon ).should.be( true );
			});
            
            it( "test x: 99, y: 99", {
                Main.isInConvexPolygon({ x: 99, y: 99 }, polygon ).should.be( true );
			});
            
            it( "test x: 101, y: 101", {
                Main.isInConvexPolygon({ x: 101, y: 101 }, polygon ).should.be( false );
			});
            
            it( "test x: 80, y: -101", {
                Main.isInConvexPolygon({ x: 80, y: -101 }, polygon ).should.be( false );
			});
            
            it( "test x: 0, y: -100", {
                Main.isInConvexPolygon({ x: 0, y: -100 }, polygon ).should.be( true );
			});
            
		});

	}
}