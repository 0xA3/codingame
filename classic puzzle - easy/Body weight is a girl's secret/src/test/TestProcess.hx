package test;

import Std.parseInt;

using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process3", {
			it( "t1", {
				final weights = [2, 4, 5];
				Main.process3( Main.createSums( weights )).should.be( weights.join(" ") );
			});
			it( "t2", {
				final weights = [1, 1, 1];
				Main.process3( Main.createSums( weights )).should.be( weights.join(" ") );
			});
			it( "t3", {
				final weights = [54, 62, 63];
				Main.process3( Main.createSums( weights )).should.be( weights.join(" ") );
			});
		});
		
		describe( "Test process4", {
			it( "t1", {
				final weights = [45, 52, 53, 75];
				Main.process4( Main.createSums( weights )).should.be( weights.join(" ") );
			});
			it( "t2", {
				final weights = [1, 52, 53, 75];
				Main.process4( Main.createSums( weights )).should.be( weights.join(" ") );
			});
			it( "t3", {
				final weights = [5, 6, 8, 10];
				Main.process4( Main.createSums( weights )).should.be( weights.join(" ") );
			});
		});
		
		describe( "Test process51", {
			it( "All different", {
				Main.process51( allDifferent ).should.be( "45 51 52 63 76" );
			});
			it( "Same paired values", {
				Main.process51( samePairedValues ).should.be( "40 51 62 73 84" );
			});
			it( "Same individual values", {
				Main.process51( sameIndividualValues ).should.be( "20 487 487 488 489" );
			});
			it( "Including a baby", {
				Main.process51( includingABaby ).should.be( "1 81 100 105 111" );
			});
			it( "XXL", {
				Main.process51( xxl ).should.be( "798 841 843 999 1000" );
			});
		});
			
		describe( "Test process", {
			it( "All different", {
				Main.process( allDifferent ).should.be( "45 51 52 63 76" );
			});
			it( "Same paired values", {
				Main.process( samePairedValues ).should.be( "40 51 62 73 84" );
			});
			it( "Same individual values", {
				Main.process( sameIndividualValues ).should.be( "20 487 487 488 489" );
			});
			it( "Including a baby", {
				Main.process( includingABaby ).should.be( "1 81 100 105 111" );
			});
			it( "XXL", {
				Main.process( xxl ).should.be( "798 841 843 999 1000" );
			});
		});
			
	}


	static function parseInput( input:String ) {
		final inputs = input.split(' ');
		return [for( weight in inputs ) parseInt( weight )];
	}
	
	final allDifferent = parseInput(
		"96 97 103 108 114 115 121 127 128 139"
	);

	final samePairedValues = parseInput(
		"91 102 113 113 124 124 135 135 146 157"
	);

	final sameIndividualValues = parseInput(
		"507 507 508 509 974 975 975 976 976 977"
	);

	final includingABaby = parseInput(
		"82 101 106 112 181 186 192 205 211 216"
	);

	final xxl = parseInput(
		"1639 1641 1684 1797 1798 1840 1841 1842 1843 1999"
	);
}

