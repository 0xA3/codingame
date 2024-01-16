package test;

import Std.parseFloat;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "1) Sample", {
				final ip = sample;
				Main.process( ip.w, ip.s ).should.be( "1.3.2.4" );
			});
			it( "2) 5 letters + punctuation mark", {
				final ip = _5LettersPunctuationMark;
				Main.process( ip.w, ip.s ).should.be( "3.1.6.3" );
			});
			it( "3) 4 letters + punctuation mark", {
				final ip = _4LettersPunctuationMark;
				Main.process( ip.w, ip.s ).should.be( "8.1.7.6" );
			});
			it( "4) 7 letters + duplicate anagram", {
				final ip = _7LettersDuplicateAnagram;
				Main.process( ip.w, ip.s ).should.be( "1.2.3.2" );
			});
			it( "5) impossible", {
				final ip = impossible;
				Main.process( ip.w, ip.s ).should.be( "IMPOSSIBLE" );
			});
			it( "6) 8 letters + case sensitives anagram", {
				final ip = _8LettersCaseSensitivesAnagram;
				Main.process( ip.w, ip.s ).should.be( "0.7.8.3" );
			});
			it( "7) 9 letters + the key + 1 anagram in same sentence", {
				final ip = _9LettersTheKey_1AnagramInSameSentence;
				Main.process( ip.w, ip.s ).should.be( "1.5.9.7" );
			});
			it( "8) random words no sense", {
				final ip = randomWordsNoSense;
				Main.process( ip.w, ip.s ).should.be( "2.2.8.8" );
			});
			it( "9) no word before anagram", {
				final ip = noWordBeforeAnagram;
				Main.process( ip.w, ip.s ).should.be( "0.9.0.5" );
			});
			it( "10) no word after key", {
				final ip = noWordAfterKey;
				Main.process( ip.w, ip.s ).should.be( "4.0.0.0" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final w = lines[0];
		final s = lines[1];
	
		return { w: w, s: s }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final sample = parseInput(
		"god
		My dog scared them away"
	);

	final _5LettersPunctuationMark = parseInput(
		"baker
		I need a break now !"
	);

	final _4LettersPunctuationMark = parseInput(
		"flow
		In the silence of the night,a lone wolf howled."
	);

	final _7LettersDuplicateAnagram = parseInput(
		"cheater
		The teacher told us a funny story. He is the best teacher, even though he has the least experience. Our teacher looks very young."
	);

	final impossible = parseInput(
		"impossible
		Teachers are the gifts of god who make our career and guide us towards success."
	);

	final _8LettersCaseSensitivesAnagram = parseInput(
		"recitals
		For example:in the sentence Nick bought a dog.The article a indicates that the word dog is a noun. Articles can also modify anything that acts as a noun, such as a pronoun or a noun phrase."
	);

	final _9LettersTheKey_1AnagramInSameSentence = parseInput(
		"mastering
		mastering streaming is very important for teenagers"
	);

	final randomWordsNoSense = parseInput(
		"cautioned
		educbtiom deucatiox education cautionea!!! gogogonow."
	);

	final noWordBeforeAnagram = parseInput(
		"stable
		Tables are used for board games and not for eating."
	);

	final noWordAfterKey = parseInput(
		"design
		all contracts have been signed !"
	);
}
