package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.a, ip.b ).should.be( 2 );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.a, ip.b ).should.be( 17 );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.a, ip.b ).should.be( -1000000000 );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.a, ip.b ).should.be( -1999999395 );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.a, ip.b ).should.be( 9221165894 );
			});
			it( "Test 6", {
				final ip = test6;
				Main.process( ip.a, ip.b ).should.be( 0 );
			});
			it( "Test 7", {
				final ip = test7;
				Main.process( ip.a, ip.b ).should.be( -213982941 );
			});
			
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return { a: lines[0], b: lines[1] };
	}

	final test1 = parseInput(
		"500000001 1 499999999 -1
		1000000000 1"
	);

	final test2 = parseInput(
		"5 1 5 2 999999990 0
		3 1 3 2 3 1 999999991 0"
	);

	final test3 = parseInput(
		"1000000000 1
		1000000000 -1"
	);

	final test4 = parseInput(
		"1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 999999945 -1
		999999945 2 10 10 9 9 8 8 7 7 6 6 5 5 4 4 3 3 2 2 1 1"
	);

	final test5 = parseInput(
		"61293583 -5 60141391 -10 30705144 6 18209987 8 3623360 -5 3715666 4 18252771 -5 24739354 7 107410335 -1 18585831 1 37735014 9 4459884 -3 10163437 -6 67811650 10 49967223 3 29661998 1 34417955 8 5997538 -5 12037693 0 12536915 1 35929119 10 17059584 -4 10232854 7 13870276 6 3519983 6 55936984 7 72768589 2 29183804 -3 33351647 7 20893540 5 17190111 1 27370514 5 17869452 -3 1811597 10 31545217 -10
		29853135 2 7370169 0 9807376 -5 90278577 -7 27976028 -3 131519266 1 68154 -9 2173005 -9 40036660 5 63310669 9 25674306 -10 24212637 -3 29203142 2 79327039 2 18493184 -9 1854019 1 47335765 -5 38838995 10 49608857 1 13201908 3 85586590 4 30040431 -10 30620504 6 16642661 2 52716485 5 31264011 -5 22986427 -5"
	);

	final test6 = parseInput(
		"100000000 1 100000000 1 100000000 1 100000000 1 100000000 1 100000000 1 100000000 1 100000000 1 100000000 1 100000000 1
		100000000 1 100000000 -1 100000000 1 100000000 -1 100000000 1 100000000 -1 100000000 1 100000000 -1 100000000 1 100000000 -1"
	);

	final test7 = parseInput(
		"26751891 1 12423842 0 24697032 -1 75825948 0 16058842 -1 5056344 -1 14781040 -1 48256886 0 37330872 1 68962932 1 37555307 1 2970721 0 26201429 1 48967194 -1 17837665 0 74719356 -2 17461041 -2 20765736 0 15044838 1 6518283 -2 10432178 -2 15225674 -2 6160520 0 32060077 0 52545144 0 3848757 -2 91480452 -1 99032044 1 89501141 1 1526814 0
		40312847 1 84841395 -2 43849784 1 3228664 -1 98445257 -1 22318921 0 42672597 0 4577041 0 5240860 -2 31151717 1 30451395 -2 35469153 -2 25313187 -2 40128193 1 15893237 1 6369211 1 3672509 -1 22259551 0 25942846 -2 12180032 1 4202901 0 68816164 1 520373 -2 107835622 1 50661951 -2 67145499 0 88144650 -1 18354443 -1"
	);

}
