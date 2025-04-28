package test;

using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test toBijective", {
			it( "1", Main.toBijective( 1 ).should.be( "1" ));
			it( "10", Main.toBijective( 10 ).should.be( "A" ));
			it( "20", Main.toBijective( 20 ).should.be( "1A" ));
			it( "100", Main.toBijective( 100 ).should.be( "9A" ));
			it( "101", Main.toBijective( 101 ).should.be( "A1" ));
			it( "110", Main.toBijective( 110 ).should.be( "AA" ));
			it( "111", Main.toBijective( 111 ).should.be( "111" ));
			it( "200", Main.toBijective( 200 ).should.be( "19A" ));
		});
		
		describe( "Test toDecimal", {
			it( "1", Main.toDecimal( "1" ).should.be( 1 ));
			it( "10", Main.toDecimal( "A" ).should.be( 10 ));
			it( "20", Main.toDecimal( "1A" ).should.be( 20 ));
			it( "100", Main.toDecimal( "9A" ).should.be( 100 ));
			it( "101", Main.toDecimal( "A1" ).should.be( 101 ));
			it( "110", Main.toDecimal( "AA" ).should.be( 110 ));
			it( "111", Main.toDecimal( "111" ).should.be( 111 ));
			it( "200", Main.toDecimal( "19A" ).should.be( 200 ));
		});

		describe( "Test process", {
			it( "SimpSimple Parsing", Main.process( "A A 12".split(" ") ).should.be( "32" ));
			it( "Parsing", Main.process( "9A A2 1A 12".split(" ") ).should.be( "234" ));
			it( "More Parsing", Main.process( "1AA A2A AA5".split(" ") ).should.be( "2345" ));
			it( "Simple Generation", Main.process( "1 2 3 4".split(" ") ).should.be( "A" ));
			it( "Generation", Main.process( "512 256 128 64 32 16 8 8".split(" ") ).should.be( "A24" ));
			it( "More Generation", Main.process( "19 91".split(" ") ).should.be( "AA" ));
			it( "Mixed Test", Main.process( "99A 9A9 A1".split(" ") ).should.be( "1AAA" ));
			it( "Bigger Test", Main.process( "499A 2A1A AA9 911".split(" ") ).should.be( "9A3A" ));
			it( "Huge Test", Main.process( "123456789 AAA21 AA3A A54A A67A A8A9AAA".split(" ") ).should.be( "1344AA18A" ));
		});
	}
}
