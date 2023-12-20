package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", Main.process( test1 ).should.be( test1Result ));
			it( "Test 2", Main.process( test2 ).should.be( test2Result ));
			it( "Test 3", Main.process( test3 ).should.be( test3Result ));
			it( "Test 4", Main.process( test4 ).should.be( test4Result ));
			it( "Test 5", Main.process( test5 ).should.be( test5Result ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return lines.slice( 2 );
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"2
		5
		A(1,2)
		C(0,8)
		D(0,9)
		E(6,2)
		F(6,4)"
	);

	final test1Result = parseResult(
		"CD(0,1)
		DE(6,-7)"
	);

	final test2 = parseInput(
		"3
		6
		A(3,19,-2)
		B(-6,-2,-13)
		C(10,-4,12)
		D(-3,-17,11)
		E(2,7,9)
		F(10,5,-15)"
	);

	final test2Result = parseResult(
		"CE(-8,11,-3)
		AD(-6,-36,13)"
	);

	final test3 = parseInput(
		"2
		5
		$(-6,-9)
		Hello(-8,-2)
		!(-2,-20)
		World(-10,-3)
		&(-12,-6)"
	);

	final test3Result = parseResult(
		"HelloWorld(-2,-1)
		Hello!(6,-18)"
	);

	final test4 = parseInput(
		"4
		13
		01(2,-10,-9,-20)
		02(5,-12,-18,-3)
		03(13,-14,-3,-12)
		04(16,-11,-3,-13)
		05(20,-15,-17,-1)
		06(14,-2,3,10)
		07(18,-18,-9,8)
		08(3,-19,-5,7)
		09(5,-13,-2,2)
		10(17,-4,-17,12)
		11(14,-20,-4,-12)
		12(2,-20,-5,-1)
		13(11,-12,11,14)"
	);

	final test4Result = parseResult(
		"0304(3,3,0,-1)
		0113(9,-2,20,34)"
	);

	final test5 = parseInput(
		"10
		100
		01(-14,6,-5,-2,15,-9,-9,-15,11,8)
		02(-15,9,2,15,-19,-19,-19,-8,-1,17)
		03(-13,-9,-8,1,7,3,9,-17,11,6)
		04(15,5,-2,16,-19,1,-6,-16,9,-6)
		05(-9,17,-7,-13,-9,11,-15,0,8,15)
		06(19,13,-13,0,-1,-3,1,-18,19,-3)
		07(8,-20,-11,-7,5,-3,-2,9,5,-13)
		08(-4,-11,5,15,-12,-6,-1,-8,19,16)
		09(-3,-16,-6,18,12,-2,9,12,4,20)
		10(-8,4,13,16,0,-13,2,-20,10,-12)
		11(9,20,1,-1,18,2,17,-18,19,6)
		12(-1,-11,-15,13,-13,17,-1,20,-6,-11)
		13(13,13,-12,-4,1,4,-8,18,6,-13)
		14(-11,-7,-2,-10,6,-1,-12,19,-12,-5)
		15(20,7,-19,16,-16,13,18,2,-4,19)
		16(-17,-19,3,-1,-11,0,-4,2,-18,17)
		17(5,-4,-18,3,-10,-12,3,3,3,-16)
		18(-3,13,-13,-10,-4,-14,14,-16,-4,-12)
		19(-14,-7,20,11,-16,5,1,17,-11,19)
		20(-11,-10,-6,15,11,2,-17,19,18,-19)
		21(-11,-10,-7,6,-9,-16,18,12,-20,-7)
		22(-15,-20,-11,-5,18,-7,11,-16,-9,-14)
		23(-9,-5,-17,-2,5,4,-9,-14,16,6)
		24(0,-17,5,19,20,-7,13,-13,-15,-5)
		25(-18,-18,7,8,4,-14,8,13,18,-13)
		26(3,5,-4,7,7,-19,-19,-20,-13,4)
		27(19,5,0,19,17,16,11,-1,20,5)
		28(-7,-17,-10,-3,14,18,-2,-4,-14,6)
		29(12,-13,14,18,19,-15,-5,-11,15,-17)
		30(10,-7,-13,-7,7,2,-14,20,-19,-4)
		31(6,7,-7,10,12,-3,15,-5,-1,-16)
		32(13,18,18,-2,20,-18,-17,18,19,7)
		33(-14,-11,-2,2,-6,-18,8,4,15,19)
		34(-19,-16,0,20,12,-15,-4,5,-11,-16)
		35(-20,-11,13,10,-17,10,17,-5,-7,-10)
		36(8,12,19,-5,-9,-12,-16,20,-8,7)
		37(13,-6,-3,-12,-20,17,7,-7,-5,-17)
		38(0,13,-6,-17,8,0,6,17,5,-10)
		39(-3,-10,16,-8,-13,-12,-11,7,17,-11)
		40(-3,10,-10,8,6,-6,-19,8,-7,8)
		41(-16,15,1,17,-20,13,1,-12,-18,-6)
		42(16,10,-16,-16,-2,11,-2,-17,-19,-7)
		43(16,4,-17,-11,-11,11,-4,15,-5,3)
		44(-20,16,15,-4,-6,1,-18,-5,-16,6)
		45(-1,16,16,-15,-10,8,13,5,-13,14)
		46(-12,-14,7,-20,9,7,-2,-20,-8,-5)
		47(-6,-11,-12,20,18,-10,2,-3,14,13)
		48(-12,-7,-8,18,3,0,19,5,-7,-12)
		49(3,18,-16,-11,-13,2,-2,-13,6,20)
		50(-14,5,5,4,14,12,-11,-3,5,-20)
		51(14,19,7,2,12,3,9,4,-2,-6)
		52(7,-14,-19,-14,-19,-3,-9,7,-20,-16)
		53(-19,9,9,-2,-16,3,9,15,2,-17)
		54(4,6,-19,-3,-3,0,17,-17,-16,-20)
		55(-16,12,-1,18,-8,-7,7,13,7,7)
		56(-10,15,5,20,6,11,-6,9,13,-10)
		57(12,-1,17,8,-10,-7,-11,1,13,13)
		58(7,20,8,-12,4,20,-9,4,6,8)
		59(3,-1,7,18,-5,11,18,1,19,3)
		60(-11,11,16,-9,-16,-1,9,-20,-5,-15)
		61(4,8,-15,0,-5,5,4,11,8,16)
		62(11,0,-13,3,-6,-19,-16,18,2,20)
		63(9,5,8,13,13,-20,0,13,8,15)
		64(-3,12,15,-17,12,5,4,7,12,2)
		65(-13,-6,-7,-3,9,7,-12,2,16,-17)
		66(-12,-17,-10,6,20,-5,-13,-13,-20,-19)
		67(13,-11,6,-5,0,-11,-11,17,19,-18)
		68(-20,-7,-6,18,9,2,-17,6,-11,11)
		69(-11,14,-9,-12,18,13,-2,14,9,-2)
		70(-7,7,11,6,-16,-17,-18,11,10,-5)
		71(11,-14,12,-14,13,-17,17,-17,5,20)
		72(0,-10,13,9,-18,-11,9,-1,10,-5)
		73(-7,0,-11,-20,-12,-15,13,-12,2,14)
		74(-4,-7,4,2,-15,-7,10,-20,0,10)
		75(20,-8,-13,-6,-15,-13,-17,-10,19,5)
		76(-9,-15,2,20,-17,20,10,-8,6,8)
		77(16,19,-1,-1,13,18,-16,1,-13,20)
		78(-9,-11,7,-1,13,-6,12,-17,18,17)
		79(15,-2,-10,-11,-10,-11,17,0,-19,-15)
		80(-4,-3,-18,-17,20,-1,-10,1,11,-1)
		81(6,-7,-12,14,-12,20,-15,-19,9,3)
		82(6,-11,13,5,-6,3,-15,-5,-6,-15)
		83(-15,-7,13,-1,-12,-5,-9,-7,-3,-13)
		84(17,-19,-14,9,-14,4,-17,6,7,-1)
		85(-5,4,-6,5,20,12,-5,-18,2,10)
		86(20,7,20,-5,-13,-2,12,-15,4,11)
		87(-3,13,9,12,-9,-2,-6,17,-16,-15)
		88(-10,6,-6,-12,0,-10,-3,1,-2,-1)
		89(-13,-13,-6,-11,-16,-6,4,-6,-16,17)
		90(-12,14,-2,-19,0,4,15,-8,-12,2)
		91(2,11,-18,10,13,17,-1,8,-18,-11)
		92(-6,1,6,13,13,-18,-19,19,6,-1)
		93(14,0,1,-1,13,4,-9,14,-3,-8)
		94(-3,7,-19,17,-6,-4,3,3,-8,8)
		95(8,-12,16,16,19,6,18,5,1,-7)
		96(-16,2,-20,5,-16,18,-14,-10,13,-19)
		97(11,-14,5,-17,14,-9,18,-18,-5,1)
		98(20,-19,-14,18,13,11,-15,-18,12,20)
		99(-12,7,5,2,7,13,8,-3,-12,-11)
		100(8,20,-6,15,5,-15,2,-7,0,-8)"
	);

	final test5Result = parseResult(
		"1689(4,6,-9,-10,-5,-6,8,-8,2,0)
		5398(39,-28,-23,20,29,8,-24,-33,10,37)"
	);
}