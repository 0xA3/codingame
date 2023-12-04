package test;

import Std.parseFloat;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1: Basic", Main.process( test1 ).should.be( test1Result ));
			it( "Test 2: Couple of pairs", Main.process( test2 ).should.be( test2Result ));
			it( "Test 3: New symbols", Main.process( test3 ).should.be( test3Result ));
			it( "Test 4: Other symbols", Main.process( test4 ).should.be( test4Result ));
			it( "Test 5: More symbols", Main.process( test5 ).should.be( test5Result ));
			it( "Test 6: Extended output", Main.process( test6 ).should.be( test6Result ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return lines.slice( 1 );
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"2
		*
		#"
	);

	final test1Result = parseResult(
		"**
		*#
		#*
		##"
	);

	final test2 = parseInput(
		"3
		^
		@
		$"
	);

	final test2Result = parseResult(
		"^^^
		^^@
		^@^
		^@@
		@^^
		@^@
		@@^
		@@@
		@@$
		@$@
		@$$
		$@@
		$@$
		$$@
		$$$"
	);

	final test3 = parseInput(
		"3
		%
		()
		[]"
	);

	final test3Result = parseResult(
		"%%%
		%%()
		%()%
		%()()
		()%%
		()%()
		()()%
		()()()
		()()[]
		()[]()
		()[][]
		[]()()
		[]()[]
		[][]()
		[][][]"
	);

	final test4 = parseInput(
		"3
		*
		&
		^"
	);

	final test4Result = parseResult(
		"***
		**&
		*&*
		*&&
		&**
		&*&
		&&*
		&&&
		&&^
		&^&
		&^^
		^&&
		^&^
		^^&
		^^^"
	);

	final test5 = parseInput(
		"4
		*
		&
		^
		%"
	);

	final test5Result = parseResult(
		"****
		***&
		**&*
		**&&
		*&**
		*&*&
		*&&*
		*&&&
		&***
		&**&
		&*&*
		&*&&
		&&**
		&&*&
		&&&*
		&&&&
		&&&^
		&&^&
		&&^^
		&^&&
		&^&^
		&^^&
		&^^^
		^&&&
		^&&^
		^&^&
		^&^^
		^^&&
		^^&^
		^^^&
		^^^^
		^^^%
		^^%^
		^^%%
		^%^^
		^%^%
		^%%^
		^%%%
		%^^^
		%^^%
		%^%^
		%^%%
		%%^^
		%%^%
		%%%^
		%%%%"
	);

	final test6 = parseInput(
		"5
		.
		:
		/
		!
		\\"
	);

	final test6Result = parseResult(
		".....
		....:
		...:.
		...::
		..:..
		..:.:
		..::.
		..:::
		.:...
		.:..:
		.:.:.
		.:.::
		.::..
		.::.:
		.:::.
		.::::
		:....
		:...:
		:..:.
		:..::
		:.:..
		:.:.:
		:.::.
		:.:::
		::...
		::..:
		::.:.
		::.::
		:::..
		:::.:
		::::.
		:::::
		::::/
		:::/:
		::://
		::/::
		::/:/
		:://:
		::///
		:/:::
		:/::/
		:/:/:
		:/://
		://::
		://:/
		:///:
		:////
		/::::
		/:::/
		/::/:
		/:://
		/:/::
		/:/:/
		/://:
		/:///
		//:::
		//::/
		//:/:
		//://
		///::
		///:/
		////:
		/////
		////!
		///!/
		///!!
		//!//
		//!/!
		//!!/
		//!!!
		/!///
		/!//!
		/!/!/
		/!/!!
		/!!//
		/!!/!
		/!!!/
		/!!!!
		!////
		!///!
		!//!/
		!//!!
		!/!//
		!/!/!
		!/!!/
		!/!!!
		!!///
		!!//!
		!!/!/
		!!/!!
		!!!//
		!!!/!
		!!!!/
		!!!!!
		!!!!\\
		!!!\\!
		!!!\\\\
		!!\\!!
		!!\\!\\
		!!\\\\!
		!!\\\\\\
		!\\!!!
		!\\!!\\
		!\\!\\!
		!\\!\\\\
		!\\\\!!
		!\\\\!\\
		!\\\\\\!
		!\\\\\\\\
		\\!!!!
		\\!!!\\
		\\!!\\!
		\\!!\\\\
		\\!\\!!
		\\!\\!\\
		\\!\\\\!
		\\!\\\\\\
		\\\\!!!
		\\\\!!\\
		\\\\!\\!
		\\\\!\\\\
		\\\\\\!!
		\\\\\\!\\
		\\\\\\\\!
		\\\\\\\\\\"
	);
}
