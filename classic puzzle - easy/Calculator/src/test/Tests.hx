package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "A simple operation", {
				Main.process( aSimpleOperation ).should.be( aSimpleOperationResult );
			});
			it( "Multiplication and division", {
				Main.process( multiplicationAndDivision ).should.be( multiplicationAndDivisionResult );
			});
			it( "Using AC", {
				Main.process( usingAC ).should.be( usingACResult );
			});
			it( "Change of opinion", {
				Main.process( changeOfOpinion ).should.be( changeOfOpinionResult );
			});
			it( "Many operations", {
				Main.process( manyOperations ).should.be( manyOperationsResult );
			});
			it( "Double equal", {
				Main.process( doubleEqual ).should.be( doubleEqualResult );
			});
			it( "Press equal many times", {
				Main.process( pressEqualManyTimes ).should.be( pressEqualManyTimesResult );
			});
			it( "Long test", {
				Main.process( longTest ).should.be( longTestResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final n = parseInt( lines[0] );
		final keys = [for( i in 0...n ) lines[i + 1]];

		return keys;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	static final aSimpleOperation = parseInput(
	"7
	2
	5
	+
	6
	-
	7
	=" );

	static final aSimpleOperationResult = parseResult(
	"2
	25
	25
	6
	31
	7
	24" );
	
	
	static final multiplicationAndDivision = parseInput(
	"8
	9
	3
	x
	1
	2
	/
	5
	=" );

	static final multiplicationAndDivisionResult = parseResult(
	"9
	93
	93
	1
	12
	1116
	5
	223.2" );
	
	
	static final usingAC = parseInput(
	"10
	3
	/
	4
	AC
	7
	/
	4
	x
	8
	=" );

	static final usingACResult = parseResult(
	"3
	3
	4
	0
	7
	7
	4
	1.75
	8
	14" );
	
	
	static final changeOfOpinion = parseInput(
	"8
	2
	1
	x
	3
	-
	/
	9
	=" );

	static final changeOfOpinionResult = parseResult(
	"2
	21
	21
	3
	63
	63
	9
	7" );
	
	
	static final manyOperations = parseInput(
	"24
	3
	1
	5
	6
	-
	2
	7
	4
	=
	7
	9
	x
	1
	2
	+
	3
	=
	2
	AC
	7
	9
	/
	3
	=" );

	static final manyOperationsResult = parseResult(
	"3
	31
	315
	3156
	3156
	2
	27
	274
	2882
	7
	79
	79
	1
	12
	948
	3
	951
	2
	0
	7
	79
	79
	3
	26.333" );
	
	
	static final doubleEqual = parseInput(
	"5
	8
	+
	2
	=
	=" );

	static final doubleEqualResult = parseResult(
	"8
	8
	2
	10
	12" );
	
	
	static final pressEqualManyTimes = parseInput(
	"18
	8
	x
	3
	+
	2
	=
	=
	=
	2
	7
	9
	/
	9
	-
	4
	=
	=
	=" );

	static final pressEqualManyTimesResult = parseResult(
	"8
	8
	3
	24
	2
	26
	28
	30
	2
	27
	279
	279
	9
	31
	4
	27
	23
	19" );
	
	
	static final longTest = parseInput(
	"26
	7
	9
	x
	-
	7
	+
	AC
	8
	/
	3
	+
	5
	=
	8
	2
	5
	7
	-
	5
	4
	=
	=
	+
	1
	2
	=" );

	static final longTestResult = parseResult(
	"7
	79
	79
	79
	7
	72
	0
	8
	8
	3
	2.667
	5
	7.667
	8
	82
	825
	8257
	8257
	5
	54
	8203
	8149
	8149
	1
	12
	8161" );
}
