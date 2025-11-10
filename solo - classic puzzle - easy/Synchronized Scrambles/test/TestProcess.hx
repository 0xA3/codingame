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
			it( "Just a minute", Main.process( parseInput( "-0930 -0044" )).should.be( justAMinuteResult ));
			it( "Two instants per day", Main.process( parseInput( "+0545 -0100" )).should.be( twoInstantsPerDayResult));
			it( "10-minute window", Main.process( parseInput( "-0600 -0230" )).should.be( _10MinuteWindowResult ));
			it( "Many random points", Main.process( parseInput( "+0451 +0730" )).should.be( manyRandomPointsResult ));
			it( "Almost an hour", Main.process( parseInput( "-0430 +0124" )).should.be( almostAnHourResult ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		final inputs = readline().split(" ");
		final offset1 = inputs[0];
		final offset2 = inputs[1];
		
		return [offset1, offset2];
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final justAMinuteResult = parseResult(
		"1205, 2051"
	);

	final twoInstantsPerDayResult = parseResult(
		"0149, 1904
		0250, 2005"
	);

	final _10MinuteWindowResult = parseResult(
		"2300, 0230
		2301, 0231
		2302, 0232
		2303, 0233
		2304, 0234
		2305, 0235
		2306, 0236
		2307, 0237
		2308, 0238
		2309, 0239"
	);

	final manyRandomPointsResult = parseResult(
		"0023, 0302
		0031, 0310
		0134, 0413
		0142, 0421
		0245, 0524
		0253, 0532
		0356, 0635
		1023, 1302
		1031, 1310
		1134, 1413
		1142, 1421
		1245, 1524
		1253, 1532
		1356, 1635
		2023, 2302
		2031, 2310"
	);

	final almostAnHourResult = parseResult(
		"0006, 0600
		0016, 0610
		0026, 0620
		0036, 0630
		0046, 0640
		0056, 0650
		0107, 0701
		0117, 0711
		0127, 0721
		0137, 0731
		0147, 0741
		0157, 0751
		0208, 0802
		0218, 0812
		0228, 0822
		0238, 0832
		0248, 0842
		0258, 0852
		0309, 0903
		0319, 0913
		0329, 0923
		0339, 0933
		0349, 0943
		0359, 0953
		0410, 1004
		0451, 1045
		0511, 1105
		0612, 1206
		0713, 1307
		0814, 1408
		0915, 1509
		1006, 1600
		1016, 1610
		1026, 1620
		1036, 1630
		1046, 1640
		1056, 1650
		1107, 1701
		1117, 1711
		1127, 1721
		1137, 1731
		1147, 1741
		1157, 1751
		1208, 1802
		1218, 1812
		1228, 1822
		1238, 1832
		1248, 1842
		1258, 1852
		1309, 1903
		1319, 1913
		1329, 1923
		1339, 1933
		1349, 1943
		1359, 1953
		1420, 2014
		1521, 2115
		1622, 2216
		1723, 2317"
	);
}