package test;

import CodinGame.printErr;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

	describe( "Test process", {
		it( "Example", Main.process( example ).should.be( exampleResult ));
		it( "Player 1 Win", Main.process( player_1Win ).should.be( player_1WinResult ));
		it( "Player 2 Win", Main.process( player_2Win ).should.be( player_2WinResult ));
		it( "Snapless", Main.process( snapless ).should.be( snaplessResult ));
		it( "Clutch Save", Main.process( clutchSave ).should.be( clutchSaveResult ));
		it( "Almost Clutch Save", Main.process( almostClutchSave ).should.be( almostClutchSaveResult ));
		it( "Quick Game", Main.process( quickGame ).should.be( quickGameResult ));
		it( "Very Quick Game", Main.process( veryQuickGame ).should.be( veryQuickGameResult ));
		it( "Lucky Shuffle", Main.process( luckyShuffle ).should.be( luckyShuffleResult ));
		it( "Unfair Shuffle 1", Main.process( unfairShuffle1 ).should.be( unfairShuffle1Result ));
		it( "Unfair Shuffle 2", Main.process( unfairShuffle2 ).should.be( unfairShuffle2Result ));
		it( "Unfair Shuffle 3", Main.process( unfairShuffle3 ).should.be( unfairShuffle3Result ));
		it( "Standard Deck 1", Main.process( standardDeck1 ).should.be( standardDeck1Result ));
		it( "Standard Deck 2", Main.process( standardDeck2 ).should.be( standardDeck2Result ));
		it( "Standard Deck 3", Main.process( standardDeck3 ).should.be( standardDeck3Result ));
		it( "Standard Deck 4", Main.process( standardDeck4 ).should.be( standardDeck4Result ));
		it( "Standard Deck 5", Main.process( standardDeck5 ).should.be( standardDeck5Result ));
		it( "Standard Deck 6", Main.process( standardDeck6 ).should.be( standardDeck6Result ));
	});
	}

	static function parseInput( input:String ) {
		initReadline( input );

		final m = parseInt(readline());
		final cardsPlayer1 = [for( i in 0...m ) readline()];
		
		final n = parseInt(readline());
		final cardsPlayer2 = [for( i in 0...n ) readline()];

		return [cardsPlayer1, cardsPlayer2];
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final example = parseInput(
		"5
		5S
		6D
		10D
		5D
		JC
		5
		3H
		7S
		5C
		KH
		9S"
	);

	final exampleResult = parseResult(
		"Winner: Player 1
		6"
	);

	final player_1Win = parseInput(
		"4
		5S
		6D
		5D
		10D
		4
		3H
		7S
		5C
		KH"
	);

	final player_1WinResult = parseResult(
		"Winner: Player 1
		6"
	);

	final player_2Win = parseInput(
		"5
		3S
		5D
		KC
		3C
		4H
		5
		JH
		9C
		KS
		8H
		JC"
	);

	final player_2WinResult = parseResult(
		"Winner: Player 2
		6"
	);

	final snapless = parseInput(
		"10
		6D
		3C
		7D
		2D
		2S
		7S
		8S
		3H
		JD
		QD
		10
		KS
		4H
		6S
		9C
		JC
		5C
		JS
		KH
		4C
		JH"
	);

	final snaplessResult = parseResult(
		"Winner: Player 2
		1"
	);

	final clutchSave = parseInput(
		"14
		JC
		8C
		4C
		3S
		AC
		6D
		7C
		QH
		4S
		5C
		6H
		2C
		KD
		8S
		14
		3D
		9H
		QC
		KH
		7S
		5D
		KS
		5H
		KC
		8D
		7D
		JH
		8H
		9D"
	);

	final clutchSaveResult = parseResult(
		"Winner: Player 1
		26"
	);

	final almostClutchSave = parseInput(
		"26
		QD
		10D
		8C
		5H
		KC
		8S
		9D
		9H
		AH
		7D
		4C
		2D
		7H
		QS
		4S
		3D
		10H
		KH
		7S
		6S
		6H
		6C
		7C
		8D
		4D
		5C
		26
		3S
		QC
		2S
		AC
		JH
		2C
		KD
		10S
		4H
		KS
		5S
		QH
		9S
		2H
		JD
		JC
		9C
		6D
		8H
		AD
		JS
		3C
		10C
		3H
		5D
		AS"
	);

	final almostClutchSaveResult = parseResult(
		"Winner: Player 2
		52"
	);

	final quickGame = parseInput(
		"1
		10D
		1
		KH"
	);

	final quickGameResult = parseResult(
		"Winner: Player 2
		1"
	);

	final veryQuickGame = parseInput(
		"0
		1
		10D"
	);

	final veryQuickGameResult = parseResult(
		"Winner: Player 2
		1"
	);

	final luckyShuffle = parseInput(
		"10
		2S
		AS
		5D
		QS
		8C
		4D
		7H
		8H
		JS
		3H
		10
		2C
		AC
		5H
		QC
		8D
		4H
		7S
		8S
		JC
		3S"
	);

	final luckyShuffleResult = parseResult(
		"Winner: Player 2
		4"
	);

	final unfairShuffle1 = parseInput(
		"5
		8C
		9C
		3S
		2D
		AH
		17
		5C
		5S
		6D
		2C
		10H
		4C
		AD
		5H
		10D
		10C
		2S
		10S
		8S
		5D
		7C
		9S
		JC"
	);

	final unfairShuffle1Result = parseResult(
		"Winner: Player 2
		2"
	);

	final unfairShuffle2 = parseInput(
		"19
		2C
		8C
		JD
		QC
		6C
		JS
		10S
		2S
		7C
		AD
		4D
		3C
		4S
		JH
		5C
		2D
		4C
		3S
		8D
		4
		9C
		8S
		7S
		QS"
	);

	final unfairShuffle2Result = parseResult(
		"Winner: Player 2
		23"
	);

	final unfairShuffle3 = parseInput(
		"51
		10D
		6H
		10C
		AD
		7D
		9S
		3H
		2D
		3S
		8S
		8D
		JS
		KH
		4S
		QD
		QH
		AH
		6C
		JC
		5S
		KD
		6D
		8H
		4C
		5C
		4H
		2H
		JD
		10H
		9H
		9C
		2C
		KC
		2S
		JH
		6S
		7S
		5D
		AC
		9D
		AS
		7C
		8C
		QS
		QC
		5H
		3C
		10S
		4D
		7H
		KS
		1
		3D"
	);

	final unfairShuffle3Result = parseResult(
		"Winner: Player 1
		50"
	);

	final standardDeck1 = parseInput(
		"26
		7H
		KS
		5C
		5D
		8C
		2D
		8D
		6S
		KC
		7C
		6C
		4C
		6H
		8S
		KD
		JH
		10H
		QS
		3S
		8H
		AS
		AD
		3D
		2S
		4D
		10S
		26
		3H
		9D
		QC
		2C
		7S
		10D
		AH
		JD
		4H
		7D
		10C
		2H
		9C
		QH
		4S
		9H
		5H
		QD
		5S
		JC
		9S
		KH
		3C
		JS
		AC
		6D"
	);

	final standardDeck1Result = parseResult(
		"Winner: Player 1
		24"
	);

	final standardDeck2 = parseInput(
		"26
		10D
		QH
		JD
		6C
		QD
		4S
		KC
		10S
		JC
		QC
		8C
		5H
		4H
		4D
		6H
		10H
		9H
		AD
		5D
		10C
		9S
		AH
		2H
		KH
		9D
		5S
		26
		7S
		5C
		2C
		KD
		2S
		6D
		6S
		3S
		AS
		3C
		8D
		3H
		7D
		2D
		JH
		4C
		JS
		7C
		AC
		7H
		3D
		QS
		8H
		9C
		KS
		8S"
	);

	final standardDeck2Result = parseResult(
		"Winner: Player 1
		38"
	);

	final standardDeck3 = parseInput(
		"26
		6H
		5S
		7H
		10C
		9D
		KH
		4C
		AC
		JH
		2S
		KC
		2C
		AS
		9H
		6S
		6C
		7S
		8H
		9S
		AD
		8D
		8S
		7C
		5H
		4H
		3H
		26
		5D
		QS
		QC
		7D
		3D
		3C
		AH
		4D
		2H
		9C
		10H
		5C
		10D
		KD
		10S
		JS
		KS
		QH
		8C
		JC
		QD
		6D
		JD
		3S
		4S
		2D"
	);

	final standardDeck3Result = parseResult(
		"Winner: Player 2
		32"
	);

	final standardDeck4 = parseInput(
		"26
		6H
		AS
		8C
		KH
		2H
		7H
		10H
		4S
		JS
		JC
		7D
		AH
		QD
		JH
		6D
		10S
		8D
		KD
		8H
		4D
		QC
		6C
		2D
		10D
		10C
		3D
		26
		5H
		2S
		9H
		3H
		5D
		2C
		5C
		KC
		4H
		7S
		AD
		9S
		QH
		9D
		4C
		3S
		8S
		JD
		5S
		AC
		9C
		7C
		KS
		3C
		QS
		6S"
	);

	final standardDeck4Result = parseResult(
		"Winner: Player 1
		2"
	);

	final standardDeck5 = parseInput(
		"26
		8S
		6H
		3C
		9S
		5S
		KD
		AH
		QS
		JC
		QC
		9C
		6C
		AC
		KS
		4D
		2H
		5H
		8C
		3H
		7C
		10H
		10D
		4S
		7H
		2C
		JD
		26
		8H
		6D
		3D
		9D
		5D
		KC
		AD
		QD
		JS
		QH
		9H
		6S
		AS
		KH
		4C
		2S
		5C
		8D
		3S
		7S
		10S
		10C
		4H
		7D
		2D
		JH"
	);

	final standardDeck5Result = parseResult(
		"Winner: Player 1
		15"
	);

	final standardDeck6 = parseInput(
		"26
		AS
		AC
		2C
		2S
		3S
		3C
		4C
		4S
		5S
		5C
		6D
		6H
		7H
		7D
		8D
		8S
		9C
		9S
		10S
		10C
		JC
		JH
		QD
		QH
		KD
		KS
		26
		AD
		AH
		2H
		2D
		3D
		3H
		4D
		4H
		5D
		5H
		6S
		6C
		7S
		7C
		8H
		8C
		9D
		9H
		10H
		10D
		JS
		JD
		QS
		QC
		KH
		KC"
	);

	final standardDeck6Result = parseResult(
		"Winner: Player 1
		24"
	);
}