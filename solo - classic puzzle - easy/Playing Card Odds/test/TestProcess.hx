package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Example 1", {
				final ip = example1;
				Main.process( ip.removes, ip.soughts ).should.be( "2%" );
			});
			it( "Example 2", {
				final ip = example2;
				Main.process( ip.removes, ip.soughts ).should.be( "32%" );
			});
			it( "Crazy eights", {
				final ip = crazyEights;
				Main.process( ip.removes, ip.soughts ).should.be( "11%" );
			});
			it( "Trump or face card", {
				final ip = trumpOrFaceCard;
				Main.process( ip.removes, ip.soughts ).should.be( "51%" );
			});
			it( "Impossible", {
				final ip = impossible;
				Main.process( ip.removes, ip.soughts ).should.be( "0%" );
			});
			it( "A lock", {
				final ip = aLock;
				Main.process( ip.removes, ip.soughts ).should.be( "100%" );
			});
			it( "Full deck", {
				final ip = fullDeck;
				Main.process( ip.removes, ip.soughts ).should.be( "50%" );
			});
			it( "Mixture", {
				final ip = mixture;
				Main.process( ip.removes, ip.soughts ).should.be( "22%" );
			});
			it( "Decimation", {
				final ip = decimation;
				Main.process( ip.removes, ip.soughts ).should.be( "40%" );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final inputs = readline().split(' ');
		final r = parseInt( inputs[0] );
		final s = parseInt( inputs[1] );
		final removes = [for( i in 0...r ) readline()];
		final soughts = [for( i in 0...s ) readline()];
			
		return { removes: removes, soughts: soughts };
	}
	
	final example1 = parseInput(
		"1 1
		45C
		7H"
	);

	final example2 = parseInput(
		"1 2
		45C
		7
		H"
	);

	final crazyEights = parseInput(
		"1 1
		JQKA
		8"
	);

	final trumpOrFaceCard = parseInput(
		"3 2
		5C
		6D
		7H
		S
		JQKA"
	);

	final impossible = parseInput(
		"2 3
		7
		H
		7H
		7D
		KH"
	);

	final aLock = parseInput(
		"3 2
		CH
		23456789
		TDS
		ADS
		JQK"
	);

	final fullDeck = parseInput(
		"0 1
		CS"
	);

	final mixture = parseInput(
		"7 3
		234C
		567H
		89TCH
		JQKD
		25JS
		369D
		A
		JQKAS
		2469H
		4TCD"
	);

	final decimation = parseInput(
		"4 2
		23456789T
		CD
		ACHS
		23KH
		KCS
		TQH"
	);
}
