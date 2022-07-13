package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "2 Answers and 1 Missing", {
				Main.process( _2AnswersAnd1Missing ).should.be( _2AnswersAnd1MissingResult );
			} );
			it( "5 Answers and 3 Missing", {
				Main.process( _5AnswersAnd4Missing ).should.be( _5AnswersAnd4MissingResult );
			} );
			it( "Even answers and missing", {
				Main.process( evenAnswersAndMissing ).should.be( evenAnswersAndMissingResult );
			} );
			it( "6 Answers, 6 Missing", {
				Main.process( _6Answers6Missing ).should.be( _6Answers6MissingResult );
			} );
			it( "Everything None", {
				Main.process( everythingNone ).should.be( everythingNoneResult );
			} );
		} );
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final n = parseInt( lines[0] );
		final answers = [for( i in 0...n ) lines[i + 1]];

		return answers;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	static final _2AnswersAnd1Missing = parseInput( "3
	23 female hip-hop
	30 female hip-hop
	24 female" );

	static final _2AnswersAnd1MissingResult = parseResult( "hip-hop" );

	static final _5AnswersAnd4Missing = parseInput( "8
	50 female classical
	60 female classical
	50 male country
	52 female classical
	53 male country
	55 female
	60 female
	55 male" );

	static final _5AnswersAnd4MissingResult = parseResult( "classical
	classical
	None" );

	static final evenAnswersAndMissing = parseInput( "20
	16 female pop
	17 female jazz
	20 female jazz
	16 male funk
	19 male funk
	21 male funk
	21 female hip-hop
	25 male metal
	29 male metal
	31 male metal
	29 male
	16 female
	17 female
	19 female
	21 female
	20 female
	26 male
	31 male
	27 male
	31 female" );

	static final evenAnswersAndMissingResult = parseResult( "metal
	pop
	jazz
	jazz
	hip-hop
	jazz
	metal
	metal
	metal
	None" );

	static final _6Answers6Missing = parseInput( "12
	21 male jazz
	66 male country
	21 female jazz
	0 male nothing
	50 female country
	25 male metal
	0 male
	21 male
	21 female
	50 female
	25 male
	66 male" );

	static final _6Answers6MissingResult = parseResult( "nothing
	jazz
	jazz
	country
	metal
	country" );

	static final everythingNone = parseInput( "3
	25 female rock
	25 male
	22 female" );

	static final everythingNoneResult = parseResult( "None
	None" );
}
