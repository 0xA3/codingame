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
			
			it( "Example", {
				final input = example;
				Main.process( input.speeds, input.bends ).should.be( exampleResult );
			});
			
			it( "Stalling", {
				final input = stalling;
				Main.process( input.speeds, input.bends ).should.be( stallingResult );
			});
			
			it( "Real case", {
				final input = realCase;
				Main.process( input.speeds, input.bends ).should.be( realCaseResult );
			});
			
			it( "Just a little one", {
				final input = justALittleOne;
				Main.process( input.speeds, input.bends ).should.be( justALittleOneResult );
			});
			
			it( "Duel", {
				final input = duel;
				Main.process( input.speeds, input.bends ).should.be( duelResult );
			});
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final n = parseInt( lines[0] );
		final v = parseInt( lines[1] );
		
		final speeds = [for( i in 0...n ) parseInt( lines[i + 2] )];
		final bends = [for( i in 0...v ) parseInt( lines[i + n + 2] )];
		
		return { speeds: speeds, bends: bends };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final example = parseInput(
		"8
		2
		56
		6
		2
		23
		9
		25
		41
		15
		40
		30"
	);

	final exampleResult = parseResult(
		"22
		y
		h
		e
		b
		c
		f
		d
		a
		g"
	);
	
	final stalling = parseInput(
		"11
		3
		20
		15
		48
		13
		53
		33
		3
		37
		22
		42
		17
		160
		80
		20"
	);

	final stallingResult = parseResult(
		"18
		y
		k
		b
		d
		g
		f
		i
		a
		c
		j
		h
		e"
	);

	final realCase = parseInput(
		"11
		7
		25
		48
		35
		41
		26
		15
		32
		37
		9
		46
		6
		130
		120
		110
		100
		90
		80
		50"
	);

	final realCaseResult = parseResult(
		"29
		y
		e
		a
		f
		i
		k
		c
		g
		h
		d
		j
		b"
	);

	final justALittleOne = parseInput(
		"11
		1
		25
		17
		35
		11
		2
		15
		22
		56
		8
		46
		6
		5"
	);

	final justALittleOneResult = parseResult(
		"9
		y
		i
		k
		e
		h
		j
		c
		a
		g
		b
		f
		d"
	);

	final duel = parseInput(
		"1
		1
		32
		60"
	);

	final duelResult = parseResult(
		"31
		y
		a"
	);

}

