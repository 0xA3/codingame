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
			
			it( "One rotation", {
				final input = parseInput(
				"z
				D
				L" );
				Main.process( input.rotations, input.faces ).should.be( "L\nU" );
			});
			
			it( "Two rotations", {
				final input = parseInput(
				"y z'
				B
				D" );
				Main.process( input.rotations, input.faces ).should.be( "U\nR" );
			});
			
			it( "Give me five!", {
				final input = parseInput(
				"x y x' z y'
				L
				B" );
				Main.process( input.rotations, input.faces ).should.be( "B\nL" );
			});
			
			it( "Identity", {
				final input = parseInput(
				"x y x y x y
				F
				D" );
				Main.process( input.rotations, input.faces ).should.be( "F\nD" );
			});
			
			it( "A long route", {
				final input = parseInput(
				"x y z x z y y x z y z x z x y z y x
				L
				F" );
				Main.process( input.rotations, input.faces ).should.be( "F\nD" );
			});
			
			it( "Stuttering", {
				final input = parseInput(
				"x x x y y y z z z
				B
				U" );
				Main.process( input.rotations, input.faces ).should.be( "L\nU" );
			});
			
		});
			
	}

	static function parseInput( s:String ) {
		final lines = s.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return { rotations: lines[0].split(" "), faces: lines.slice( 1 ) };
	}
	
}

