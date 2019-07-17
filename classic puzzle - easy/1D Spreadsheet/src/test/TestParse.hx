package test;
import Main;
using buddy.Should;

@:access(Main)
class TestParse extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test createAST", {
			
			final op1 = ["VALUE", "3", "_" ];
			final op2 = ["ADD", "3", "4" ];

			it( "Test op1", {
				Main.createAST( [op1], 0 ).should.equal( Value( 3 ));
			});
			
			it( "Test op2", {
				Main.createAST( [op2], 0 ).should.equal( Add( Value( 3 ), Value( 4 )));
			});
			
		});
		
		describe( "Test Eval", {
			
			final value = Value( 3 );
			final add = Add( Value( 3 ), Value( 4 ));
			final sub = Sub( Value( 3 ), Value( 4 ));
			final mult = Mult( Value( 3 ), Value( 4 ));

			it( "Test value", {
				Main.eval( value ).should.be( 3 );
			});
			
			it( "Test add", {
				Main.eval( add ).should.be( 7 );
			});
			
			it( "Test sub", {
				Main.eval( sub ).should.be( -1 );
			});
			
			it( "Test mult", {
				Main.eval( mult ).should.be( 12 );
			});
			
		});

		describe( "Test Process", {

			final s1 = 'VALUE 3 _\nADD $0 4';
			final case1 = parseLines( s1 );
			it( "Test case1", {
				Main.process( case1 )[0].should.be( 3 );
				Main.process( case1 )[1].should.be( 7 );
			});

			final case2 = parseLines( aih );
			it( "Test case2" , {
				trace( Main.process( case2 ));
				Main.process( case2 )[6].should.be( 0 );
			});

		});
	}

	function parseLines( s:String ):Array<Array<String>> {
		return s.split( "\n" ).map( a -> a.split(' '));
	}

static final aih = 'MULT $61 $95
ADD $26 $80
ADD $6 $0
ADD $98 $39
ADD $72 $14
SUB $12 $32
MULT $73 $86
ADD $80 $12
MULT $86 $60
SUB $39 $59
SUB $64 $83
SUB $98 $91
SUB $59 $80
MULT $65 $73
ADD $25 $3
ADD $93 $10
SUB $93 $72
MULT $43 $23
MULT $43 $51
MULT $71 $0
SUB $60 $3
ADD $77 $46
SUB $23 $40
MULT $99 $6
MULT $44 $39
VALUE $28 _
VALUE $43 _
ADD $92 $46
ADD $49 $86
SUB $82 $41
ADD $12 $89
ADD $91 $86
SUB $60 $9
MULT $51 $3
SUB $12 $94
ADD $12 $28
ADD $66 $69
SUB $53 $1
ADD $98 $53
ADD $98 $98
ADD $42 $59
SUB $64 $0
SUB $98 $6
MULT 609 -14
ADD $60 $55
SUB $59 -245
MULT $64 $1
MULT $99 $98
ADD $46 $97
SUB $86 $43
MULT $28 $18
MULT $64 $40
SUB $70 $32
MULT $91 $80
ADD $83 $6
ADD $97 $76
MULT $23 $45
SUB $53 $22
MULT $6 $10
ADD $39 $98
MULT $17 $26
MULT $93 $59
SUB $70 $99
SUB $64 $43
SUB $9 $9
MULT $91 $53
MULT $26 $80
ADD $9 $43
SUB $72 $13
ADD $64 $82
ADD $80 $45
SUB $12 $61
ADD $53 $73
SUB $43 $98
MULT $47 $86
SUB $56 $99
SUB $53 $51
ADD 681 $43
ADD $70 $18
MULT $12 $51
MULT $6 $45
SUB $99 $40
VALUE $45 _
SUB $59 $98
SUB $6 $59
MULT $55 $51
SUB $39 $39
SUB $26 $73
ADD $84 $92
ADD $97 $50
SUB $75 $66
ADD $86 $43
MULT 295 $60
MULT $31 $17
SUB $9 $11
SUB $87 $65
MULT $64 $55
MULT $49 $23
MULT -6 380
VALUE $53 _';

}