package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "1. 2 is not prime", {
				final ip = _2IsNotPrime;
				Main.process( ip.a, ip.b ).should.be( _2IsNotPrimeResult );
			});
			it( "2. Random", {
				final ip = random;
				Main.process( ip.a, ip.b ).should.be( randomResult );
			});
			it( "3. Don't sort", {
				final ip = donTSort;
				Main.process( ip.a, ip.b ).should.be( donTSortResult );
			});
			it( "4. Rounding", {
				final ip = rounding;
				Main.process( ip.a, ip.b ).should.be( roundingResult );
			});
			it( "5. Big", {
				final ip = big;
				Main.process( ip.a, ip.b ).should.be( bigResult );
			});
			it( "6. Bigger", {
				final ip = bigger;
				Main.process( ip.a, ip.b ).should.be( biggerResult );
			});
			it( "7. Care even rounding", {
				final ip = careEvenRounding;
				Main.process( ip.a, ip.b ).should.be( careEvenRoundingResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs1 = lines[0].split(" ");
		final xa = parseInt( inputs1[0] );
		final ya = parseInt( inputs1[1] );
		final inputs2 = lines[1].split(" ");
		final xb = parseInt( inputs2[0] );
		final yb = parseInt( inputs2[1] );

		final a:Complex = { real: xa, imag: ya }
		final b:Complex = { real: xb, imag: yb }

		return { a: a, b: b };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final _2IsNotPrime = parseInput(
		"2 0
		1 -1" );

	final _2IsNotPrimeResult = parseResult(
		"(2+0j) = (1-1j) * (1+1j) + 0j
		GCD((2+0j), (1-1j)) = (1-1j)" );
	
	final random = parseInput(
		"-38 -26
		-43 -7" );

	final randomResult = parseResult(
		"(-38-26j) = (-43-7j) * (1+0j) + (5-19j)
		(-43-7j) = (5-19j) * -2j + (-5+3j)
		(5-19j) = (-5+3j) * (-2+2j) + (1-3j)
		(-5+3j) = (1-3j) * (-1-1j) + (-1+1j)
		(1-3j) = (-1+1j) * (-2+1j) + 0j
		GCD((-38-26j), (-43-7j)) = (-1+1j)" );
	
	final donTSort = parseInput(
		"-6 27
		-37 25" );

	final donTSortResult = parseResult(
		"(-6+27j) = (-37+25j) * 0j + (-6+27j)
		(-37+25j) = (-6+27j) * (1+1j) + (-4+4j)
		(-6+27j) = (-4+4j) * (4-3j) + (-2-1j)
		(-4+4j) = (-2-1j) * (1-2j) + 1j
		(-2-1j) = 1j * (-1+2j) + 0j
		GCD((-6+27j), (-37+25j)) = 1j" );
	
	final rounding = parseInput(
		"28 40
		-18 -24" );

	final roundingResult = parseResult(
		"(28+40j) = (-18-24j) * (-2+0j) + (-8-8j)
		(-18-24j) = (-8-8j) * (3+0j) + (6+0j)
		(-8-8j) = (6+0j) * (-1-1j) + (-2-2j)
		(6+0j) = (-2-2j) * (-1+2j) + 2j
		(-2-2j) = 2j * (-1+1j) + 0j
		GCD((28+40j), (-18-24j)) = 2j" );
	
	final big = parseInput(
		"-13 -39
		-5 35" );

	final bigResult = parseResult(
		"(-13-39j) = (-5+35j) * (-1+1j) + (17+1j)
		(-5+35j) = (17+1j) * 2j + (-3+1j)
		(17+1j) = (-3+1j) * (-5-2j) + 0j
		GCD((-13-39j), (-5+35j)) = (-3+1j)" );
	
	final bigger = parseInput(
		"-5612 -2269
		-250 940" );

	final biggerResult = parseResult(
		"(-5612-2269j) = (-250+940j) * (-1+6j) + (-222+171j)
		(-250+940j) = (-222+171j) * (3-2j) + (74-17j)
		(-222+171j) = (74-17j) * (-3+2j) + (-34-28j)
		(74-17j) = (-34-28j) * (-1+1j) + (12-11j)
		(-34-28j) = (12-11j) * -3j + (-1+8j)
		(12-11j) = (-1+8j) * (-2-1j) + (2+4j)
		(-1+8j) = (2+4j) * (2+1j) + (-1-2j)
		(2+4j) = (-1-2j) * (-2+0j) + 0j
		GCD((-5612-2269j), (-250+940j)) = (-1-2j)" );
	
	final careEvenRounding = parseInput(
		"19 8
		-1 -7" );

	final careEvenRoundingResult = parseResult(
		"(19+8j) = (-1-7j) * (-1+3j) + (-3+4j)
		(-1-7j) = (-3+4j) * (-1+1j) + 0j
		GCD((19+8j), (-1-7j)) = (-3+4j)" );
	
}
