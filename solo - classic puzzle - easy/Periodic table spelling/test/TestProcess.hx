package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "H", Main.process( "H" ).should.be( "H" ));
			it( "No", Main.process( "No" ).should.be( noResult ));
			it( "Carbon", Main.process( "Carbon" ).should.be( carbonResult ));
			it( "Krypton", Main.process( "Krypton" ).should.be( kryptonResult ));
			it( "Javascript", Main.process( "Javascript" ).should.be( javascriptResult ));
			it( "Snowy", Main.process( "Snowy" ).should.be( snowyResult ));
			it( "Hyperpathogenesis", Main.process( "Hyperpathogenesis" ).should.be( hyperpathogenesisResult ));
			it( "Obvious", Main.process( "Obvious" ).should.be( obviousResult ));
			it( "Canada", Main.process( "Canada" ).should.be( canadaResult ));
			it( "Casinos", Main.process( "Casinos" ).should.be( casinosResult ));
			it( "Hinausgeschossen", Main.process( "Hinausgeschossen" ).should.be( hinausgeschossenResult ));
			it( "Innocuousnesses", Main.process( "Innocuousnesses" ).should.be( innocuousnessesResult ));
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final noResult = parseResult(
		"NO
		No" );
	
	final carbonResult = parseResult(
		"CArBON
		CaRbON" );
	
	final kryptonResult = parseResult(
		"KrYPtON" );
	
	final javascriptResult = parseResult(
		"none" );
	
	final snowyResult = parseResult(
		"SNOWY
		SNoWY
		SnOWY" );
	
	final hyperpathogenesisResult = parseResult(
		"HYPErPAtHOGeNEsIS
		HYPErPAtHOGeNeSIS
		HYPErPAtHOGeNeSiS
		HYPErPAtHoGeNEsIS
		HYPErPAtHoGeNeSIS
		HYPErPAtHoGeNeSiS
		HYPErPaThOGeNEsIS
		HYPErPaThOGeNeSIS
		HYPErPaThOGeNeSiS" );
	
	final obviousResult = parseResult(
		"OBVIOUS" );
	
	final canadaResult = parseResult(
		"none" );
	
	final casinosResult = parseResult(
		"CAsINOS
		CAsINOs
		CAsINoS
		CAsInOS
		CAsInOs
		CaSINOS
		CaSINOs
		CaSINoS
		CaSInOS
		CaSInOs
		CaSiNOS
		CaSiNOs
		CaSiNoS" );
	
	final hinausgeschossenResult = parseResult(
		"HINAuSGeSCHOSSeN
		HINAuSGeSCHOsSeN
		HINAuSGeSCHoSSeN
		HINAuSGeScHOSSeN
		HINAuSGeScHOsSeN
		HINAuSGeScHoSSeN
		HINAuSgEsCHOSSeN
		HINAuSgEsCHOsSeN
		HINAuSgEsCHoSSeN
		HINaUSGeSCHOSSeN
		HINaUSGeSCHOsSeN
		HINaUSGeSCHoSSeN
		HINaUSGeScHOSSeN
		HINaUSGeScHOsSeN
		HINaUSGeScHoSSeN
		HINaUSgEsCHOSSeN
		HINaUSgEsCHOsSeN
		HINaUSgEsCHoSSeN
		HInAuSGeSCHOSSeN
		HInAuSGeSCHOsSeN
		HInAuSGeSCHoSSeN
		HInAuSGeScHOSSeN
		HInAuSGeScHOsSeN
		HInAuSGeScHoSSeN
		HInAuSgEsCHOSSeN
		HInAuSgEsCHOsSeN
		HInAuSgEsCHoSSeN" );
	
	final innocuousnessesResult = parseResult(
		"INNOCUOUSNEsSEs
		INNOCUOUSNEsSeS
		INNOCUOUSNeSSEs
		INNOCUOUSNeSSeS
		INNOCUOUSnEsSEs
		INNOCUOUSnEsSeS
		INNOCuOUSNEsSEs
		INNOCuOUSNEsSeS
		INNOCuOUSNeSSEs
		INNOCuOUSNeSSeS
		INNOCuOUSnEsSEs
		INNOCuOUSnEsSeS
		INNoCUOUSNEsSEs
		INNoCUOUSNEsSeS
		INNoCUOUSNeSSEs
		INNoCUOUSNeSSeS
		INNoCUOUSnEsSEs
		INNoCUOUSnEsSeS
		INNoCuOUSNEsSEs
		INNoCuOUSNEsSeS
		INNoCuOUSNeSSEs
		INNoCuOUSNeSSeS
		INNoCuOUSnEsSEs
		INNoCuOUSnEsSeS
		InNOCUOUSNEsSEs
		InNOCUOUSNEsSeS
		InNOCUOUSNeSSEs
		InNOCUOUSNeSSeS
		InNOCUOUSnEsSEs
		InNOCUOUSnEsSeS
		InNOCuOUSNEsSEs
		InNOCuOUSNEsSeS
		InNOCuOUSNeSSEs
		InNOCuOUSNeSSeS
		InNOCuOUSnEsSEs
		InNOCuOUSnEsSeS
		InNoCUOUSNEsSEs
		InNoCUOUSNEsSeS
		InNoCUOUSNeSSEs
		InNoCUOUSNeSSeS
		InNoCUOUSnEsSEs
		InNoCUOUSnEsSeS
		InNoCuOUSNEsSEs
		InNoCuOUSNEsSeS
		InNoCuOUSNeSSEs
		InNoCuOUSNeSSeS
		InNoCuOUSnEsSEs
		InNoCuOUSnEsSeS" );
}
