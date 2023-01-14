package test;

import haxe.Int64;
import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "One", { Main.process( one ).should.be( oneResult ); });
			it( "Small Bulk", {	Main.process( smallBulk ).should.be( smallBulkResult );	});
			it( "Easy Victories", {	Main.process( easyVictories ).should.be( easyVictoriesResult );	});
			it( "Easy Defeats", {	Main.process( easyDefeats ).should.be( easyDefeatsResult );	});
			it( "Bigger", {	Main.process( bigger ).should.be( biggerResult );	});
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		return lines.slice( 1 ).map( line -> Int64.parseString( line ));
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final one = parseInput(
		"1
		2"
	);

	final oneResult = parseResult(
		"VICTORY"
	);
	
	final smallBulk = parseInput(
		"10
		1
		2
		3
		4
		5
		6
		7
		8
		9
		10"
	);

	final smallBulkResult = parseResult(
		"VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		DEFEAT
		VICTORY
		VICTORY
		VICTORY"
	);
	
	final easyVictories = parseInput(
		"15
		600
		640
		675
		729
		768
		810
		900
		972
		1024
		1125
		1200
		1250
		1296
		1440
		1500"
	);

	final easyVictoriesResult = parseResult(
		"VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY"
	);

	final easyDefeats = parseInput(
		"15
		630
		650
		732
		760
		806
		872
		966
		1001
		1092
		1160
		1216
		1290
		1400
		1460
		1539"
	);

	final easyDefeatsResult = parseResult(
		"DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT"
	);

	final bigger = parseInput(
		"20
		8916100448256000
		8905786697765618
		8978233254014990
		8883664392439636
		8967378984372715
		8906044184985600
		8815968460800000
		8839938372534426
		8887458428319767
		8847360000000000
		8957952000000000
		8898925781250000
		8968066875000000
		8926168066560000
		8857350000000000
		8981943434664571
		8855835700998201
		8910737505679793
		8825923015031250
		8983733062992534"
	);

	final biggerResult = parseResult(
		"VICTORY
		DEFEAT
		DEFEAT
		DEFEAT
		DEFEAT
		VICTORY
		VICTORY
		DEFEAT
		DEFEAT
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		VICTORY
		DEFEAT
		DEFEAT
		DEFEAT
		VICTORY
		DEFEAT"
	);

}

