package test;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Example", { Main.process( example ).should.be( "JESS" ); });
			it( "Louis", { Main.process( louis ).should.be( "LOUISVII" ); });
			it( "1-10", { Main.process( oneToTen ).should.be( "P" ); });
			it( "Metals", { Main.process( metals ).should.be( "MN" ); });
			it( "Quick Test 1", { Main.process( quickTest1 ).should.be( "ABCH" ); });
			it( "Quick Test 2", { Main.process( quickTest2 ).should.be( "ABD" ); });
			it( "Quick Test 3", { Main.process( quickTest3 ).should.be( "A" ); });
			it( "Quick Test 4", { Main.process( quickTest4 ).should.be( "A" ); });
			it( "Quick Test 5", { Main.process( quickTest5 ).should.be( "Z" ); });
			it( "Tricky", { Main.process( tricky ).should.be( "DIZZY" ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return lines.slice( 1 );
	}

	final example = parseInput(
		"6
		JAMES
		JENNIFER
		JESS
		JESSICA
		JOHN
		JOSEPH"
	);
	
	final louis = parseInput(
		"16
		LOUISI
		LOUISII
		LOUISIII
		LOUISIV
		LOUISV
		LOUISVI
		LOUISVII
		LOUISVIII
		LOUISIX
		LOUISX
		LOUISXI
		LOUISXII
		LOUISXIII
		LOUISXIV
		LOUISXV
		LOUISXVI"
	);
	
	final oneToTen = parseInput(
		"10
		ONE
		TWO
		THREE
		FOUR
		FIVE
		SIX
		SEVEN
		EIGHT
		NINE
		TEN"
	);
	
	final metals = parseInput(
		"38
		LI
		BE
		NA
		MG
		AI
		K
		CA
		SC
		TI
		V
		CR
		MN
		FE
		CO
		NI
		CU
		ZN
		GA
		RB
		SR
		Y
		ZR
		NB
		MO
		TC
		RU
		RH
		PD
		AG
		CD
		IN
		SN
		CS
		BA
		LA
		CE
		PR
		ND"
	);
	
	final quickTest1 = parseInput(
		"2
		ABCH
		ABD"
	);
		
	final quickTest2 = parseInput(
		"2
		ABCHZ
		ABDAA"
	);
		
	final quickTest3 = parseInput(
		"2
		A
		C"
	);
		
	final quickTest4 = parseInput(
		"2
		A
		AA"
	);
		
	final quickTest5 = parseInput(
		"2
		YZ
		ZZ"
	);
		
	final tricky = parseInput(
		"6
		ALEC
		DIZZY
		SAM
		DANA
		DJ
		MARK"
	);
	
}

