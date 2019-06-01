package test;

import Main.Point;

using buddy.Should;

@:access(Main)
class TestGetNearesPositionDistance extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test GetNearesPositionDistance", {
			
			final p0:Point = { x: 0, y: 0 };
			final p1:Point = { x: 1, y: 0 };

            it( "p0, p1", {
                Main.getNearestPositionDistance( p0, [p0, p1]).position.should.be( p0 );
			});
            
            
		});

	}
}