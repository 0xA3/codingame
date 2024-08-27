package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "At UTC+01:00", Main.process( "02:24:00 UTC+01:00" ).should.be( "@100.00" ));
			it( "At UTC+01:00, with decimals", Main.process( "16:23:41 UTC+01:00" ).should.be( "@683.11" ));
			it( "At other positive timezones", Main.process( "07:01:05 UTC+07:00" ).should.be( "@42.42" ));
			it( "At negative timezones", Main.process( "17:57:46 UTC-08:00" ).should.be( "@123.45" ));
			it( "At positive timezones with minutes", Main.process( "01:23:45 UTC+11:25" ).should.be( "@624.13" ));
			it( "At negative timezones with minutes", Main.process( "12:24:48 UTC-02:05" ).should.be( "@645.69" ));
			it( "With half-up rounding (odd)", Main.process( "19:09:18 UTC+01:00" ).should.be( "@798.13" ));
			it( "With half-up rounding (even)", Main.process( "03:32:42 UTC-07:30" ).should.be( "@501.88" ));
			it( "With decimal rounding <.1", Main.process( "04:19:40 UTC-09:49" ).should.be( "@631.02" ));
			it( "Loop", Main.process( "20:00:00 UTC-03:00" ).should.be( "@0.00" ));
			it( "From Amsterdam with love", Main.process( "00:03:05 UTC+01:00" ).should.be( "@2.14" ));
		});
	}
}
