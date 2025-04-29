package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Example", {
				final ip = example;
				Main.process( ip.letterCase, ip.letterFuzz, ip.numberFuzz, ip.otherFuzz, ip.template, ip.candidates ).should.be( exampleResult );
			});
			
			it( "Strict", {
				final ip = strict;
				Main.process( ip.letterCase, ip.letterFuzz, ip.numberFuzz, ip.otherFuzz, ip.template, ip.candidates ).should.be( strictResult );
			});
			
			it( "letterCase=false, letterFuzz=2", {
				final ip = letterCaseFalseLetterFuzz_2;
				Main.process( ip.letterCase, ip.letterFuzz, ip.numberFuzz, ip.otherFuzz, ip.template, ip.candidates ).should.be( letterCaseFalseLetterFuzz_2Result );
			});
			
			it( "numberFuzz", {
				final ip = numberFuzz;
				Main.process( ip.letterCase, ip.letterFuzz, ip.numberFuzz, ip.otherFuzz, ip.template, ip.candidates ).should.be( numberFuzzResult );
			});
			
			it( "otherFuzz=false", {
				final ip = otherFuzzFalse;
				Main.process( ip.letterCase, ip.letterFuzz, ip.numberFuzz, ip.otherFuzz, ip.template, ip.candidates ).should.be( otherFuzzFalseResult );
			});
			
			it( "Put It All Together", {
				final ip = putItAllTogether;
				Main.process( ip.letterCase, ip.letterFuzz, ip.numberFuzz, ip.otherFuzz, ip.template, ip.candidates ).should.be( putItAllTogetherResult );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final letterCase = readline() == "true";
		final letterFuzz = parseInt( readline() );
		final numberFuzz = parseInt( readline() );
		final otherFuzz = readline() == "true";
		final template = readline();
		final n = parseInt( readline() );
		final candidates = [for( _ in 0...n ) readline()];

		return { letterCase: letterCase, letterFuzz: letterFuzz, numberFuzz: numberFuzz, otherFuzz: otherFuzz, template: template, candidates: candidates };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final example = parseInput(
		"false
		2
		1
		false
		Apple10,Orange9
		1
		apple9?pramed7"
	);

	final exampleResult = "false";

	final strict = parseInput(
		"true
		0
		0
		true
		Some1thing?
		6
		some1thing?
		Some1thing?
		Some1thing!
		Some thing?
		Some2thing?
		Some1thang?"
	);

	final strictResult = parseResult(
		"false
		true
		false
		false
		false
		false"
	);

	final letterCaseFalseLetterFuzz_2 = parseInput(
		"false
		2
		0
		true
		Correct Horse Battery Staple
		4
		Dotteds Hoste Battery STAPLE
		Corrupt Horse Batters Stable
		Correct HORSE basterz urbond
		Correct Battery Horse Staple"
	);

	final letterCaseFalseLetterFuzz_2Result = parseResult(
		"true
		false
		true
		false"
	);

	final numberFuzz = parseInput(
		"true
		0
		50
		true
		The 82nd Airborne
		6
		The 132nd Airborne
		The 82nd Airborn
		The 32nd Airborne
		The 31nd Airborne
		the 101nd Airborne
		The 50nd Airborne"
	);

	final numberFuzzResult = parseResult(
		"true
		false
		true
		false
		false
		true"
	);

	final otherFuzzFalse = parseInput(
		'true
		0
		0
		false
		I wish I cou\'d be smart" like, her; (Punctuation, is; fun!)"
		4
		I wish I cou?d be smart? like? her$ [Punctuation- is? fun$]?
		I wish I could be smart. like, her; (Punctuation, is; fun!).
		I wish I cou-d be smart# like| her_ (Punctuation, is; fun^*<
		i wish i cou\'d be smart" like, her; (punctuation, is; fun!)"'
	);

	final otherFuzzFalseResult = parseResult(
		"true
		false
		true
		false"
	);

	final putItAllTogether = parseInput(
		"true
		5
		100
		false
		Ab100-500,EfG?h1jK 50.1000n0p. Qr5; tU5-WxYz
		7
		Ab6-432,EfG?h75jK 144.911n0p. Qr35; tU56-WxYz
		Ab0?576!EfG.h101jK{69}1066n100p+(Qr7)*tU102?WxYz
		Ea0?576!BcD.m101kJ{79}1066o100q+(Uv7)*rV102?ZyXw
		Ea8?444!BcD.m2kJ{88}988o80q+(Uv8)*rV98?ZyXw
		Ab300-500,EfG?h1jK 50.1000n0p. Qr5; tU5-WxYz
		Ab100-500,EfG?h1jK 50.1000n0p. qR5; tU5-WxYz
		Ab100.500.EfG.h1jK.92..960n0p..Qr5.-tU5-WxYz"
	);

	final putItAllTogetherResult = parseResult(
		"true
		true
		true
		true
		false
		false
		false"
	);
}
