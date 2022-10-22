package test;

import shape.Square;

using buddy.Should;

@:access(shape.Square)
class TestSquare extends buddy.BuddySuite{

	public function new() {

		describe( "Test Circle", {
			
			final square = new Square( 3, 1, 5, { r: 0, g: 0, b: 0 } );
			final pointOutside:Point = { x: 2, y : 1 }
			final pointOnBorder:Point = { x: 4, y : 1 }
			final pointInside:Point = { x: 4, y : 2 }
			
			it( "point outside border", { square.pointIsOnBorder( pointOutside ).should.be( false ); });
			it( "point outside", { square.pointIsInside( pointOutside ).should.be( false ); });
			it( "point on border", { square.pointIsOnBorder( pointOnBorder ).should.be( true ); });
			it( "point inside", { square.pointIsInside( pointInside ).should.be( true ); });
		});
	}
}
