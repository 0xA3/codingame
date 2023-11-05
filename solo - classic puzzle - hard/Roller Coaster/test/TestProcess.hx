package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Simple case", {
				final ip = simpleCase;
				Main.process( ip.l, ip.c, ip.queue ).should.be( 7i64 );
			});
			it( "1000 queue of a few people", {
				final ip = _1000queueOfAFewPeople;
				Main.process( ip.l, ip.c, ip.queue ).should.be( 3935i64 );
			});
			it( "The same queue go on the ride several times during the day", {
				final ip = theSamequeueGoOnTheRideSeveralTimesDuringTheDay;
				Main.process( ip.l, ip.c, ip.queue ).should.be( 15i64 );
			});
			it( "All the people get on the roller coaster at least once", {
				final ip = allThePeopleGetOnTheRollerCoasterAtLeastOnce;
				Main.process( ip.l, ip.c, ip.queue ).should.be( 15000i64 );
			});
			it( "High earnings during the day (> 2^32)", {
				final ip = highEarningsDuringTheDay;
				Main.process( ip.l, ip.c, ip.queue ).should.be( 4999975000i64 );
			});
			it( "Works with a large dataset", {
				final ip = worksWithALargeDataset;
				Main.process( ip.l, ip.c, ip.queue ).should.be( 89744892565569i64 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final inputs = lines[0].split(' ');
		final l = parseInt( inputs[0] );
		final c = parseInt( inputs[1] );
		final n = parseInt( inputs[2] );
		final queue = lines.slice( 1 ).map( s -> parseInt( s ));
	
		return { l: l, c: c, queue: queue }
	}

	final simpleCase = parseInput(
		"3 3 4
		3
		1
		1
		2" );
	
	final _1000queueOfAFewPeople = parseInput(
		"10 500 1000
		4
		6
		5
		3
		3
		8
		4
		5
		8
		5
		5
		6
		4
		4
		5
		4
		6
		4
		10
		6
		1
		1
		10
		1
		1
		5
		10
		7
		3
		9
		4
		8
		7
		10
		10
		9
		7
		6
		5
		6
		2
		9
		1
		5
		5
		7
		1
		10
		10
		2
		7
		3
		4
		7
		3
		4
		3
		5
		2
		6
		5
		5
		3
		3
		5
		5
		4
		3
		10
		8
		9
		3
		7
		1
		10
		1
		10
		2
		2
		9
		3
		8
		3
		8
		6
		6
		2
		9
		2
		5
		6
		6
		10
		8
		9
		6
		4
		2
		8
		5
		9
		8
		8
		7
		1
		9
		9
		10
		10
		10
		10
		4
		10
		3
		1
		7
		10
		4
		7
		1
		9
		2
		6
		8
		2
		6
		5
		7
		7
		2
		2
		8
		2
		1
		6
		2
		9
		5
		3
		10
		4
		2
		3
		3
		6
		3
		2
		5
		7
		8
		5
		7
		2
		1
		4
		3
		8
		10
		9
		5
		3
		2
		4
		4
		2
		9
		7
		2
		3
		9
		1
		9
		1
		3
		3
		6
		8
		4
		3
		4
		2
		7
		2
		3
		9
		7
		7
		7
		6
		7
		3
		8
		9
		6
		4
		2
		6
		10
		4
		1
		9
		4
		9
		1
		7
		1
		8
		4
		5
		10
		9
		8
		9
		10
		10
		7
		8
		8
		3
		3
		4
		5
		10
		2
		2
		3
		4
		10
		3
		7
		10
		3
		2
		8
		5
		10
		10
		2
		5
		4
		4
		5
		1
		2
		6
		2
		8
		3
		9
		3
		5
		3
		9
		5
		6
		3
		9
		1
		2
		3
		9
		3
		5
		1
		10
		1
		10
		9
		5
		5
		5
		8
		9
		7
		1
		5
		9
		8
		7
		9
		2
		4
		1
		1
		8
		9
		5
		8
		9
		6
		1
		8
		10
		7
		8
		9
		8
		9
		9
		2
		5
		5
		1
		4
		2
		1
		10
		10
		10
		8
		8
		2
		1
		1
		4
		10
		9
		10
		8
		9
		7
		10
		6
		6
		8
		5
		4
		5
		6
		4
		8
		10
		9
		10
		3
		10
		10
		4
		1
		10
		2
		8
		3
		4
		10
		8
		4
		10
		9
		3
		9
		5
		2
		6
		10
		1
		3
		5
		8
		8
		8
		5
		7
		8
		5
		2
		9
		6
		5
		9
		7
		8
		9
		1
		2
		10
		10
		7
		10
		8
		9
		10
		2
		2
		5
		1
		2
		7
		5
		9
		4
		5
		6
		3
		4
		2
		4
		5
		7
		8
		3
		4
		8
		3
		6
		9
		3
		6
		7
		4
		3
		5
		3
		5
		8
		7
		5
		9
		6
		2
		10
		1
		8
		5
		3
		3
		8
		6
		7
		4
		6
		2
		9
		3
		4
		5
		3
		8
		10
		9
		3
		2
		5
		5
		8
		2
		4
		5
		2
		9
		6
		1
		9
		5
		7
		2
		7
		4
		9
		6
		8
		4
		7
		8
		6
		2
		4
		10
		10
		3
		8
		2
		7
		2
		9
		4
		5
		2
		8
		7
		2
		5
		7
		2
		1
		4
		3
		10
		9
		2
		5
		8
		7
		1
		6
		5
		4
		9
		4
		3
		4
		4
		7
		2
		7
		7
		7
		2
		8
		7
		10
		1
		3
		6
		2
		4
		1
		7
		5
		10
		10
		9
		9
		6
		1
		6
		10
		6
		7
		6
		9
		10
		9
		7
		3
		7
		3
		9
		10
		2
		7
		9
		4
		10
		5
		5
		5
		7
		1
		9
		8
		10
		9
		7
		8
		1
		4
		7
		6
		10
		4
		6
		1
		4
		4
		3
		1
		8
		4
		10
		9
		2
		1
		4
		1
		7
		9
		7
		3
		1
		7
		3
		3
		7
		1
		10
		9
		4
		8
		5
		4
		2
		2
		4
		5
		8
		9
		7
		5
		4
		9
		6
		5
		9
		9
		8
		5
		9
		6
		9
		10
		3
		3
		2
		9
		3
		3
		8
		7
		10
		4
		2
		3
		7
		7
		10
		4
		7
		6
		9
		2
		4
		4
		7
		4
		4
		6
		10
		3
		1
		9
		2
		5
		1
		5
		6
		6
		7
		3
		4
		8
		8
		5
		1
		6
		3
		2
		10
		2
		7
		10
		3
		3
		5
		9
		8
		8
		6
		8
		10
		9
		8
		3
		3
		10
		7
		8
		5
		5
		2
		8
		5
		1
		4
		7
		7
		9
		8
		6
		10
		6
		5
		2
		8
		1
		3
		8
		8
		10
		5
		10
		8
		4
		2
		3
		3
		1
		10
		10
		7
		4
		9
		1
		6
		5
		7
		2
		3
		4
		9
		4
		10
		5
		7
		9
		5
		1
		6
		3
		1
		2
		4
		8
		5
		5
		2
		8
		5
		4
		9
		2
		7
		7
		4
		4
		1
		1
		6
		5
		6
		6
		8
		5
		3
		7
		6
		7
		7
		3
		1
		7
		5
		4
		7
		9
		1
		8
		8
		7
		1
		6
		10
		9
		5
		4
		3
		5
		4
		10
		2
		1
		7
		1
		8
		9
		7
		3
		6
		4
		5
		8
		10
		9
		4
		8
		10
		4
		8
		9
		10
		8
		5
		10
		9
		1
		5
		3
		7
		8
		4
		8
		10
		10
		9
		7
		9
		7
		9
		6
		10
		6
		3
		2
		4
		6
		1
		5
		1
		8
		4
		1
		8
		10
		2
		6
		10
		6
		10
		6
		5
		3
		6
		4
		2
		6
		1
		10
		2
		1
		7
		2
		6
		10
		5
		2
		7
		5
		6
		8
		3
		9
		10
		10
		8
		3
		7
		9
		8
		6
		5
		4
		10
		2
		9
		1
		7
		9
		3
		8
		2
		1
		1
		7
		10
		5
		8
		9
		2
		4
		8
		6
		4
		9
		7
		4
		1
		5
		2
		10
		10
		8
		3
		1
		9
		3
		3
		7
		2
		7
		5
		3
		8
		5
		1
		9
		2
		9
		7
		5
		4
		4
		10
		9
		4
		6
		2
		4
		2
		6
		5
		1
		5
		9
		3
		6
		2
		5
		2
		5
		2
		8
		9
		9
		3
		9
		7
		6
		9
		6
		10
		4
		1
		1
		3
		5
		8
		6
		10
		9
		3
		5
		1
		8
		3
		3
		5
		4
		7
		6
		8
		10
		4
		6
		8
		8
		7
		7
		5
		5
		2
		4
		9
		4
		6
		3
		8
		3
		8
		8
		3
		1
		2
		3
		8
		6
		5
		4
		10
		3
		9" );
	
	final theSamequeueGoOnTheRideSeveralTimesDuringTheDay = parseInput(
		"5 3 4
		2
		3
		5
		3" );
	
	final allThePeopleGetOnTheRollerCoasterAtLeastOnce = parseInput(
		"10000 10 5
		100
		200
		300
		400
		500" );
	
	final highEarningsDuringTheDay = parseInput(
		"100000 50000 1000
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999
		100000
		99999" );
	
	final worksWithALargeDataset = parseInput(
		"10000000 9000000 1000
		71670
		35200
		45270
		70848
		68453
		57037
		60376
		33511
		46440
		36711
		52115
		43963
		34977
		47562
		45835
		41293
		51082
		74724
		53144
		51404
		46522
		36355
		44641
		55498
		46694
		56383
		35572
		43708
		47301
		48556
		34981
		38971
		53757
		50252
		79820
		42210
		43641
		76548
		62073
		76434
		49612
		34189
		40397
		54589
		68103
		72585
		32234
		39185
		67309
		55379
		60590
		33831
		61734
		41583
		75681
		44780
		67966
		47606
		74840
		35267
		66162
		46174
		44239
		56271
		32778
		60411
		34833
		46419
		56959
		66907
		42853
		76571
		71096
		69603
		67512
		75551
		62188
		69747
		34736
		65849
		45126
		31678
		36033
		43212
		43262
		31714
		74344
		31228
		49320
		35536
		36496
		51835
		51710
		67087
		44458
		54488
		47498
		49292
		37260
		74457
		52551
		66465
		37381
		59999
		56068
		74893
		55550
		54608
		64640
		60286
		40458
		46118
		61965
		46491
		75682
		41579
		48205
		36378
		42807
		33878
		41915
		65655
		72065
		79977
		52742
		52875
		70818
		70240
		72167
		44430
		31050
		61070
		30895
		38431
		41069
		73316
		49676
		66619
		47924
		50669
		46906
		58382
		33139
		45223
		41225
		78822
		56802
		75783
		51552
		69609
		46013
		79819
		55265
		38078
		46149
		44359
		60953
		36967
		34600
		69473
		51397
		52002
		50543
		68644
		76785
		77965
		61960
		46461
		64584
		46237
		33482
		47842
		40971
		36622
		63065
		52197
		51796
		39867
		47980
		73348
		45829
		63993
		39520
		37446
		38423
		55669
		51805
		35728
		62636
		72757
		41553
		50385
		61111
		78449
		39029
		57896
		76414
		37342
		40710
		60998
		53579
		44192
		78841
		64550
		67166
		78258
		36747
		38962
		54478
		71079
		48663
		36659
		55072
		58183
		44105
		79847
		50204
		32262
		35576
		49192
		41372
		63481
		69577
		38835
		61930
		44958
		66732
		74696
		52300
		43794
		55695
		75879
		74338
		70888
		60430
		61505
		35498
		33529
		36819
		59976
		74609
		55482
		66635
		49681
		50017
		47092
		65881
		36573
		65707
		37809
		55765
		77079
		71290
		45342
		35914
		69573
		76653
		38998
		64269
		48953
		69144
		56316
		44833
		63483
		63556
		41615
		44988
		69055
		45144
		51807
		49031
		39753
		43642
		35667
		75787
		30011
		69111
		61668
		36585
		54818
		69477
		62350
		68249
		77119
		44045
		40516
		66692
		40698
		49514
		50962
		59651
		55011
		43630
		40836
		38494
		77187
		52451
		69834
		66242
		33948
		57993
		51625
		43701
		71635
		73644
		39488
		37999
		62756
		37508
		44584
		53926
		76985
		43286
		42176
		74105
		73683
		52692
		60797
		34381
		38558
		48111
		30385
		63569
		78094
		57573
		38415
		41633
		46377
		78249
		44227
		50325
		56243
		65852
		30378
		64230
		75849
		39867
		38581
		74957
		63727
		53165
		48883
		60713
		32804
		61059
		71170
		76487
		50103
		68319
		47221
		75014
		52783
		63958
		58583
		50877
		41531
		66999
		62510
		57908
		31600
		76737
		78233
		57843
		78941
		78612
		58426
		74790
		54831
		67007
		69747
		38558
		56525
		38631
		35623
		75681
		36042
		76793
		72168
		72498
		65113
		55741
		67512
		37896
		39699
		46095
		75125
		51231
		49446
		57635
		45491
		51047
		70724
		43725
		45242
		36017
		58689
		40020
		30808
		49872
		77028
		36907
		58430
		53553
		61890
		30406
		49234
		67933
		77199
		57754
		76783
		78664
		49848
		64295
		36560
		59547
		30390
		48037
		47130
		66189
		42024
		62622
		53588
		32748
		42699
		35182
		38766
		37740
		45203
		55926
		57612
		42231
		62833
		52394
		32136
		61076
		52800
		67722
		65361
		66352
		61828
		62144
		65016
		31676
		46439
		37929
		77576
		63181
		72318
		44706
		49370
		34343
		43680
		39310
		37091
		72731
		44493
		62209
		30471
		59696
		54487
		74435
		71927
		37321
		46830
		40415
		34749
		35982
		78137
		70110
		72334
		59965
		52254
		73703
		77994
		68693
		47984
		75570
		51874
		40302
		56628
		37597
		44645
		36661
		63259
		68089
		79392
		77752
		66650
		46216
		57448
		41138
		40651
		65727
		64811
		57481
		76142
		69560
		79816
		40631
		59670
		38502
		36949
		31924
		48557
		34943
		36969
		66541
		46865
		75195
		43196
		39845
		49144
		57841
		46506
		32404
		62282
		62251
		30156
		48933
		78467
		73957
		76423
		39118
		76036
		61234
		32952
		38531
		50794
		32768
		49162
		46816
		41270
		72463
		48740
		59828
		43758
		72061
		62721
		76975
		67256
		75917
		36821
		36401
		70111
		69679
		38805
		68745
		51930
		55313
		54030
		66749
		65622
		50453
		75868
		61659
		31687
		45172
		36542
		68833
		47940
		72056
		35649
		75562
		64520
		70741
		71742
		44630
		62802
		54464
		41606
		50059
		66733
		48427
		72812
		73196
		54458
		47969
		61942
		76389
		39634
		35972
		79490
		75257
		72778
		75358
		73268
		74465
		40530
		46162
		79651
		74822
		38218
		35300
		70385
		39090
		76042
		78479
		53721
		75196
		69295
		31679
		45255
		56029
		50106
		54419
		65577
		40916
		72388
		63871
		53657
		48375
		36196
		53148
		43632
		78974
		64858
		53252
		39791
		75389
		69414
		39442
		36563
		43984
		44743
		43300
		69427
		57137
		41780
		43148
		52333
		31075
		44827
		67589
		73456
		31285
		58360
		59034
		42201
		67101
		42905
		32211
		35476
		65453
		55359
		65460
		64427
		40217
		55064
		74219
		51958
		44478
		33661
		58522
		74814
		48404
		38174
		64241
		75541
		49954
		43741
		47875
		67382
		74920
		51816
		77190
		76205
		46528
		72576
		54759
		33629
		51834
		56970
		39105
		37287
		48681
		40917
		71715
		58898
		65981
		65934
		30857
		46811
		35947
		75731
		41626
		70704
		50257
		42219
		32597
		70212
		55961
		66824
		73946
		50881
		54992
		71136
		63439
		71521
		63713
		54550
		75150
		35547
		31520
		50608
		59186
		50201
		77877
		50901
		45451
		63859
		53187
		62660
		30670
		75487
		74743
		58648
		66191
		45001
		70868
		68788
		51565
		63181
		55613
		61863
		50414
		30605
		52999
		33853
		38478
		53064
		58403
		49981
		74963
		76275
		36941
		54150
		62828
		34818
		41403
		78280
		68677
		30943
		77292
		35700
		76430
		72036
		30700
		62621
		37037
		37920
		51409
		74954
		71101
		43374
		56817
		41516
		60332
		46168
		61721
		68810
		69233
		56477
		38791
		30548
		52752
		45732
		71050
		35581
		66903
		32454
		50213
		55580
		33397
		47505
		77632
		79827
		55893
		78333
		78800
		79282
		36253
		66561
		74236
		43707
		79936
		51053
		71575
		76620
		67222
		69648
		65430
		72807
		46125
		40574
		73355
		68878
		72658
		30758
		40811
		59561
		33212
		77376
		35142
		52961
		61233
		49126
		69140
		37127
		47459
		34292
		36409
		70065
		70853
		30646
		50124
		37141
		68051
		41699
		33761
		55273
		31347
		69192
		64432
		47473
		46118
		74140
		52703
		38776
		74898
		79866
		68338
		44462
		77242
		39832
		33775
		58475
		58958
		72915
		65602
		42770
		77207
		38364
		32835
		34412
		39010
		52959
		41554
		77061
		31010
		45315
		68687
		48709
		50859
		53119
		32534
		66977
		63611
		55237
		75754
		58509
		55103
		30444
		72971
		68697
		40276
		43098
		47173
		69234
		36013
		49127
		32004
		49572
		57491
		51191
		53985
		32853
		40502
		65539
		46267
		57864
		47206
		34954
		76574
		68066
		74425
		79108
		71395
		58037
		70698
		33501
		52898
		62153
		33945
		62222
		50851
		60573
		75320
		34376
		49808
		47686
		69855
		68164
		33610
		47347
		55708
		57595
		66552
		32562
		59486
		32819
		60427
		43045
		54125
		57001
		47463
		48551
		72461
		38858
		42940
		63159
		58712
		32190
		45313
		79009
		64412
		32516
		59583
		76085
		53244
		45743
		43771
		43099
		50259
		47381
		76798
		75967
		41329
		63351
		78530
		37167
		32522
		58957
		66564
		56648
		52310
		34027
		41551
		44771
		59238
		54491
		44283
		54302
		73033
		75948
		53311
		57446
		78464
		49246
		53531
		68060
		64989
		33654
		31159
		35249
		67387
		44310
		47568
		45068
		44013
		46098
		68588
		46535
		41407
		55152
		73183
		63717
		75532
		34734
		44841
		71122
		75577
		59124
		45424
		68611
		55072
		68735
		46057
		69888
		37982
		35940
		57948
		39323
		55946
		75459
		44572
		59685
		56121
		78493
		74754
		70134" );
}
