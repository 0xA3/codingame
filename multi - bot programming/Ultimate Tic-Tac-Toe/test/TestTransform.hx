package test;

using buddy.Should;

class TestTransform extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test getIndex", {
			it( "Test 0 0", Transform.getIndex( 0, 0 ).should.be( 0 ));
			it( "Test 2 2", Transform.getIndex( 2, 2 ).should.be( 0 ));
			it( "Test 3 2", Transform.getIndex( 3, 2 ).should.be( 1 ));
			it( "Test 8 1", Transform.getIndex( 8, 1 ).should.be( 2 ));
			it( "Test 4 8", Transform.getIndex( 4, 8 ).should.be( 7 ));
			it( "Test 8 8", Transform.getIndex( 8, 8 ).should.be( 8 ));
		});

		describe( "Test getLocalX", {
			it( "Test 0", Transform.getLocalX( 0 ).should.be( 0 ));
			it( "Test 1", Transform.getLocalX( 1 ).should.be( 1 ));
			it( "Test 2", Transform.getLocalX( 2 ).should.be( 2 ));
			it( "Test 3", Transform.getLocalX( 3 ).should.be( 0 ));
			it( "Test 8", Transform.getLocalX( 8 ).should.be( 2 ));
		});

		describe( "Test getLocalY", {
			it( "Test 0", Transform.getLocalY( 0 ).should.be( 0 ));
			it( "Test 1", Transform.getLocalY( 1 ).should.be( 1 ));
			it( "Test 2", Transform.getLocalY( 2 ).should.be( 2 ));
			it( "Test 3", Transform.getLocalY( 3 ).should.be( 0 ));
			it( "Test 8", Transform.getLocalY( 8 ).should.be( 2 ));
		});
		
		describe( "Test getGlobalX", {
			it( "Test 0 0", Transform.getGlobalX( 0, 0 ).should.be( 0 ));
			it( "Test 1 0", Transform.getGlobalX( 1, 0 ).should.be( 3 ));
			it( "Test 2 0", Transform.getGlobalX( 2, 0 ).should.be( 6 ));
			it( "Test 2 2", Transform.getGlobalX( 2, 2 ).should.be( 8 ));
			it( "Test 3 2", Transform.getGlobalX( 3, 2 ).should.be( 2 ));
			it( "Test 7 1", Transform.getGlobalX( 7, 1 ).should.be( 4 ));
		});

		describe( "Test getGlobalY", {
			it( "Test 0 0", Transform.getGlobalY( 0, 0 ).should.be( 0 ));
			it( "Test 1 0", Transform.getGlobalY( 1, 0 ).should.be( 0 ));
			it( "Test 2 0", Transform.getGlobalY( 2, 0 ).should.be( 0 ));
			it( "Test 2 2", Transform.getGlobalY( 2, 2 ).should.be( 2 ));
			it( "Test 3 2", Transform.getGlobalY( 3, 2 ).should.be( 5 ));
			it( "Test 7 1", Transform.getGlobalY( 7, 1 ).should.be( 7 ));
		});
	}
}