package test;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Simple expression", {
				Main.process( "1m + 1cm" ).should.be( "101cm" );
			});
			it( "Same units", {
				Main.process( "459m + 132m" ).should.be( "591m" );
			});
			it( "Kilometers to decimeters", {
				Main.process( "1km + 14dm" ).should.be( "10014dm" );
			});
			it( "Kilometers to millimeters", {
				Main.process( "0.02km + 450mm" ).should.be( "20450mm" );
			});
			it( "Meters to centimeters", {
				Main.process( "2.55m + 35cm" ).should.be( "290cm" );
			});
			it( "Meters to millimeters", {
				Main.process( "0.22532m + 90mm" ).should.be( "315.32mm" );
			});
			it( "Centimeters to millimeters", {
				Main.process( "0.00098cm + 10mm" ).should.be( "10.0098mm" );
			});
			it( "Decimeters to micrometers", {
				Main.process( "0.01dm + 3210um" ).should.be( "4210um" );
			});
			it( "Millimeters to micrometers", {
				Main.process( "16.0408mm + 11um" ).should.be( "16051.8um" );
			});
		});

	}
}

