package test;

import CodinGame.printErr;
import Std.parseFloat;
import haxe.Int64;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "General number", {
				final ip = generalNumber;
				Main.process( ip[0], ip[1], ip[2] ).should.be( "3 8" );
			});
			it( "Lucky 7", {
				final ip = lucky_7;
				Main.process( ip[0], ip[1], ip[2] ).should.be( "3 6" );
			});
			it( "Lets go bigger!", {
				final ip = letsGoBigger;
				Main.process( ip[0], ip[1], ip[2] ).should.be( "27 28" );
			});
			it( "Extreme ends", {
				final ip = extremeEnds;
				Main.process( ip[0], ip[1], ip[2] ).should.be( "1 100000" );
			});
			it( "Middle pair", {
				final ip = middlePair;
				Main.process( ip[0], ip[1], ip[2] ).should.be( "50000 50001" );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		final n = Int64.parseString( readline() );
		final s = Int64.parseString( readline() );
		final q = Int64.parseString( readline() );
			
		return [n, s, q];
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final generalNumber = parseInput(
		"10
		44
		312"
	);
	
	final lucky_7 = parseInput(
		"7
		19
		95"
	);
	
	final letsGoBigger = parseInput(
		"28
		351
		6201"
	);
	
	final extremeEnds = parseInput(
		"100000
		4999949999
		333328333349999"
	);
	
	final middlePair = parseInput(
		"100000
		4999949999
		333333333249999"
	);
}