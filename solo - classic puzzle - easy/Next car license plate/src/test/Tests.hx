package test;

import Main.char2Num;
import Main.num2Char;
import Main.tripleDigits;
import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "char2Num", {
			it( "A", { char2Num( "A" ).should.be( 0 ); });
			it( "B", { char2Num( "B" ).should.be( 1 ); });
			it( "Z", { char2Num( "Z" ).should.be( 25 ); });
		});

		describe( "num2Char", {
			it( "A", { num2Char( 0 ).should.be( "A" ); });
			it( "B", { num2Char( 1 ).should.be( "B" ); });
			it( "Z", { num2Char( 25 ).should.be( "Z" ); });
		});

		describe( "tripleDigits", {
			it( "9", { tripleDigits( 9 ).should.be( "009" ); });
			it( "99", { tripleDigits( 99 ).should.be( "099" ); });
			it( "999", { tripleDigits( 999 ).should.be( "999" ); });
		});

		describe( "Test process", {
			
			it( "+0", {
				final ip = plus0;
				Main.process( ip.x, ip.n ).should.be( "AA-001-AA" );
			});
			it( "+1", {
				final ip = plus1;
				Main.process( ip.x, ip.n ).should.be( "AA-002-AA" );
			});
			it( "+5", {
				final ip = plus5;
				Main.process( ip.x, ip.n ).should.be( "AB-128-CD" );
			});
			it( "+100", {
				final ip = plus100;
				Main.process( ip.x, ip.n ).should.be( "AZ-666-QS" );
			});
			it( "999+1", {
				final ip = _999Plus1;
				Main.process( ip.x, ip.n ).should.be( "BN-001-GI" );
			});
			it( "+10 000", {
				final ip = plus10000;
				Main.process( ip.x, ip.n ).should.be( "CG-017-CQ" );
			});
			it( "+100 000", {
				final ip = plus100000;
				Main.process( ip.x, ip.n ).should.be( "IO-110-SE" );
			});
			it( "+1 000 000", {
				final ip = plus1000000;
				Main.process( ip.x, ip.n ).should.be( "QT-457-PS" );
			});
			it( "Very big", {
				final ip = veryBig;
				Main.process( ip.x, ip.n ).should.be( "JQ-027-XY" );
			});
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final x = lines[0];
		final n = parseInt( lines[1] );
				
		return { x: x, n: n }
	}

	static final plus0 = parseInput(
	"AA-001-AA
	0" );

	static final plus1 = parseInput(
	"AA-001-AA
	1" );

	static final plus5 = parseInput(
	"AB-123-CD
	5" );

	static final plus100 = parseInput(
	"AZ-566-QS
	100" );

	static final _999Plus1 = parseInput(
	"BN-999-GH
	1" );

	static final plus10000 = parseInput(
	"CG-007-CG
	10000" );

	static final plus100000 = parseInput(
	"IO-010-OI
	100000" );

	static final plus1000000 = parseInput(
	"QS-456-DF
	1000000" );

	static final veryBig = parseInput(
	"ER-963-DF
	87654321" );
}

