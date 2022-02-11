package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Fish Example depth 2", {
				final ip = fishExampleDepth2;
				Main.process( ip.t, ip.d, ip.l, ip.s ).should.be( "fish is bad and" );
			});
			it( "Fish Example depth 1", {
				final ip = fishExampleDepth1;
				Main.process( ip.t, ip.d, ip.l, ip.s ).should.be( "one fish is good" );
			});
			it( "Width 2", {
				final ip = width2;
				Main.process( ip.t, ip.d, ip.l, ip.s ).should.be( "dorothy was a girl named dorothy stop dorothy had a" );
			});
			it( "Width 3", {
				final ip = width3;
				Main.process( ip.t, ip.d, ip.l, ip.s ).should.be( "stop dorothy had a dog named toto stop dorothy lived" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final t = lines[0];
		final d = parseInt( lines[1] );
		final l = parseInt( lines[2] );
		final s = lines[3];
		return { t:t, d:d, l:l, s:s }
	}

	final fishExampleDepth2 = parseInput(
		"one fish is good and no fish is bad and that is it
		2
		4
		fish is"
	);

	final fishExampleDepth1 = parseInput(
		"one fish is good and no fish is bad and that is it
		1
		4
		one"
	);

	final width2 = parseInput(
		"stop there once was a girl named dorothy stop dorothy had a dog named toto stop dorothy lived with her aunt and uncle with her dog named toto stop she was a girl of who dreamed of traveling stop
		2
		10
		dorothy was a"
	);

	final width3 = parseInput(
		"stop there once was a girl named dorothy stop dorothy had a dog named toto stop dorothy lived with her aunt and uncle with her dog named toto stop she was a girl of who dreamed of traveling stop
		3
		10
		stop dorothy had"
	);
}

