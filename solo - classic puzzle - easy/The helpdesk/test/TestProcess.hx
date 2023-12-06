package test;

import Std.parseFloat;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Example", {
				final ip = example;
				Main.process( ip.worktime, ip.efficiencies, ip.helptimes ).should.be( exampleResult );
			});
			it( "Short day", {
				final ip = shortDay;
				Main.process( ip.worktime, ip.efficiencies, ip.helptimes ).should.be( shortDayResult );
			});
			it( "So efficient!", {
				final ip = soEfficient;
				Main.process( ip.worktime, ip.efficiencies, ip.helptimes ).should.be( soEfficientResult );
			});
			it( "Employee of the month", {
				final ip = employeeOfTheMonth;
				Main.process( ip.worktime, ip.efficiencies, ip.helptimes ).should.be( employeeOfTheMonthResult );
			});
			it( "Just home before the break", {
				final ip = justHomeBeforeTheBreak;
				Main.process( ip.worktime, ip.efficiencies, ip.helptimes ).should.be( justHomeBeforeTheBreakResult );
			});
			@include it( "Why do they keep taking breaks?!", {
				final ip = whyDoTheyKeepTakingBreaks;
				Main.process( ip.worktime, ip.efficiencies, ip.helptimes ).should.be( whyDoTheyKeepTakingBreaksResult );
			});
			it( "Why do they keep taking breaks?! 2", {
				final ip = whyDoTheyKeepTakingBreaks2;
				Main.process( ip.worktime, ip.efficiencies, ip.helptimes ).should.be( whyDoTheyKeepTakingBreaks2Result );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final worktime = parseInt( lines[0] );
		final nc = parseInt( lines[1] );
		var inputs1 = lines[2].split(' ');
		final efficiencies = [for( i in 0...nc ) parseFloat( inputs1[i] )];
	
		final nv = parseInt( lines[3] );
		var inputs2 = lines[4].split(' ');
		final helptimes = [for( i in 0...nv ) parseInt( inputs2[i] )];
	
		return { worktime: worktime, efficiencies: efficiencies, helptimes: helptimes }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final example = parseInput(
		"20
		2
		2 1
		3
		40 30 10"
	);

	final exampleResult = parseResult(
		"2 1
		1 0"
	);

	final shortDay = parseInput(
		"100
		2
		1 1
		5
		40 16 12 8 4"
	);

	final shortDayResult = parseResult(
		"1 4
		0 0"
	);

	final soEfficient = parseInput(
		"180
		4
		2 1 1.5 2
		15
		28 16 26 19 48 20 28 14 33 33 26 21 22 16 43"
	);

	final soEfficientResult = parseResult(
		"4 3 4 4
		0 0 0 0"
	);

	final employeeOfTheMonth = parseInput(
		"40
		8
		0.5 0.5 0.5 2 0.5 0.5 0.5 0.5
		28
		180 180 180 10 180 180 180 180 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10"
	);

	final employeeOfTheMonthResult = parseResult(
		"1 1 1 21 1 1 1 1
		0 0 0 2 0 0 0 0"
	);

	final justHomeBeforeTheBreak = parseInput(
		"20
		2
		1 2
		3
		30 40 10"
	);

	final justHomeBeforeTheBreakResult = parseResult(
		"1 2
		0 1"
	);

	final whyDoTheyKeepTakingBreaks = parseInput(
		"20
		6
		1 0.5 0.75 1.25 1.5 1
		30
		50 50 10 50 30 20 60 30 40 40 60 60 50 10 10 10 50 10 20 70 10 40 10 40 60 40 40 40 20 70"
	);

	final whyDoTheyKeepTakingBreaksResult = parseResult(
		"4 4 4 7 7 4
		3 3 1 4 5 3"
	);

	final whyDoTheyKeepTakingBreaks2 = parseInput(
		"20
		5
		0.5 0.75 1 1.25 0.5
		25
		30 40 30 40 60 10 30 40 10 20 60 30 40 70 20 60 10 70 10 20 40 51 60 40 20"
	);

	final whyDoTheyKeepTakingBreaks2Result = parseResult(
		"3 6 8 6 2
		2 4 5 4 2"
	);
}
