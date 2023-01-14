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
			
			it( "Tomorrow", {
				final ip = parseInput(
					"0
					Monday Jan 1
					Jan 2"
				);
				Main.process( ip.leapYear, ip.sourceDayOfWeek, ip.sourceMonth, ip.sourceDayOfMonth, ip.targetMonth, ip.targetDayOfMonth )
				.should.be( "Tuesday" );
			});
			
			it( "Yesterday", {
				final ip = parseInput(
					"0
					Tuesday Jan 2
					Jan 1"
				);
				Main.process( ip.leapYear, ip.sourceDayOfWeek, ip.sourceMonth, ip.sourceDayOfMonth, ip.targetMonth, ip.targetDayOfMonth )
				.should.be( "Monday" );
			});
			
			it( "March 1", {
				final ip = parseInput(
					"0
					Monday Feb 1
					Mar 1"
				);
				Main.process( ip.leapYear, ip.sourceDayOfWeek, ip.sourceMonth, ip.sourceDayOfMonth, ip.targetMonth, ip.targetDayOfMonth )
				.should.be( "Monday" );
			});
			
			it( "Sometime next month", {
				final ip = parseInput(
					"0
					Saturday Feb 21
					Mar 1"
				);
				Main.process( ip.leapYear, ip.sourceDayOfWeek, ip.sourceMonth, ip.sourceDayOfMonth, ip.targetMonth, ip.targetDayOfMonth )
				.should.be( "Sunday" );
			});
			
			it( "Sometime next month, leap year", {
				final ip = parseInput(
					"1
					Saturday Feb 21
					Mar 1"
				);
				Main.process( ip.leapYear, ip.sourceDayOfWeek, ip.sourceMonth, ip.sourceDayOfMonth, ip.targetMonth, ip.targetDayOfMonth )
				.should.be( "Monday" );
			});
			
			it( "When was that again?", {
				final ip = parseInput(
					"0
					Friday Sep 13
					Jan 2"
				);
				Main.process( ip.leapYear, ip.sourceDayOfWeek, ip.sourceMonth, ip.sourceDayOfMonth, ip.targetMonth, ip.targetDayOfMonth )
				.should.be( "Wednesday" );
			});
			
			it( "Future", {
				final ip = parseInput(
					"0
					Wednesday Jul 12
					Oct 13"
				);
				Main.process( ip.leapYear, ip.sourceDayOfWeek, ip.sourceMonth, ip.sourceDayOfMonth, ip.targetMonth, ip.targetDayOfMonth )
				.should.be( "Friday" );
			});
			
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final leapYear = parseInt( lines[0] );
		final inputs = lines[1].split(' ');
		final sourceDayOfWeek = inputs[0];
		final sourceMonth = inputs[1];
		final sourceDayOfMonth = parseInt( inputs[2] );
		final inputs = lines[2].split(' ');
		final targetMonth = inputs[0];
		final targetDayOfMonth = parseInt( inputs[1] );
		return { leapYear: leapYear, sourceDayOfWeek: sourceDayOfWeek, sourceMonth: sourceMonth, sourceDayOfMonth: sourceDayOfMonth, targetMonth:targetMonth, targetDayOfMonth: targetDayOfMonth };
	}

}

