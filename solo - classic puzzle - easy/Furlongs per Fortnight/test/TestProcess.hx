package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Minimal 1",
				Main.process( "1 feet per second CONVERT TO inches per second" )
				.should.be( "12.0 inches per second" )
			);
			it( "Minimal 2",
				Main.process( "60 inches per minute CONVERT TO inches per second" )
				.should.be( "1.0 inches per second" )
			);
			it( "DT -> dt - Test 1",
				Main.process( "790 furlongs per fortnight CONVERT TO chains per week" )
				.should.be( "3950.0 chains per week" )
			);
			it( "D -> d - Test 2",
				Main.process( "430 miles per day CONVERT TO feet per day" )
				.should.be( "2270400.0 feet per day" )
			);
			it( "Dt -> dT - Test 3",
				Main.process( "427 furlongs per week CONVERT TO feet per fortnight" )
				.should.be( "563640.0 feet per fortnight" )
			);
			it( "dT -> Dt - Test 4",
				Main.process( "938 feet per day CONVERT TO chains per hour" )
				.should.be( "0.6 chains per hour" )
			);
			it( "d -> D - Test 5",
				Main.process( "461 feet per hour CONVERT TO chains per hour" )
				.should.be( "7.0 chains per hour" )
			);
			it( "dt -> DT - Test 6",
				Main.process( "965 inches per second CONVERT TO furlongs per minute" )
				.should.be( "7.3 furlongs per minute" )
			);
			it( "T -> t - Test 7",
				Main.process( "628 yards per week CONVERT TO yards per minute" )
				.should.be( "0.1 yards per minute" )
			);
			it( "t -> T - Test 8",
				Main.process( "135 miles per minute CONVERT TO miles per day" )
				.should.be( "194400.0 miles per day" )
			);
			it( "miles to inches - Test 9",
				Main.process( "509 miles per week CONVERT TO inches per second" )
				.should.be( "53.3 inches per second" )
			);
			it( "inches to miles - Test 10",
				Main.process( "142 inches per second CONVERT TO miles per week" )
				.should.be( "1355.5 miles per week" )
			);
			it( "fortnights to seconds - Test 11",
				Main.process( "334 furlongs per fortnight CONVERT TO inches per second" )
				.should.be( "2.2 inches per second" )
			);
			it( "seconds to fortnights - Test 12",
				Main.process( "709 inches per second CONVERT TO chains per fortnight" )
				.should.be( "1082836.4 chains per fortnight" )
			);
			it( "Extreme1 - Test 13",
				Main.process( "242 inches per second CONVERT TO miles per fortnight" )
				.should.be( "4620.0 miles per fortnight" )
			);
			it( "Extreme2 - Test 14",
				Main.process( "672 miles per fortnight CONVERT TO inches per second" )
				.should.be( "35.2 inches per second" )
			);
		});
	}
}
