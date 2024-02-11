package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Simple Case", {
				final ip = simpleCase;
				Main.process( ip.itemLines, ip.orders ).should.be( simpleCaseResult );
			});
			it( "More People", {
				final ip = morePeople;
				Main.process( ip.itemLines, ip.orders ).should.be( morePeopleResult );
			});
			it( "No Items", {
				final ip = noItems;
				Main.process( ip.itemLines, ip.orders ).should.be( noItemsResult );
			});
			it( "Same Order", {
				final ip = sameOrder;
				Main.process( ip.itemLines, ip.orders ).should.be( sameOrderResult );
			});
			it( "More Items", {
				final ip = moreItems;
				Main.process( ip.itemLines, ip.orders ).should.be( moreItemsResult );
			});
			it( "Sold Out", {
				final ip = soldOut;
				Main.process( ip.itemLines, ip.orders ).should.be( soldOutResult );
			});
			it( "Busy Day", {
				final ip = busyDay;
				Main.process( ip.itemLines, ip.orders ).should.be( busyDayResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final c = parseInt(lines[0] );
		final p = parseInt( lines[1] );
		final itemLines = [for( i in 0...c ) lines[i + 2]];
		final orders = [for( i in 0...p ) lines[i + c + 2]];
	
		return { itemLines: itemLines, orders: orders }
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final simpleCase = parseInput(
		"3
		2
		JEANS LARGE 30
		SHIRT SMALL 15
		JACKET LARGE 20
		JEANS LARGE
		JACKET LARGE" );

	final simpleCaseResult = parseResult(
		"30
		20" );
	
	final morePeople = parseInput(
		"4
		6
		PANTS MEDIUM 20
		COAT LARGE 35
		SHOES MEDIUM 25
		GLOVES LARGE 15
		JEANS MEDIUM
		COAT LARGE
		GLOVES LARGE
		PANTS SMALL
		SHIRT MEDIUM
		SHOES MEDIUM" );

	final morePeopleResult = parseResult(
		"NONE
		35
		15
		NONE
		NONE
		25" );
	
	final noItems = parseInput(
		"0
		4
		SHIRT LARGE
		JACKET MEDIUM
		SHOES MEDIUM
		JEANS SMALL" );

	final noItemsResult = parseResult(
		"NONE
		NONE
		NONE
		NONE" );
	
	final sameOrder = parseInput(
		"4
		6
		COAT LARGE 40
		SHIRT MEDIUM 15
		SHOES LARGE 25
		PANTS SMALL 20
		COAT LARGE
		SHOES LARGE
		SHIRT MEDIUM
		SHIRT MEDIUM
		PANTS SMALL
		COAT LARGE" );

	final sameOrderResult = parseResult(
		"40
		25
		15
		NONE
		20
		NONE" );
	
	final moreItems = parseInput(
		"7
		4
		COAT MEDIUM 35
		SHIRT SMALL 20
		JEANS LARGE 30
		JACKET MEDIUM 45
		SHOES LARGE 25
		SHIRT SMALL 15
		COAT MEDIUM 25
		COAT MEDIUM
		SHOES LARGE
		SHIRT SMALL
		SHIRT SMALL" );

	final moreItemsResult = parseResult(
		"25
		25
		15
		20" );
	
	final soldOut = parseInput(
		"8
		11
		SHIRT LARGE 30
		COAT MEDIUM 25
		COAT MEDIUM 30
		JEANS MEDIUM 25
		SHIRT LARGE 15
		COAT MEDIUM 20
		JEANS MEDIUM 15
		SHIRT LARGE 20
		SHIRT LARGE
		JEANS MEDIUM
		COAT MEDIUM
		SHIRT LARGE
		JEANS MEDIUM
		SHIRT LARGE
		COAT MEDIUM
		JEANS MEDIUM
		COAT MEDIUM
		JEANS MEDIUM
		SHIRT LARGE" );

	final soldOutResult = parseResult(
		"15
		15
		20
		20
		25
		30
		25
		NONE
		30
		NONE
		NONE" );
	
	final busyDay = parseInput(
		"12
		15
		JEANS SMALL 15
		PANTS LARGE 25
		COAT SMALL 25
		PANTS MEDIUM 20
		SHOES LARGE 35
		SHIRT MEDIUM 15
		JEANS SMALL 35
		COAT SMALL 10
		PANTS LARGE 35
		SHIRT MEDIUM 30
		PANTS MEDIUM 15
		COAT LARGE 30
		COAT MEDIUM
		PANTS LARGE
		SHIRT SMALL
		SHIRT MEDIUM
		JEANS SMALL
		PANTS MEDIUM
		COAT SMALL
		JACKET MEDIUM
		SHIRT LARGE
		COAT SMALL
		JEANS LARGE
		SHIRT MEDIUM
		SHOES LARGE
		GLOVES SMALL
		COAT SMALL" );

	final busyDayResult = parseResult(
		"NONE
		25
		NONE
		15
		15
		15
		10
		NONE
		NONE
		25
		NONE
		30
		35
		NONE
		NONE" );
}
