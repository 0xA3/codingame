package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Sample", { Main.process( sample ).should.be( "3 5" ); });
			it( "Everything is a Fizz", { Main.process( everythingIsAFizz ).should.be( "1 5" ); });
			it( "Fizz is Buzz", { Main.process( fizzIsBuzz ).should.be( "5 5" ); });
			it( "One Fizz to rule them all", { Main.process( oneFizzToRuleThemAll ).should.be( "30 9" ); });
			it( "Tricky", { Main.process( tricky ).should.be( "5 51" ); });

		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return [for( i in 1...lines.length ) lines[i]];
	}

	final sample = parseInput(
		"15
		1
		2
		Fizz
		4
		Buzz
		Fizz
		7
		8
		Fizz
		Buzz
		11
		Fizz
		13
		14
		FizzBuzz"
	);

	final everythingIsAFizz = parseInput(
		"20
		Fizz
		Fizz
		Fizz
		Fizz
		FizzBuzz
		Fizz
		Fizz
		Fizz
		Fizz
		FizzBuzz
		Fizz
		Fizz
		Fizz
		Fizz
		FizzBuzz
		Fizz
		Fizz
		Fizz
		Fizz
		FizzBuzz"
	);

	final fizzIsBuzz = parseInput(
		"20
		14
		FizzBuzz
		16
		17
		18
		19
		FizzBuzz
		21
		22
		23
		24
		FizzBuzz
		26
		27
		28
		29
		FizzBuzz
		31
		32
		33"
	);

	final oneFizzToRuleThemAll = parseInput(
		"30
		1
		2
		3
		4
		5
		6
		7
		8
		Buzz
		10
		11
		12
		13
		14
		15
		16
		17
		Buzz
		19
		20
		21
		22
		23
		24
		25
		26
		Buzz
		28
		29
		Fizz"
	);

	final tricky = parseInput(
		"21
		Fizz
		Buzz
		52
		53
		54
		Fizz
		56
		57
		58
		59
		Fizz
		61
		62
		63
		64
		Fizz
		66
		67
		68
		69
		Fizz"
	);

}

