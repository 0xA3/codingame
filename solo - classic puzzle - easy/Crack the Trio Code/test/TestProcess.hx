package test;

using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", Main.process( "3,11,12,102,111,120" ).should.be( "1,10,100" ));
			it( "Test 2", Main.process( "1,2,3,4,5,6,7,8,9,10,11,12,13,14" ).should.be( "many" ));
			it( "Test 3", Main.process( "9,10,11,12,13,14,15,16,17,18,19" ).should.be( "4,5,7" ));
			it( "Test 4", Main.process( "27,30,34,37,43,44,46,51,57" ).should.be( "10,17,23" ));
			it( "Validator 4", Main.process( "92,93,94,95,96,97,98,99" ).should.be( "30,32,33" ));
			it( "Test 5", Main.process( "8,16,26,27,42,53,65,69,81,83,88,99" ).should.be( "none" ));
			it( "Test 6", Main.process( "33,61,66,83,95" ).should.be( "17,33,61" ));
			it( "Test 7", Main.process( "69,72,80,81,89" ).should.be( "23,24,33" ));
			it( "Validator 7", Main.process( "65,67,69,75,79,89,99" ).should.be( "21,23,33" ));
			it( "Test 8", Main.process( "1,2,3" ).should.be( "many" ));
		});
	}
}
