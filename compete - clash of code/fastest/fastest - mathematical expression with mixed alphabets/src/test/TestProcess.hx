package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "1+1", { Main.process( "A1B+C1" ).should.be( 2 ); });
			it( "111115-22251", { Main.process( "jiof11111ewn5oaoue-HOUHU222FNWP5FI1WIF" ).should.be( 88864 ); });
			it( "23554/51", { Main.process( "ngoeF23EJn5fAbfepFEOIfjir54eAbf/egirgnFt5tHWOv1s" ).should.be( 461 ); });
			it( "32%5", { Main.process( "diewugfei3fneowu2fneoG%IY5fefjio" ).should.be( 2 ); });
			it( "45**5", { Main.process( "4houhw5houf**fhwou5fhewo" ).should.be( 184528125 ); });
		});
	}
}
