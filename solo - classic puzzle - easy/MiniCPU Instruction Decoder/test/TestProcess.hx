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
		it( "Boot Sequence", Main.process( bootSequence ).should.be( bootSequenceResult ));
		it( "Arithmetic Variant", Main.process( arithmeticVariant ).should.be( arithmeticVariantResult ));
		it( "Multiply Core", Main.process( multiplyCore ).should.be( multiplyCoreResult ));
		it( "INC and DEC", Main.process( incAndDec ).should.be( incAndDecResult ));
		it( "INC Overflow", Main.process( incOverflow ).should.be( incOverflowResult ));
		it( "DEC Underflow", Main.process( decUnderflow ).should.be( decUnderflowResult ));
		it( "ADD Overflow", Main.process( addOverflow ).should.be( addOverflowResult ));
		it( "SUB Underflow", Main.process( subUnderflow ).should.be( subUnderflowResult ));
		it( "MUL Overflow", Main.process( mulOverflow ).should.be( mulOverflowResult ));
		it( "Mixed Operations", Main.process( mixedOperations ).should.be( mixedOperationsResult ));
		it( "Immediate Halt", Main.process( immediateHalt ).should.be( immediateHaltResult ));
		it( "MOV Overwrite", Main.process( movOverwrite ).should.be( movOverwriteResult ));
	});
	}

	// static function parseInput( input:String ) {
	// 	initReadline( input );
	// 	return "";
	// }

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	
	final bootSequence = "01 00 0A 01 01 05 02 00 01 03 00 01 FF";

	final bootSequenceResult = parseResult(
		"10
		5
		0
		0"
	);

	final arithmeticVariant = "01 00 14 01 01 0A 02 00 01 03 00 01 FF";
	final arithmeticVariantResult = parseResult(
		"20
		10
		0
		0"
	);

	final multiplyCore = "01 00 03 01 01 04 04 00 01 FF";
	final multiplyCoreResult = parseResult(
		"12
		4
		0
		0"
	);

	final incAndDec = "01 02 05 05 02 05 02 06 02 FF";
	final incAndDecResult = parseResult(
		"0
		0
		6
		0"
	);

	final incOverflow = "01 00 FF 05 00 FF";
	final incOverflowResult = parseResult(
		"0
		0
		0
		0"
	);

	final decUnderflow = "01 03 00 06 03 FF";
	final decUnderflowResult = parseResult(
		"0
		0
		0
		255"
	);

	final addOverflow = "01 00 F0 01 01 20 02 00 01 FF";
	final addOverflowResult = parseResult(
		"16
		32
		0
		0"
	);

	final subUnderflow = "01 00 05 01 01 0A 03 00 01 FF";
	final subUnderflowResult = parseResult(
		"251
		10
		0
		0"
	);

	final mulOverflow = "01 02 10 01 03 10 04 02 03 FF";
	final mulOverflowResult = parseResult(
		"0
		0
		0
		16"
	);

	final mixedOperations = "01 00 0A 01 01 05 01 02 FE 01 03 03 04 03 00 02 02 01 03 02 00 FF";
	final mixedOperationsResult = parseResult(
		"10
		5
		249
		30"
	);

	final immediateHalt = "FF";
	final immediateHaltResult = parseResult(
		"0
		0
		0
		0"
	);

	final movOverwrite = "01 00 05 05 00 01 00 07 FF";
	final movOverwriteResult = parseResult(
		"7
		0
		0
		0"
	);
}