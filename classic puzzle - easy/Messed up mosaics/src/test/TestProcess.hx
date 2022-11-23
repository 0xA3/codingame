package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Small mosaic", {
				final ip = smallMosaic;
				Main.process( ip.pattern, ip.rows ).should.be( "(2,1)" );
			});
			it( "2-tiles pattern, aligned", {
				final ip = twoTilesPatternAligned;
				Main.process( ip.pattern, ip.rows ).should.be( "(2,3)" );
			});
			it( "2-tiles pattern, staggered", {
				final ip = twoTilesPatternStaggered;
				Main.process( ip.pattern, ip.rows ).should.be( "(5,2)" );
			});
			it( "4-tiles pattern, aligned", {
				final ip = fourTilesPatternAligned;
				Main.process( ip.pattern, ip.rows ).should.be( "(19,13)" );
			});
			it( "6-tiles pattern, staggered", {
				final ip = sixTilesPatternStaggered;
				Main.process( ip.pattern, ip.rows ).should.be( "(6,2)" );
			});
			it( "Stagger Fever", {
				final ip = staggerFever;
				Main.process( ip.pattern, ip.rows ).should.be( "(0,33)" );
			});
			it( "Wavy pattern", {
				final ip = wavyPattern;
				Main.process( ip.pattern, ip.rows ).should.be( "(16,16)" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final pattern = lines[1];
		final rows = lines.slice( 2 );
		
		return { pattern: pattern, rows: rows }
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final smallMosaic = parseInput(
	"6
	xO
	xOxOxO
	xO/OxO
	xOxOxO
	xOxOxO
	xOxOxO
	xOxOxO" );

	final twoTilesPatternAligned = parseInput(
	"18
	^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^vvv^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v
	^v^v^v^v^v^v^v^v^v" );

	final twoTilesPatternStaggered = parseInput(
	"12
	~#
	~#~#~#~#~#~#
	#~#~#~#~#~#~
	~#~#~~~#~#~#
	#~#~#~#~#~#~
	~#~#~#~#~#~#
	#~#~#~#~#~#~
	~#~#~#~#~#~#
	#~#~#~#~#~#~
	~#~#~#~#~#~#
	#~#~#~#~#~#~
	~#~#~#~#~#~#
	#~#~#~#~#~#~" );

	final fourTilesPatternAligned = parseInput(
	"24
	|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\__|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/
	|\\_/|\\_/|\\_/|\\_/|\\_/|\\_/" );

	final sixTilesPatternStaggered = parseInput(
	"16
	_-'\"'-
	_-'\"'-_-'\"'-_-'\"
	\"'-_-'\"'-_-'\"'-_
	_-'\"'-'-'\"'-_-'\"
	\"'-_-'\"'-_-'\"'-_
	_-'\"'-_-'\"'-_-'\"
	\"'-_-'\"'-_-'\"'-_
	_-'\"'-_-'\"'-_-'\"
	\"'-_-'\"'-_-'\"'-_
	_-'\"'-_-'\"'-_-'\"
	\"'-_-'\"'-_-'\"'-_
	_-'\"'-_-'\"'-_-'\"
	\"'-_-'\"'-_-'\"'-_
	_-'\"'-_-'\"'-_-'\"
	\"'-_-'\"'-_-'\"'-_
	_-'\"'-_-'\"'-_-'\"
	\"'-_-'\"'-_-'\"'-_" );

	final staggerFever = parseInput(
	"36
	_~#~
	_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~
	~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_
	#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~
	~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#
	_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~
	~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_
	#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~
	~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#
	_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~
	~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_
	#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~
	~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#
	_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~
	~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_
	#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~
	~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#
	_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~
	~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_
	#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~
	~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#
	_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~
	~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_
	#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~
	~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#
	_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~
	~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_
	#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~
	~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#
	_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~
	~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_
	#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~
	~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#
	_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~
	##~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_
	#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~
	~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#~_~#" );

	final wavyPattern = parseInput(
	"30
	{-_-}-_-
	{-_-}-_-{-_-}-_-{-_-}-_-{-_-}-
	-_-}-_-{-_-}-_-{-_-}-_-{-_-}-_
	_-}-_-{-_-}-_-{-_-}-_-{-_-}-_-
	-_-}-_-{-_-}-_-{-_-}-_-{-_-}-_
	{-_-}-_-{-_-}-_-{-_-}-_-{-_-}-
	-{-_-}-_-{-_-}-_-{-_-}-_-{-_-}
	_-{-_-}-_-{-_-}-_-{-_-}-_-{-_-
	-{-_-}-_-{-_-}-_-{-_-}-_-{-_-}
	{-_-}-_-{-_-}-_-{-_-}-_-{-_-}-
	-_-}-_-{-_-}-_-{-_-}-_-{-_-}-_
	_-}-_-{-_-}-_-{-_-}-_-{-_-}-_-
	-_-}-_-{-_-}-_-{-_-}-_-{-_-}-_
	{-_-}-_-{-_-}-_-{-_-}-_-{-_-}-
	-{-_-}-_-{-_-}-_-{-_-}-_-{-_-}
	_-{-_-}-_-{-_-}-_-{-_-}-_-{-_-
	-{-_-}-_-{-_-}-_-{-_-}-_-{-_-}
	{-_-}-_-{-_-}-_-}-_-}-_-{-_-}-
	-_-}-_-{-_-}-_-{-_-}-_-{-_-}-_
	_-}-_-{-_-}-_-{-_-}-_-{-_-}-_-
	-_-}-_-{-_-}-_-{-_-}-_-{-_-}-_
	{-_-}-_-{-_-}-_-{-_-}-_-{-_-}-
	-{-_-}-_-{-_-}-_-{-_-}-_-{-_-}
	_-{-_-}-_-{-_-}-_-{-_-}-_-{-_-
	-{-_-}-_-{-_-}-_-{-_-}-_-{-_-}
	{-_-}-_-{-_-}-_-{-_-}-_-{-_-}-
	-_-}-_-{-_-}-_-{-_-}-_-{-_-}-_
	_-}-_-{-_-}-_-{-_-}-_-{-_-}-_-
	-_-}-_-{-_-}-_-{-_-}-_-{-_-}-_
	{-_-}-_-{-_-}-_-{-_-}-_-{-_-}-
	-{-_-}-_-{-_-}-_-{-_-}-_-{-_-}" );
}
