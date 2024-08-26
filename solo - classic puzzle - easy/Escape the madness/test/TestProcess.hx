package test;

import CompileTime.readFile;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Only C-style trigraphs", Main.process( onlyCStyleTrigraphs ).should.be( onlyCStyleTrigraphsResult ));
			it( "C-style trigraphs with unsupported characters", Main.process( cStyleTrigraphsWithUnsupportedCharacters ).should.be( cStyleTrigraphsWithUnsupportedCharactersResult ));
			it( "Only backslash escape sequences", Main.process( onlyBackslashEscapeSequence ).should.be( onlyBackslashEscapeSequenceResult ));
			it( "Combined trigraphs and backslash escape sequences", Main.process( combinedTrigraphsAndBackslashEscapeSequences ).should.be( combinedTrigraphsAndBackslashEscapeSequencesResult ));
			it( "No double backslash escape sequence evaluation", Main.process( noDoubleBackslashEscapeSequenceEvaluation ).should.be( noDoubleBackslashEscapeSequenceEvaluationResult ));
			it( "Only HTML entities", Main.process( onlyHtmlEntities ).should.be( onlyHtmlEntitiesResult ));
			it( "Only known HTML entities", Main.process( onlyKnownHtmlEntities ).should.be( onlyKnownHtmlEntitiesResult ));
			it( "No double evaluation of HTML entities", Main.process( noDoubleEvaluationOfHtmlEntities ).should.be( noDoubleEvaluationOfHtmlEntitiesResult ));
			it( "HTML entities must be rendered after backslash escape sequences", Main.process( htmlEntitiesMustBeRenderedAfterBackslashEscapeSequences ).should.be( htmlEntitiesMustBeRenderedAfterBackslashEscapeSequencesResult ));
			it( "All together now!", Main.process( allTogetherNow ).should.be( allTogetherNowResult ));
		});
	}

	final onlyCStyleTrigraphs = "Some very old keyboards lack necessary characters to program in C, such as ??=, ??', ??(??), ??! and ??-.";
	final onlyCStyleTrigraphsResult = "Some very old keyboards lack necessary characters to program in C, such as #, ^, [], | and ~.";

	final cStyleTrigraphsWithUnsupportedCharacters = "While ??< ({) and ??> (}) exist in standard trigraphs, they are not included in our list! Also, ????! should be the same as ??|.";
	final cStyleTrigraphsWithUnsupportedCharactersResult = "While ??< ({) and ??> (}) exist in standard trigraphs, they are not included in our list! Also, ??| should be the same as ??|.";

	final onlyBackslashEscapeSequence = readFile( "test/test_3_input.txt" );
	final onlyBackslashEscapeSequenceResult = readFile( "test/test_3_output.txt" );

	final combinedTrigraphsAndBackslashEscapeSequences = readFile( "test/test_4_input.txt" );
	final combinedTrigraphsAndBackslashEscapeSequencesResult = readFile( "test/test_4_output.txt" );

	final noDoubleBackslashEscapeSequenceEvaluation = readFile( "test/test_5_input.txt" );
	final noDoubleBackslashEscapeSequenceEvaluationResult = readFile( "test/test_5_output.txt" );

	final onlyHtmlEntities = "I mean, someone has just &#100;ecided that 0 &lt; 1, we could have chosen &otherwise;.";
	final onlyHtmlEntitiesResult = "I mean, someone has just decided that 0 < 1, we could have chosen &otherwise;.";

	final onlyKnownHtmlEntities = readFile( "test/test_7_input.txt" );
	final onlyKnownHtmlEntitiesResult = readFile( "test/test_7_output.txt" );

	final noDoubleEvaluationOfHtmlEntities = "You can find sequences such as &amp;amp;gt; on some badly programmed websites.";
	final noDoubleEvaluationOfHtmlEntitiesResult = "You can find sequences such as &amp;gt; on some badly programmed websites.";

	final htmlEntitiesMustBeRenderedAfterBackslashEscapeSequences = readFile( "test/test_9_input.txt" );
	final htmlEntitiesMustBeRenderedAfterBackslashEscapeSequencesResult = readFile( "test/test_9_output.txt" );

	final allTogetherNow = readFile( "test/test_10_input.txt" );
	final allTogetherNowResult = readFile( "test/test_10_output.txt" );
}
