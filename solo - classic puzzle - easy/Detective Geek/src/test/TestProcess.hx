package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Test1", {
				final ip = test1;
				Main.process( ip.time, ip.address ).should.be( test1Result );
			});
			it( "Test2", {
				final ip = test2;
				Main.process( ip.time, ip.address ).should.be( test2Result );
			});
			it( "Test3", {
				final ip = test3;
				Main.process( ip.time, ip.address ).should.be( test3Result );
			});
			it( "Test4", {
				final ip = test4;
				Main.process( ip.time, ip.address ).should.be( test4Result );
			});
			it( "Test5", {
				final ip = test5;
				Main.process( ip.time, ip.address ).should.be( test5Result );
			});
			it( "Test6", {
				final ip = test6;
				Main.process( ip.time, ip.address ).should.be( test6Result );
			});
			it( "Test7", {
				final ip = test7;
				Main.process( ip.time, ip.address ).should.be( test7Result );
			});
			it( "Test8", {
				final ip = test8;
				Main.process( ip.time, ip.address ).should.be( test8Result );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return { time: lines[0], address: lines[1] };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final test1 = parseInput(
		"#*######*#*
		mayjul sepsep octapr octsep sepjun octjan"
	);

	final test1Result = parseResult(
		"15:30
		6hotel"
	);

	final test2 = parseInput(
		"#*****#*
		junjul octapr octoct octjan sepjun octnov sepfeb octjul sepmay marsep mayfeb marsep juljul octapr octnov sepjun octfeb sepmar octjul sepjun marsep mayfeb mayoct mayjun maymay aprsep marsep maymay mayfeb mayjan mayjan mayjan"
	);

	final test2Result = parseResult(
		"01:30
		Boulevard 1 Novembre 1954, 41000"
	);

	final test3 = parseInput(
		"#**##**###*
		sepjul octjul sepjun octaug sepsep junsep sepjun sepjun sepmay marsep octjul sepjun octaug octsep sepfeb octoct octjul sepfeb octmar octsep"
	);

	final test3Result = parseResult(
		"12:30
		freshDeed restaurant"
	);

	final test4 = parseInput(
		"##*#**#**
		maysep mayfeb marsep junoct octjan marsep jundec sepsep octapr octjul sepjul sepfeb marsep junoct octjan marsep augjan octapr sepaug sepfeb octjul sepjun novfeb sepfeb marsep juldec octsep aprnov marsep julnov sepfeb octfeb octjan marsep juldec octsep sepfeb octsep sepoct octapr octmar"
	);

	final test4Result = parseResult(
		"04:20
		81 El Ghorfa El Togareya St. Raml Station"
	);

	final test5 = parseInput(
		"######*###
		maymay maymar aprdec mayapr mayfeb aprsep marsep julaug octmay octmay marsep junaug marsep mayfeb mayfeb mayapr aprsep marsep juljul sepjun octdec marsep juljun octapr octsep sepoct marsep juljul sepfeb sepaug sepfeb octjul"
	);

	final test5Result = parseResult(
		"10:15
		42/31, Opp C 113, New Moti Nagar"
	);

	final test6 = parseInput(
		"#***#*#**###
		mayfeb mayaug mayfeb aproct mayfeb mayjan maysep mayaug aprsep marsep augjun sepfeb octjul sepfeb sepoct sepapr sepsep octapr aprsep marsep juldec sepsep sepoct octmar sepnov octoct sepdec octoct aproct sepdec octoct aprsep marsep augjan octapr sepdec novfeb octapr"
	);

	final test6Result = parseResult(
		"22:15
		171-1087, Yaraicho, Shinjuku-ku, Tokyo"
	);

	final test7 = parseInput(
		"##**##*#***
		augmar sepoct sepfeb marsep julmay sepjun octapr octmay sepfeb octjul sepmay sepoct marsep mayaug mayjun"
	);

	final test7Result = parseResult(
		"16:40
		Via Leopardi 75"
	);

	final test8 = parseInput(
		"##*#*###
		mayfeb maymar mayjun aproct mayaug aprsep marsep augapr octapr octmar octmay novfeb sepjun octapr octmar sepaug marsep maymar aprmay sepoct aprjun aproct sepmay octapr octmar sepaug aprsep marsep jundec octoct octfeb sepoct aproct octaug sepoct aprsep marsep jundec novfeb sepjun octapr octmar sepaug octaug sepfeb octmar sepaug sepmar octoct sepdec aproct sepmay octapr"
	);

	final test8Result = parseResult(
		"02:15
		125-7, Wonpyeong 2(i)-dong, Gumi-si, Gyeongsangbuk-do"
	);

}

