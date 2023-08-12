package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "POLKA", {
				final ip = polka;
				Main.process( ip.answer, ip.attempts ).should.be( polkaResult );
			});
			it( "WATER", {
				final ip = water;
				Main.process( ip.answer, ip.attempts ).should.be( waterResult );
			});
			it( "KOALA", {
				final ip = koala;
				Main.process( ip.answer, ip.attempts ).should.be( koalaResult );
			});
			it( "NANNY", {
				final ip = nanny;
				Main.process( ip.answer, ip.attempts ).should.be( nannyResult );
			});
			it( "BONGO", {
				final ip = bongo;
				Main.process( ip.answer, ip.attempts ).should.be( bongoResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return { answer: lines[0], attempts: lines.slice( 2 ).map( s -> s.split( "" )) }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final polka  = parseInput(
		"POLKA
		4
		QUICK
		BROWN
		GLADY
		POLKA" );
	
	final polkaResult  = parseResult(
		"XXXXO
		XXOXX
		XOOXX
		#####" );
		
	final water  = parseInput(
		"WATER
		5
		MILKY
		AWAIT
		TWATS
		WATCH
		WATER" );
	
	final waterResult  = parseResult(
		"XXXXX
		OOXXO
		OOOXX
		###XX
		#####" );

	final koala  = parseInput(
		"KOALA
		6
		ALTAR
		AWAIT
		SCALA
		AABAB
		AAAAA
		KOALA" );
	
	final koalaResult  = parseResult(
		"OOXOX
		OX#XX
		XX###
		OOXXX
		XX#X#
		#####" );
		
	final nanny  = parseInput(
		"NANNY
		6
		XNXXN
		NXXXN
		NNXXN
		NNNNN
		NYNNA
		NANNY" );
	
	final nannyResult  = parseResult(
		"XOXXO
		#XXXO
		#OXXO
		#X##X
		#O##O
		#####" );
		
	final bongo  = parseInput(
		"BONGO
		3
		OOOOO
		ONGBA
		NNOGO" );
	
	final bongoResult  = parseResult(
		"X#XX#
		OOOOX
		OXO##" );
}
