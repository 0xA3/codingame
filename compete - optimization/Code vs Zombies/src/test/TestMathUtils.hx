package test;

import Math.PI;
import xa3.MathUtils;

using Lambda;
using StringTools;
using buddy.Should;

class TestMathUtils extends buddy.BuddySuite {
	
	public function new() {
		describe( "Test angle", {
			
			it( "0 0", { MathUtils.angle( 0, 0 ).should.beCloseTo( 0 ); });
			it( "1 0", { MathUtils.angle( 1, 0 ).should.beCloseTo( -PI / 2 ); });
			it( "0 -1", { MathUtils.angle( 0, -1 ).should.beCloseTo( -PI ); });
			it( "-1 0", { MathUtils.angle( -1, 0 ).should.beCloseTo( PI / 2 ); });
			it( "0 1", { MathUtils.angle( 0, 1 ).should.beCloseTo( 0 ); });
			
		});

	}
}

