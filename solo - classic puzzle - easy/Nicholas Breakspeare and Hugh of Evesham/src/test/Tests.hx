package test;

import haxe.Int64;
import Main;
import Std.parseInt;
import Std.parseFloat;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
			describe( "Test process", {
			
			it( "Example", { Main.process( example ).should.be( exampleResult ); });
			it( "The basics", { Main.process( theBasics ).should.be( theBasicsResult ); });
			it( "The teens", { Main.process( theTeens ).should.be( theTeensResult ); });
			it( "Some powers of 10", { Main.process( somePowersOf10 ).should.be( somePowersOf10Result ); });
			it( "Some powers of 2", { Main.process( somePowersOf2 ).should.be( somePowersOf2Result ); });
			it( "Extrema", { Main.process( extrema ).should.be( extremaResult ); });
			it( "Utter randomness", { Main.process( utterRandomness ).should.be( utterRandomnessResult ); });
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return lines.slice( 1 );
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final example = parseInput(
		"1
		525600" );
	
	final exampleResult = parseResult(
		"five hundred twenty-five thousand six hundred" );
	
	final theBasics = parseInput(
		"5
		0
		1
		2
		3
		4" );
	
	final theBasicsResult = parseResult(
		"zero
		one
		two
		three
		four" );
	
	final theTeens = parseInput(
		"5
		11
		13
		15
		17
		19" );
	
	final theTeensResult = parseResult(
		"eleven
		thirteen
		fifteen
		seventeen
		nineteen" );
	
	final somePowersOf10 = parseInput(
		"10
		10
		1000
		100000
		10000000
		1000000000
		100000000000
		10000000000000
		1000000000000000
		100000000000000000
		10000000000000000000" );
	
	final somePowersOf10Result = parseResult(
		"ten
		one thousand
		one hundred thousand
		ten million
		one billion
		one hundred billion
		ten trillion
		one quadrillion
		one hundred quadrillion
		ten quintillion" );
	
	final somePowersOf2 = parseInput(
		"17
		1
		4
		16
		64
		256
		1024
		4096
		16384
		65536
		262144
		1048576
		4194304
		16777216
		67108864
		268435456
		1073741824
		4294967296" );
	
	final somePowersOf2Result = parseResult(
		"one
		four
		sixteen
		sixty-four
		two hundred fifty-six
		one thousand twenty-four
		four thousand ninety-six
		sixteen thousand three hundred eighty-four
		sixty-five thousand five hundred thirty-six
		two hundred sixty-two thousand one hundred forty-four
		one million forty-eight thousand five hundred seventy-six
		four million one hundred ninety-four thousand three hundred four
		sixteen million seven hundred seventy-seven thousand two hundred sixteen
		sixty-seven million one hundred eight thousand eight hundred sixty-four
		two hundred sixty-eight million four hundred thirty-five thousand four hundred fifty-six
		one billion seventy-three million seven hundred forty-one thousand eight hundred twenty-four
		four billion two hundred ninety-four million nine hundred sixty-seven thousand two hundred ninety-six" );
	
	final extrema = parseInput(
		"2
		-18446744073709551616
		18446744073709551615" );
	
	final extremaResult = parseResult(
		"negative eighteen quintillion four hundred forty-six quadrillion seven hundred forty-four trillion seventy-three billion seven hundred nine million five hundred fifty-one thousand six hundred sixteen
		eighteen quintillion four hundred forty-six quadrillion seven hundred forty-four trillion seventy-three billion seven hundred nine million five hundred fifty-one thousand six hundred fifteen" );
	
	final utterRandomness = parseInput(
		"20
		5
		-8
		63
		35
		-13
		888
		81
		-640
		7378
		6481
		-3090
		25518
		30826
		12211
		888480
		438210
		-623302
		5974605
		7223757
		-18468" );
	
	final utterRandomnessResult = parseResult(
		"five
		negative eight
		sixty-three
		thirty-five
		negative thirteen
		eight hundred eighty-eight
		eighty-one
		negative six hundred forty
		seven thousand three hundred seventy-eight
		six thousand four hundred eighty-one
		negative three thousand ninety
		twenty-five thousand five hundred eighteen
		thirty thousand eight hundred twenty-six
		twelve thousand two hundred eleven
		eight hundred eighty-eight thousand four hundred eighty
		four hundred thirty-eight thousand two hundred ten
		negative six hundred twenty-three thousand three hundred two
		five million nine hundred seventy-four thousand six hundred five
		seven million two hundred twenty-three thousand seven hundred fifty-seven
		negative eighteen thousand four hundred sixty-eight" );
	
}

