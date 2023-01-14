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
			
			it( "just a item drop", {
				final input = parseInput(
				"9
				101001010" );
				Main.process( input.n, input.packet ).should.be( "001001010" );
			});
			
			it( "more than 1 drop", {
				final input = parseInput(
				"17
				10100010101001011" );
				Main.process( input.n, input.packet ).should.be( "00100010001001011" );
			});
			
			it( "other packets", {
				final input = parseInput(
				"17
				00100101110100011" );
				Main.process( input.n, input.packet ).should.be( "00100011" );
			});
			
			it( "In between", {
				final input = parseInput(
				"27
				111000111010010110010011101" );
				Main.process( input.n, input.packet ).should.be( "001001011" );
			});
			
			it( "that is a long one", {
				final input = parseInput(
				"63
				100100111100001001001011001010100111011110011110101100011100011" );
				Main.process( input.n, input.packet ).should.be( "0010011101001100011100011" );
			});
			
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final n = parseInt( lines[0] );
		final packet = lines[1];
		return { n: n, packet: packet };
	}

}

