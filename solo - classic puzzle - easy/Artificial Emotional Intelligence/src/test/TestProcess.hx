package test;

using buddy.Should;
using StringTools;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Example", { Main.process( "Missy Marie" ).should.be( example );	});
			it( "Simple case", { Main.process( "Frankie" ).should.be( simpleCase );	});
			it( "Repeating letters and space", { Main.process( "Meg Eagleton" ).should.be( repeatingLettersAndSpace ); });
			it( "With hyphen and period", { Main.process( "K.D. Lang-McDonald" ).should.be( withHyphenAndPeriod ); });
			it( "Symbols and numbers", { Main.process( "Sir A$AP the 2nd" ).should.be( symbolsAndNumbers );	});
			it( "You are not enough", { Main.process( "Libby" ).should.be( youAreNotEnough ); });
			it( 'With "Y" and "Z"', { Main.process( "Lizzy Rae" ).should.be( withYAndZ ); });
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	static final example = parseResult(
		"It's so nice to meet you, my dear gregarious Missy Marie.
		I sense you are both non-judgmental and honest.
		May our future together have much more friendship than investment loss." );

	static final simpleCase = parseResult(
		"It's so nice to meet you, my dear courageous Frankie.
		I sense you are both honest and hardworking.
		May our future together have much more love than disasters." );

	static final repeatingLettersAndSpace = parseResult(
		"It's so nice to meet you, my dear gregarious Meg Eagleton.
		I sense you are both creative and giving.
		May our future together have much more forgiveness than disappointment." );

	static final withHyphenAndPeriod = parseResult(
		"It's so nice to meet you, my dear diplomatic K.D. Lang-McDonald.
		I sense you are both affectionate and giving.
		May our future together have much more love than illness." );

	static final symbolsAndNumbers = parseResult(
		"It's so nice to meet you, my dear non-judgmental Sir A$AP the 2nd.
		I sense you are both honest and helpful.
		May our future together have much more friendship than crime." );

	static final youAreNotEnough = parseResult(
		"Hello Libby." );

	static final withYAndZ = parseResult(
		"It's so nice to meet you, my dear giving Lizzy Rae.
		I sense you are both sincere and honest.
		May our future together have much more friendship than investment loss." );
}
