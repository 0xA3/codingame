package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test1", {
				final ip = test1;
				Main.process( ip.mode, ip.stringFrets ).should.be( test1Result );
			});
			it( "Guitar n=1 single output", {
				final ip = guitarN1Single;
				Main.process( ip.mode, ip.stringFrets ).should.be( guitarN1SingleResult );
			});
			it( "Ukulele n=1 multiple outputs", {
				final ip = ukuleleN1MultipleOutputs;
				Main.process( ip.mode, ip.stringFrets ).should.be( ukuleleN1MultipleOutputsResult );
			});
			it( "Guitar multiple conversions", {
				final ip = guitarMultipleConversions;
				Main.process( ip.mode, ip.stringFrets ).should.be( guitarMultipleConversionsResult );
			});
			it( "Ukulele multiple conversions", {
				final ip = ukuleleMultipleConversions;
				Main.process( ip.mode, ip.stringFrets ).should.be( ukuleleMultipleConversionsResult );
			});
			it( "Guitar multiple conversions with no match", {
				final ip = guitarMultipleConversionsWithNoMatch;
				Main.process( ip.mode, ip.stringFrets ).should.be( guitarMultipleConversionsWithNoMatchResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final mode = lines[0];
		final n = parseInt( lines[1] );
		final stringFrets = [for( i in 0...n ) {
			final inputs = lines[i + 2].split(" ");
			{ string: parseInt( inputs[0] ), fret: parseInt( inputs[1] )}
		}];

		return { mode: mode, stringFrets: stringFrets }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"guitar
		1
		1 18"
	);
	
	final test1Result = parseResult(
		"0/8 1/13 3/10"
	);

	final guitarN1Single = parseInput(
		"guitar
		1
		2 8"
	);

	final guitarN1SingleResult = parseResult(
		"2/3"
	);

	final ukuleleN1MultipleOutputs = parseInput(
		"ukulele
		1
		3 8"
	);

	final ukuleleN1MultipleOutputsResult = parseResult(
		"0/11 1/16 2/20"
	);

	final guitarMultipleConversions = parseInput(
		"guitar
		5
		2 13
		4 19
		4 20
		2 10
		0 8"
	);

	final guitarMultipleConversionsResult = parseResult(
		"1/4 2/8 3/1
		1/0 2/4
		1/1 2/5
		1/1 2/5
		0/3 1/8 2/12 3/5"
	);

	final ukuleleMultipleConversions = parseInput(
		"ukulele
		5
		1 10
		2 6
		0 3
		3 12
		3 6"
	);

	final ukuleleMultipleConversionsResult = parseResult(
		"0/10 1/15 2/19
		0/2 1/7 2/11 3/16 4/21
		0/8 1/13 2/17
		0/15 1/20
		0/9 1/14 2/18"
	);

	final guitarMultipleConversionsWithNoMatch = parseInput(
		"guitar
		10
		1 18
		5 3
		0 7
		4 3
		2 10
		4 12
		4 11
		1 17
		5 0
		2 10"
	);

	final guitarMultipleConversionsWithNoMatchResult = parseResult(
		"0/8 1/13 3/10
		no match
		0/2 1/7 2/11 3/4
		no match
		1/1 2/5
		no match
		no match
		0/7 1/12 3/9
		no match
		1/1 2/5"
	);
}
