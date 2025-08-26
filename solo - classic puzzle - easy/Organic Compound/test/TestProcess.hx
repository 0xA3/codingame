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
			it( "ethane", Main.process( "C2H6" ).should.be( "ethane" ));
			it( "butene", Main.process( "C4H8" ).should.be( "butene" ));
			it( "hexanol", Main.process( "CH3CH2CH2CH2CH2CH2OH" ).should.be( "hexanol" ));
			it( "methanoic acid", Main.process( "HCOOH" ).should.be( "methanoic acid" ));
			it( "decanone", Main.process( "CH3COC8H17" ).should.be( "decanone" ));
			it( "octanal", Main.process( "CH3CH2CH2CH2CH2CH2CH2CHO" ).should.be( "octanal" ));
			it( "nonane", Main.process( "C9H20" ).should.be( "nonane" ));
			it( "pentanol", Main.process( "CH3CH2CH2CH2CH2OH" ).should.be( "pentanol" ));
			it( "octene", Main.process( "CH2CHCH2CH2CH2CH2CH2CH3" ).should.be( "octene" ));
			it( "propanoic acid", Main.process( "CH3CH2COOH" ).should.be( "propanoic acid" ));
			it( "methanal", Main.process( "HCHO" ).should.be( "methanal" ));
			it( "propanone", Main.process( "CH3COCH3" ).should.be( "propanone" ));
			it( "OTHERS (I) - ethyl ethanoate", Main.process( "CH3COOCH2CH3" ).should.be( "OTHERS" ));
			it( "OTHERS (II) - ethane-1,2-diol", Main.process( "HOCH2CH2OH" ).should.be( "OTHERS" ));
			it( "OTHERS (III) - Oxalic acid", Main.process( "HOOCCOOH" ).should.be( "OTHERS" ));
			it( "OTHERS (IV) - Formamide", Main.process( "HCONH2" ).should.be( "OTHERS" ));
			it( "OTHERS (V) - Phenol", Main.process( "C6H5OH" ).should.be( "OTHERS" ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		// return
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
}