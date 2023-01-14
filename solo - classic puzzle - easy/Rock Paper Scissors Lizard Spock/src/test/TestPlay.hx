package test;
import Main;
using buddy.Should;

@:access(Main)
class TestPlay extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "TestPlay", {

			it( "Test 1 player", {
				final players:Array<Player> = [{ num: 1, sign: Rock, opponents: []}];
				Main.play( players ).num.should.be( 1 );
			});

			it( "Test rock paper", {
				final players:Array<Player> = [
					{ num: 1, sign: Rock, opponents: []},
					{ num: 2, sign: Paper, opponents: []}
				];
				Main.play( players ).num.should.be( 2 );
				Main.play( players ).opponents[0].should.be( 1 );
			});

			it( "Test1", {
				final players:Array<Player> = [
					{ num: 4, sign: Rock, opponents: []},
					{ num: 1, sign: Paper, opponents: []},
					{ num: 8, sign: Paper, opponents: []},
					{ num: 3, sign: Rock, opponents: []},
					{ num: 7, sign: Scissors, opponents: []},
					{ num: 5, sign: Spock, opponents: []},
					{ num: 6, sign: Lizard, opponents: []},
					{ num: 2, sign: Lizard, opponents: []}
				];
				Main.play( players ).num.should.be( 2 );
				Main.play( players ).opponents.join(" ").should.be( "6 5 1" );
			});

		});
	}
}