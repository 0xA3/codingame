package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Starting with oldest - Test 1",
			Main.process( "Authority Bills Capture" )
			.should.be( "Apples Butter Charlie" ));
			
			it( "Then next oldest - Test 2",
			Main.process( "Harry Edward London London Orange" )
			.should.be( "Havana Edison Liverpool Liverpool Oslo" ));
			
			it( "Almost current - Test 3",
			Main.process( "Washington Oslo Roma Liverpool Denmark" )
			.should.be( "Whiskey Oscar Romeo Lima Delta" ));
			
			it( "Let's Regress - Test 4",
			Main.process( "Romeo Echo Golf Romeo Echo Sierra Sierra" )
			.should.be( "Remarks Englishmen Galloping Remarks Englishmen Support Support" ));
			
			it( "Rest are random - Test 5",
			Main.process( "Tripoli Havana Edison Quebec Uppsala Italia Casablanca Kilogramme" )
			.should.be( "Tango Hotel Echo Quebec Uniform India Charlie Kilo" ));
			
			it( "Test 6",
			Main.process( "Bravo Romeo Oscar Whiskey November Foxtrot Oscar X-ray" )
			.should.be( "Bills Remarks Owners When Never Fractious Owners Xpeditiously" ));
			
			it( "Test 7",
			Main.process( "Lima Alfa Zulu Yankee Delta Oscar Golf" )
			.should.be( "Loose Authority Zigzag Your Destroy Owners Galloping" ));
			
			it( "Test 8",
			Main.process( "Tommy Harry Edward Queenie Uncle Ink Charlie King" )
			.should.be( "Tripoli Havana Edison Quebec Uppsala Italia Casablanca Kilogramme" ));
			
			it( "Test 9",
			Main.process( "Tango Hotel Echo Quebec Uniform India Charlie Kilo" )
			.should.be( "The High Englishmen Queen Unless Invariably Capture Knights" ));
			
			it( "Charlie is here - Test 10",
			Main.process( "Charlie Charlie Delta" )
			.should.be( "Capture Capture Destroy" ));
			
			it( "Charlie is here too - Test 11",
			Main.process( "Charlie Charlie Duff" )
			.should.be( "Casablanca Casablanca Denmark" ));
			
			it( "Is it This Quebec or ... ?? - Test 12",
			Main.process( "Quebec Quebec Roma" )
			.should.be( "Quebec Quebec Romeo" ));
			
			it( "... or That Quebec ?? - Test 13",
			Main.process( "Quebec Quebec Romeo Sierra" )
			.should.be( "Queen Queen Remarks Support" ));
			
			it( "Which alphabet has both - Test 14",
			Main.process( "Charlie Quebec Charlie Quebec" )
			.should.be( "Capture Queen Capture Queen" ));
			
		});
	}
}
