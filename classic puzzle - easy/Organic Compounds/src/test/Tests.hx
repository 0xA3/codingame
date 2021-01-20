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
			
			it( "Saturated hydrocarbon (valid)", {
				final lines = parseInput(
					"1
					CH3(1)CH2(1)CH3"
				 );
				Main.process( lines ).should.be( "VALID" );
			});
			
			it( "Unsaturated hydrocarbon (valid)", {
				final lines = parseInput(
					"1
					CH2(2)CH1(1)CH3"
				 );
				Main.process( lines ).should.be( "VALID" );
			});

			it( "hydrocarbon with 1 substituent", {
				final lines = parseInput(
					"3
					CH3   CH3
					(1)   (1)
					CH2(1)CH1(1)CH3"
				 );
				Main.process( lines ).should.be( "VALID" );
			});

			it( "multiple substituents (invalid)", {
				final lines = parseInput(
					"5
					CH3(1)CH1(1)CH2(1)CH1(1)CH3
						  (1)         (1)
						  CH3         CH1(1)CH1(1)CH3
									  (1)
									  CH3"
				 );
				Main.process( lines ).should.be( "INVALID" );
			});

			it( "Unsaturated hydrocarbon with substituents", {
				final lines = parseInput(
					"5
					CH2(2)CH0(1)CH1(2)CH0(1)CH3
						  (1)         (1)
						  CH0         CH1(1)CH2(1)CH3
						  (3)         (1)
						  CH1         CH3"
				 );
				Main.process( lines ).should.be( "VALID" );
			});

			it( "INVALID", {
				final lines = parseInput(
					"5
					CH2(2)CH0(1)CH1(2)CH0(1)CH3
						  (1)         (1)
						  CH1         CH1(1)CH2(1)CH3
						  (2)         (2)
						  CH2         CH3"
				 );
				Main.process( lines ).should.be( "INVALID" );
			});

			it( "Cyclic Hydrocarbon", {
				final lines = parseInput(
					"3
					CH2(1)CH2
					(1)   (1)
					CH2(1)CH2"
				 );
				Main.process( lines ).should.be( "VALID" );
			});

			it( "Cyclic Hydrocarbon with substituents", {
				final lines = parseInput(
					"5
					CH2(1)CH2(1)CH2
					(1)         (1)
					CH2         CH1(2)CH3
					(1)         (1)
					CH2(1)CH2(1)CH2"
				 );
				Main.process( lines ).should.be( "INVALID" );
			});

			it( "2 Carbon cycles", {
				final lines = parseInput(
					"5
					CH2(1)CH2(1)CH1(1)CH2
					(1)         (1)   (1)
					CH2         CH2   CH2
					(1)         (1)   (1)
					CH2(1)CH2(1)CH1(1)CH2"
				 );
				Main.process( lines ).should.be( "VALID" );
			});

			it( "Enormous Compound", {
				final lines = parseInput(
					"11
					CH2(1)CH1(1)CH1(1)CH2
					(1)   (1)   (1)   (1)
					CH2   CH3   CH2   CH2
					(1)         (1)   (1)
					CH2(1)CH1(1)CH1(1)CH1
						  (1)         (1)
						  CH2   CH1(1)CH1(1)CH3
						  (1)   (2)
						  CH2   CH1(2)CH1
						  (1)         (1)
						  CH2(1)CH1(2)CH4"
				 );
				Main.process( lines ).should.be( "INVALID" );
			});

			it( "Codingame", {
				final lines = parseInput(
					"7
					CH2(1)CH1(1)CH1(1)CH3
					(1)         (1)
					CH2         CH2
					(1)         (1)
					CH2         CH2   CH3
					(1)         (1)   (1)
					CH2(1)CH3   CH2(1)CH2"
				 );
				Main.process( lines ).should.be( "INVALID" );
			});

		});
	}

	static function parseInput( input:String ) {
		final lines = input.split( "\n" );
		return [for( i in 1...lines.length ) {
			lines[i].replace( "\r", "" ).replace( "\t", "    " ).substr( 20 );
		}];

	}

}
