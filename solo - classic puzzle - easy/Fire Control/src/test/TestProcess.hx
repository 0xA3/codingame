package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Example", { Main.process( example ).should.be( "8" ); });
			it( "Side-Fire", { Main.process( sideFire ).should.be( "12" ); });
			it( "Who cut those?", { Main.process( whoCutThose ).should.be( "6" ); });
			it( "Should I plant some trees?", { Main.process( shouldIPlantSomeTrees ).should.be( "JUST RUN" ); });
			it( "Random Centre", { Main.process( randomCentre ).should.be( "24" ); });
			it( "Trees???", { Main.process( trees ).should.be( "JUST RUN" ); });
			it( "Just RUN", { Main.process( justRun ).should.be( "JUST RUN" ); });
			it( "who plant THIS???", { Main.process( whoPlantThis ).should.be( "JUST RUN" ); });
			it( "False alarm", { Main.process( falseAlarm ).should.be( "RELAX" ); });
		});
	}

	static function parseInput( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" ).map( line -> line.split( "" ));
	}

	final example = parseInput(
		"*#####
		######
		######
		######
		######
		######"
	);

	final sideFire = parseInput(
		"######
		######
		######
		######
		######
		******"
	);

	final whoCutThose = parseInput(
		"######
		######
		######
		######
		======
		******"
	);

	final shouldIPlantSomeTrees = parseInput(
		"======
		======
		==*===
		======
		======
		======"
	);

	final randomCentre = parseInput(
		"######
		######
		######
		##*###
		######
		######"
	);
	
	final trees = parseInput(
		"******
		oooooo
		oooooo
		oooooo
		oooooo
		oooooo"
	);
	
	final justRun = parseInput(
		"******
		#*****
		******
		******
		******
		*****#"
	);
	
	final whoPlantThis = parseInput(
		"#o##o#
		#o*#o#
		*o##o*
		#o##o#
		#o**o#
		#o##o#"
	);
	
	final falseAlarm = parseInput(
		"======
		=###==
		======
		=###==
		==oo==
		======"
	);
}

