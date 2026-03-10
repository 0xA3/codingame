package test;

import CodinGame.printErr;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

	describe( "Test process", {
		it( "Example", {
			final ip = test1;
			Main.process( ip.e, ip.f, ip.s, ip.b ).should.be( test1Result );
		});
		it( "Test 2", {
			final ip = test2;
			Main.process( ip.e, ip.f, ip.s, ip.b ).should.be( test2Result );
		});
		it( "Test 3", {
			final ip = test3;
			Main.process( ip.e, ip.f, ip.s, ip.b ).should.be( test3Result );
		});
		it( "Test 4", {
			final ip = test4;
			Main.process( ip.e, ip.f, ip.s, ip.b ).should.be( test4Result );
		});
		it( "Test 5", {
			final ip = test5;
			Main.process( ip.e, ip.f, ip.s, ip.b ).should.be( test5Result );
		});
	});
	}

	static function parseInput( input:String ) {
		initReadline( input );

		final inputs = readline().split(' ');
		final e = parseInt( inputs[0] );
		final f = parseInt( inputs[1] );
		final s = parseInt( inputs[2] );
		final b = parseInt( inputs[3] );
	
		return { e: e, f: f, s: s, b: b };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"6 550 700 200"
	);

	final test1Result = parseResult(
		"4 Cookie"
	);

	final test2 = parseInput(
		"12 800 600 900"
	);

	final test2Result = parseResult(
		"5 Muffin"
	);

	final test3 = parseInput(
		"12 800 500 500"
	);

	final test3Result = parseResult(
		"4 Cake"
	);

	final test4 = parseInput(
		"12 800 600 600"
	);

	final test4Result = parseResult(
		"4 Cake"
	);

	final test5 = parseInput(
		"8 600 600 600"
	);

	final test5Result = parseResult(
		"4 Cookie"
	);
}