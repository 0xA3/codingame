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
			
			it( "Tests", {
				Main.process( tests ).should.be( "YES\nNO" );
			});
			
			it( "MasterCard", {
				Main.process( masterCard ).should.be( "YES\nNO\nNO" );
			});
			
			it( "Discover", {
				Main.process( discover ).should.be( "YES\nYES\nYES\nYES" );
			});
			
			it( "VISA", {
				Main.process( visa ).should.be( "NO\nYES\nNO\nNO" );
			});
			
		});

	}

	static function parseInput( input:String ) {
		final lines = input.split( "\n" );
		final cards = [for( i in 1...lines.length) lines[i].trim()];
		return cards;
	}

	final tests = parseInput(
	"2
	4556 7375 8689 9855
	4024 0071 0902 2143" );
	
	final masterCard = parseInput(
	"3
	5143 5635 7879 4533
	2221 0047 4685 5642
	2221 0086 7467 3005" );
	
	final discover = parseInput(
	"4
	6011 4504 4601 6538
	6011 3533 1952 3079
	6011 6137 9062 4575
	6011 3208 9899 2827" );
	
	final visa = parseInput(
	"4
	4916 9040 0624 3561
	4532 0616 6103 7334
	4485 9117 2097 0646
	4916 8075 8881 2287" );

}

