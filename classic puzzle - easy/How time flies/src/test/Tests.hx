package test;

import haxe.Int64;
import Main;
import Std.parseInt;
import Std.parseFloat;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
			describe( "Test process", {
			
			it( "Full years", {
				final input = parseInput(
				"01.01.2000
				01.01.2016" );
				Main.process( input.begin, input.end ).should.be( "16 years, total 5844 days" );
			});
			
			it( "Full months", {
				final input = parseInput(
				"01.01.2016
				01.08.2016" );
				Main.process( input.begin, input.end ).should.be( "7 months, total 213 days" );
			});
			
			it( "Years and months", {
				final input = parseInput(
				"01.11.2015
				01.02.2017" );
				Main.process( input.begin, input.end ).should.be( "1 year, 3 months, total 458 days" );
			});
			
			it( "Days only", {
				final input = parseInput(
				"17.12.2016
				16.01.2017" );
				Main.process( input.begin, input.end ).should.be( "total 30 days" );
			});
			
			it( "Same date", {
				final input = parseInput(
				"01.01.2016
				01.01.2016" );
				Main.process( input.begin, input.end ).should.be( "total 0 days" );
			});
			
			it( "Complex", {
				final input = parseInput(
				"28.02.2015
				13.04.2018" );
				Main.process( input.begin, input.end ).should.be( "3 years, 1 month, total 1140 days" );
			});
			
			it( "One month", {
				final input = parseInput(
				"28.01.2015
				28.02.2015" );
				Main.process( input.begin, input.end ).should.be( "1 month, total 31 days" );
			});
			
			it( "One year", {
				final input = parseInput(
				"17.03.2022
				17.03.2023" );
				Main.process( input.begin, input.end ).should.be( "1 year, total 365 days" );
			});
			
			it( "Leap year", {
				final input = parseInput(
				"17.02.2024
				17.02.2025" );
				Main.process( input.begin, input.end ).should.be( "1 year, total 366 days" );
			});
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return { begin: lines[0], end: lines[1] };
	}

}

