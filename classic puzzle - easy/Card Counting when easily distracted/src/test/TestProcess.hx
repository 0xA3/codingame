package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.s, ip.t ).should.be( "67%" );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.s, ip.t ).should.be( "25%" );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.s, ip.t ).should.be( "8%" );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.s, ip.t ).should.be( "27%" );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.s, ip.t ).should.be( "17%" );
			});
			it( "Test 6", {
				final ip = test6;
				Main.process( ip.s, ip.t ).should.be( "10%" );
			});
			it( "Test 7", {
				final ip = test7;
				Main.process( ip.s, ip.t ).should.be( "29%" );
			});
			it( "Test 8", {
				final ip = test8;
				Main.process( ip.s, ip.t ).should.be( "22%" );
			});
			it( "Test 9", {
				final ip = test9;
				Main.process( ip.s, ip.t ).should.be( "8%" );
			});
			it( "Test 10", {
				final ip = test10;
				Main.process( ip.s, ip.t ).should.be( "14%" );
			});
			it( "Test 11", {
				final ip = test11;
				Main.process( ip.s, ip.t ).should.be( "6%" );
			});
			it( "Test 12", {
				final ip = test12;
				Main.process( ip.s, ip.t ).should.be( "40%" );
			});
			it( "Test 13 Not a chance", {
				final ip = test13NotAChance;
				Main.process( ip.s, ip.t ).should.be( "0%" );
			});
			it( "Test 14", {
				final ip = test14;
				Main.process( ip.s, ip.t ).should.be( "20%" );
			});
			it( "Test 15", {
				final ip = test15;
				Main.process( ip.s, ip.t ).should.be( "25%" );
			});
			it( "Test 16 For sure", {
				final ip = test16ForSure;
				Main.process( ip.s, ip.t ).should.be( "100%" );
			});
			it( "Test 17", {
				final ip = test17;
				Main.process( ip.s, ip.t ).should.be( "18%" );
			});
			it( "Test 18", {
				final ip = test18;
				Main.process( ip.s, ip.t ).should.be( "25%" );
			});
			it( "Test 19", {
				final ip = test19;
				Main.process( ip.s, ip.t ).should.be( "17%" );
			});
			it( "Test 20 Anything but 10", {
				final ip = test20AnythingBut10;
				Main.process( ip.s, ip.t ).should.be( "61%" );
			});
			it( "Test 21", {
				final ip = test21;
				Main.process( ip.s, ip.t ).should.be( "29%" );
			});
			it( "Test 22", {
				final ip = test22;
				Main.process( ip.s, ip.t ).should.be( "30%" );
			});
			it( "Test 23", {
				final ip = test23;
				Main.process( ip.s, ip.t ).should.be( "4%" );
			});
			it( "Test 24", {
				final ip = test24;
				Main.process( ip.s, ip.t ).should.be( "16%" );
			});
			it( "Test 25", {
				final ip = test25;
				Main.process( ip.s, ip.t ).should.be( "18%" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final streamOfConsciousness = lines[0];
		final bustThreshold = parseInt( lines[1] );
			return { s: streamOfConsciousness, t: bustThreshold }
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
	"222.333.444.some distraction.555.5.678.678.678.678.another distraction.9999.TTTT.JJJJ.QQQQ.KKKK.AAAA
	4" );

	final test2 = parseInput(
	"Did I turn the iron off?.Did I turn the iron off?.AT3A.7JA.J.Oceans11.95A.mob boss.IRS.hungry.Cute dealer.2.45T84Q.Show Girls!!.QQQ.24868.QUEEN.K837695.Is that Penn or Teller?.362436.KJ7KJ
	7" );

	final test3 = parseInput(
	"sound of surveillance camera moving.4.QANON.362436.411.JACK.I hope I don't get caught.Oceans11.Keira Knightley and Natalie Portman are the same person.KQ8.3A3TQ775.I hope I don't get caught.J.947Q892T.4Q.pushy cocktail waitress.trapeze act.Is that Penn or Teller?.10-4.K8K5A6.pushy cocktail waitress.CATS.Gamblers Anonymous.Leg Cramp Leg Cramp Leg Cramp.Is someone picking my pocket?.TATTOO.Gamblers Anonymous.A2.95A
	5" );

	final test4 = parseInput(
	"T992J4.Oceans11.Gamblers Anonymous.sound of surveillance camera moving.pushy cocktail waitress.362436.867-5309.829.T38AAJ7K.Something just touched my leg!.QAJ.10-4.I wonder if those are real.Did I turn the iron off?.Is that Penn or Teller?.867-5309.321!.IRS.89QKA.I'm so smart.I wonder if those are real.6K4QQ55K8.TATTOO.Meagan Markle.A1.sound of surveillance camera moving.6
	5" );

	final test5 = parseInput(
	"I'm so smart.Q5.34AA.strobe lights.wait did I miss a card!?!.Meagan Markle.362436.4.9T.QUEEN.36A.Meagan Markle.K9KTJQKA87
	5" );

	final test6 = parseInput(
	"sound of surveillance camera moving.pushy cocktail waitress.972KQ.TATTOO.QANON.pushy cocktail waitress.pushy cocktail waitress.TAT.937A2247.MINIskirts!.I'm so smart.hungry.mob boss.9T8.68
	3" );

	final test7 = parseInput(
	"I should have become a programmer.I should have become a programmer.MINIskirts!.9QAK.547248K6.Something just touched my leg!.AT&T.867-5309.QANON.Oceans11.A0KAY.3JK27.J.6Q34QQTA2.Leg Cramp Leg Cramp Leg Cramp.A0KAY.$3 drinks.AT&T.AT&T.398A6.Cute dealer.797T.J28.Leg Cramp Leg Cramp Leg Cramp.10-4.Did I turn the iron off?.I'm so smart.KATTJ5
	5" );

	final test8 = parseInput(
	"Leg Cramp Leg Cramp Leg Cramp.sound of surveillance camera moving.36A.A4J7K2Q89.Gamblers Anonymous.TATA.321!.747.I hope I don't get caught.543TJQ6895
	4" );

	final test9 = parseInput(
	"48Q7Q5.TAT.Meagan Markle.J72
	2" );

	final test10 = parseInput(
	"KJ.TOOT.10-4.321!.J5T5T.$3 drinks.TATA.362675
	3" );

	final test11 = parseInput(
	"364AQQ.A0KAY.I should have become a programmer.Did I turn the iron off?.28K4T69.Is that Penn or Teller?.TAT
	2" );

	final test12 = parseInput(
	"RainMan.Meagan Markle.4AT645.QQQ.363.QUEEN.Where is my lookout-partner?.8994857.AKJK273A.TAT.72T9.IRS.wait did I miss a card!?!.Q87
	6" );

	final test13NotAChance = parseInput(
	"Is someone picking my pocket?.blow on it for good luck.4AT645.Cute dealer.Q.Show Girls!!.IRS.J7TK8.thirsty.$3 drinks.KTA6369.32Q.Cute dealer.AT&T.79.T442.RainMan.J83A5QJ26.988325A7.95KK
	6" );

	final test14 = parseInput(
	"Gamblers Anonymous.I'm so smart.292.J6A2.I'm so smart.76834.A1.strobe lights.Leg Cramp Leg Cramp Leg Cramp.4.TT3.TATTOO.Keira Knightley and Natalie Portman are the same person.5.Keira Knightley and Natalie Portman are the same person.I wonder if those are real.TQTK9
	4" );

	final test15 = parseInput(
	"Meagan Markle.IRS.AT&T.10-4.8QK9.4K7.3J6J2K5.6A382A4Q3.Did I turn the iron off?.2-for-1 buffet.T7Q24Q5J5.QUEEN.AT&T.T699
	4" );

	final test16ForSure = parseInput(
	"CATS.79AJT8443A.MINIskirts!.MINIskirts!.2T477JQJ.QANON.68382QK2.hungry.TOOT.I'm so smart.4KQ926TA.95A.2-for-1 buffet.10-4.K6JT57QK58.321!.5963
	6" );

	final test17 = parseInput(
	"Cute dealer.CATS.wait did I miss a card!?!.MINIskirts!.7.455AT8K3J2.5649TQ.679264.I should have become a programmer.IRS.A3J5247.36A.K7KTQ.29J
	5" );

	final test18 = parseInput(
	"36A.34AA.321!.J56.8TTJ2.89KQKQT.Q77967
	4" );

	final test19 = parseInput(
	"KT6K5J2.Gamblers Anonymous.trapeze act.321!.7AQQ4.pushy cocktail waitress.34AA.26QAT9J2.RainMan.747.strobe lights.mob boss.K9669.3T48375.hungry.Q
	5" );

	final test20AnythingBut10 = parseInput(
	"9J4T7A55Q.Something just touched my leg!.9T75.RainMan.Cute dealer.Is that Penn or Teller?.TATA.A.I'm so smart.366K9.362436
	10" );

	final test21 = parseInput(
	"TATTOO.Q736.J.Oceans11.hungry.strobe lights.J.trapeze act.A0KAY.282T556A.QQQ.4A8KK4592J.K9T7249J33.strobe lights.867-5309.936AA.T7.T
	6" );

	final test22 = parseInput(
	"JACK.5J.A0KAY.MINIskirts!.299.I hope I don't get caught.QQQ.95A.A7.A0KAY.Something just touched my leg!.3.hungry.Cute dealer.321!.strobe lights.strobe lights.trapeze act.KKAJ.4AT645.Did I turn the iron off?.MINIskirts!.2288.K
	6" );

	final test23 = parseInput(
	"A2.TAT
	2" );

	final test24 = parseInput(
	"2-for-1 buffet.JACK.Q4TQ79287.9KJ5.867-5309.QANON.Is he starring at me?!?.QUEEN.I should have become a programmer.strobe lights.A1.pushy cocktail waitress.MINIskirts!.I hope I don't get caught.TAT.I wonder if those are real.$3 drinks.T293
	3" );

	final test25 = parseInput(
	"JACK.8.T00T.hungry.321!.3QAA63624J.Meagan Markle.AT&T.2-for-1 buffet.K76.AT&T.Did I turn the iron off?.TOOT.thirsty.Show Girls!!.QANON.K73K.J98959.blow on it for good luck.sound of surveillance camera moving.435.Gamblers Anonymous.AT&T.Meagan Markle.7TA.228JT.4AT645
	6" );
}
