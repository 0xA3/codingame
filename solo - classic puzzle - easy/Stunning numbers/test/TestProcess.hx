package test;

import Main.checkStunning;
import Main.findNextStunning;
import Main.increase;
import Main.mirror;
import Std.parseInt;
import haxe.Int64;
import haxe.ds.Either;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test checkStunning", {
			it( "Test 0", checkStunning( 0 ).should.be( true ));
			it( "Test 3", checkStunning( 3 ).should.be( false ));
			it( "Test 6", checkStunning( 6 ).should.be( false ));
			it( "Test 10", checkStunning( 10 ).should.be( false ));
			it( "Test 69", checkStunning( 69 ).should.be( true ));
			it( "Test 181", checkStunning( 181 ).should.be( true ));
		});
		
		describe( "Test mirror", {
			it( "Test 1 odd", mirror( ["1"], false ).join( "" ).should.be( "1" ));
			it( "Test 1 even", mirror( ["1"], true ).join( "" ).should.be( "11" ));
			it( "Test 10 odd", mirror( ["1", "0"], false ).join( "" ).should.be( "101" ));
			it( "Test 10 even", mirror( ["1", "0"], true ).join( "" ).should.be( "1001" ));
		});

		@include describe( "Test increase", {
			it( "Test 0", increase( ["0"], 0 ).join( "" ).should.be( "1" ));
			it( "Test 2", increase( ["2"], 0 ).join( "" ).should.be( "5" ));
			it( "Test 9", increase( ["9"], 0 ).join( "" ).should.be( "10" ));
			it( "Test 20", increase( ["2","0"], 1 ).join( "" ).should.be( "21" ));
			it( "Test 21", increase( ["2","1"], 0 ).join( "" ).should.be( "50" ));
			it( "Test 99", increase( ["9","9"], 1 ).join( "" ).should.be( "100" ));
		});
		
		describe( "Test findNextStunning", {
			it( "Test 69", findNextStunning( 70 ).should.be( "88" ));
			it( "Test 122", findNextStunning( 122 ).should.be( "151" ));
			it( "Test 1234", findNextStunning( 1234 ).should.be( "1551" ));
			it( "Test 12", findNextStunning( 12 ).should.be( "1551" ));
		});

		describe( "Test process", {
			it( "Test 1", Main.process( "69" ).should.be( test1Result ));
			it( "Test 2", Main.process( "161" ).should.be( test2Result ));
			it( "Test 3", Main.process( "9987" ).should.be( test3Result ));
			it( "Test 4", Main.process( "654321" ).should.be( test4Result ));
			it( "Test 5", Main.process( "1260921" ).should.be( test5Result ));
			it( "Test 6", Main.process( "88888888" ).should.be( test6Result ));
			it( "Test 7", Main.process( "123456789" ).should.be( test7Result ));
			it( "Test 8", Main.process( "314159265359" ).should.be( test8Result ));
			it( "Test 9", Main.process( "6920158510269" ).should.be( test9Result ));
			it( "Test 10", Main.process( "12688109960188921" ).should.be( test10Result ));
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1Result = parseResult(
		"true
		88"
	);

	final test2Result = parseResult(
		"false
		181"
	);
	
	final test3Result = parseResult(
		"false
		10001"
	);
	
	final test4Result = parseResult(
		"false
		655559"
	);
	
	final test5Result = parseResult(
		"true
		1261921"
	);
	
	final test6Result = parseResult(
		"true
		88896888"
	);
	
	final test7Result = parseResult(
		"false
		125000521"
	);
	
	final test8Result = parseResult(
		"false
		500000000005"
	);
	
	final test9Result = parseResult(
		"true
		6920160910269"
	);
	
	final test10Result = parseResult(
		"false
		12688110001188921"
	);
}
