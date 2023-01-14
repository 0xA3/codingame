package test;

import Main;

using buddy.Should;

@:access(Main)
class TestGetPartitions extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test GetPartitions", {

			it( "Test 1" , {
				Main.getPartitions([ 1 ]).toString().should.be( '[1]' );
			});

			it( "Test 1 2" , {
				Main.getPartitions([ 1, 2 ]).toString().should.be( '[1,1,2]');
			});

			it( "Test 2 5 10" , {
				Main.getPartitions([ 2, 5, 10 ]).toString().should.be( '[2,3,5,5,8,10]');
			});

			it( "Test 3 5" , {
				Main.getPartitions([ 3, 5 ]).toString().should.be( '[2,3,5]');
			});

		});
	}

}
/*
[ 1, 2 ]

[ 0, 1, 10 ]
1 - 0 = 1
2 - 0 = 2
2 - 1 = 1

*/