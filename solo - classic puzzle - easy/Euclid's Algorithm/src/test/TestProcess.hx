package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "21 / 3", {	
				final ip = parseInput( "21 3" );
				Main.process( ip.a, ip.b ).should.be( result21_3 );
			});
			it( "25 / 3", {	
				final ip = parseInput( "25 3" );
				Main.process( ip.a, ip.b ).should.be( result25_3 );
			});
			it( "50 / 14", {	
				final ip = parseInput( "50 14" );
				Main.process( ip.a, ip.b ).should.be( result50_14 );
			});
			it( "115 / 47", {	
				final ip = parseInput( "115 47" );
				Main.process( ip.a, ip.b ).should.be( result115_47 );
			});
			it( "4857 / 147", {	
				final ip = parseInput( "4857 147" );
				Main.process( ip.a, ip.b ).should.be( result4857_147 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.split(" ");
		final a = parseInt( lines[0] );
		final b = parseInt( lines[1] );

		return { a: a, b: b };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final result21_3 = parseResult(
		"21=3*7+0
		GCD(21,3)=3" );
	
		final result25_3 = parseResult(
		"25=3*8+1
		3=1*3+0
		GCD(25,3)=1" );

	final result50_14 = parseResult(
		"50=14*3+8
		14=8*1+6
		8=6*1+2
		6=2*3+0
		GCD(50,14)=2" );

	final result115_47 = parseResult(
		"115=47*2+21
		47=21*2+5
		21=5*4+1
		5=1*5+0
		GCD(115,47)=1" );

	final result4857_147 = parseResult(
		"4857=147*33+6
		147=6*24+3
		6=3*2+0
		GCD(4857,147)=3" );


}
