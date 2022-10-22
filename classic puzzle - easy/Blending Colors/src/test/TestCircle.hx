package test;

import shape.Circle;

using buddy.Should;

@:access(shape.Circle)
class TestCircle extends buddy.BuddySuite{

	public function new() {

		describe( "Test Circle", {
			
			final circle = new Circle( 5, 10, 5, { r: 0, g: 0, b: 0 } );
			final pointOutside:Point = { x: 2, y : 1 }
			final pointOnBorder:Point = { x: 5, y : 5 }
			final pointInside:Point = { x: 5, y : 6 }
			
			it( "point outside border", { circle.pointIsOnBorder( pointOutside ).should.be( false ); });
			it( "point outside", { circle.pointIsInside( pointOutside ).should.be( false ); });
			it( "point on border", { circle.pointIsOnBorder( pointOnBorder ).should.be( true ); });
			it( "distance", circle.distance2To( pointInside ).should.be( 4 * 4 ) );
			it( "point inside", { circle.pointIsInside( pointInside ).should.be( true ); });
		});
	}
}
