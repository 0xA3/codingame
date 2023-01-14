package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test countNum", {
			it( "one 1", ArrayUtils.countNum( [1], 1 ).should.be( 1 ));
			it( "two 1", ArrayUtils.countNum( [1, 1], 1 ).should.be( 2 ));
			it( "four 2", ArrayUtils.countNum( [1, 1, 2, 1, 2, 2, 2], 2 ).should.be( 4 ));
		});

		describe( "Test removeNum", {
			it( "remove one 2", ArrayUtils.removeNum( [1, 2, 1], 2 ).join(" ").should.be( "1 1" ));
			it( "remove three 2", ArrayUtils.removeNum( [1, 1, 2, 1, 2, 2, 2], 2, 3 ).join(" ").should.be( "1 1 1 2" ));
		});

		describe( "Test createNumberArray", {
			it( "one 1", ArrayUtils.createNumberArray( [1] ).join( "" ).should.be( "1" ));
			it( "one 0", ArrayUtils.createNumberArray( [0] ).join( "" ).should.be( "0" ));
			it( "1 0", ArrayUtils.createNumberArray( [1, 0] ).join( "" ).should.be( "10" ));
			it( "0 1", ArrayUtils.createNumberArray( [0, 1] ).join( "" ).should.be( "10" ));
			it( "0 1 0", ArrayUtils.createNumberArray( [0, 1, 0] ).join( "" ).should.be( "100" ));
			it( "0 1 4", ArrayUtils.createNumberArray( [0, 1, 4] ).join( "" ).should.be( "104" ));
		});

		describe( "Test process", {
			it( "Two digits", Main.process( "72" ).should.be( "2 7" ));
			it( "Too many digits", Main.process( "8784688955737839773875997657797875797" ).should.be( "-1 -1" ));
			it( "Maximum B", Main.process( "0800795705000904561000705000000905000" ).should.be( "400005555567778999 1000000000000000000" ));
			it( "Too many 0s", Main.process( "0000000000100000000000" ).should.be( "-1 -1" ));
			it( "Maximum B with 0", Main.process( "10000000000000000000" ).should.be( "0 1000000000000000000" ));
			it( "Small A maximum B", Main.process( "00000004000000000001" ).should.be( "4 1000000000000000000" ));
			it( "Small A big B", Main.process( "79380248390522737902" ).should.be( "20 200223334577788999" ));
			it( "Too many 0s", Main.process( "00000" ).should.be( "-1 -1" ));
			it( "Too few digits", Main.process( "9" ).should.be( "-1 -1" ));
			it( "Too many digits", Main.process( "5879012924529447774473489599650098351318" ).should.be( "-1 -1" ));
			it( "Zero", Main.process( "9407809450087866606" ).should.be( "0 400004566667788899" ));
			it( "Maximum", Main.process( "01000000000000000000000000000000100000" ).should.be( "1000000000000000000 1000000000000000000" ));
			it( "Big with 0s", Main.process( "793802483905227379023997039865762703" ).should.be( "200000222233333345 566777777888999999" ));
			it( "Big", Main.process( "586359799219791388827213577198836291" ).should.be( "111112222333355566 777778888889999999" ));
			it( "Internal zeros", Main.process( "643015425603584835695964326254590" ).should.be( "100022233334444 455555556666688999" ));
			it( "Small A big B", Main.process( "7568656699556657678" ).should.be( "5 555566666667778899" ));
			it( "Small A big B", Main.process( "487656448556467" ).should.be( "4 44455566667788" ));
			it( "Two digits2", Main.process( "99" ).should.be( "9 9" ));
		});
			
	}
		
}

