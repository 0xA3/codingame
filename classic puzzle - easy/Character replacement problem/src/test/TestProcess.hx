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
				Main.process( ip.s, ip.text ).should.be( test1Result );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.s, ip.text ).should.be( test2Result );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.s, ip.text ).should.be( test3Result );
			});
			it( "Test 3x", {
				final ip = test3x;
				Main.process( ip.s, ip.text ).should.be( test3Result );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.s, ip.text ).should.be( test4Result );
			});
			it( "Test 4v", {
				final ip = test4v;
				Main.process( ip.s, ip.text ).should.be( test4Result );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.s, ip.text ).should.be( test5Result );
			});
			it( "Test 6", {
				final ip = test6;
				Main.process( ip.s, ip.text ).should.be( test6Result );
			});
			it( "Test 7", {
				final ip = test7;
				Main.process( ip.s, ip.text ).should.be( test7Result );
			});
			it( "Test 8", {
				final ip = test8;
				Main.process( ip.s, ip.text ).should.be( test8Result );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final s = lines[0];
		final n = parseInt( lines[1] );
		final text = lines.slice( 2 ).join( "\n" );
		return { s: s, text: text }
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
	"ox xx pq
	3
	owe
	uax
	oqp" );

	final test1Result = parseResult(
	"xwe
	uax
	xqq" );

	final test2 = parseInput(
	"oo xx qq ww ff
	3
	oxq
	wfy
	xoa" );

	final test2Result = parseResult(
	"oxq
	wfy
	xoa" );

	final test3 = parseInput(
	"ab bc cd de
	5
	aaaaa
	bbbbb
	ccccc
	ddddd
	eeeee" );

	final test3x = parseInput(
	"ad bc ce db
	5
	aaaaa
	bbbbb
	ccccc
	ddddd
	eeeee" );

	final test3Result = parseResult(
	"eeeee
	eeeee
	eeeee
	eeeee
	eeeee" );

	final test4 = parseInput(
	"zz zi ia az
	4
	zzzz
	iiii
	aaaa
	zzzz" );

	final test4v = parseInput(
	"ak kp pp pk
	4
	aaaa
	ckkc
	pqpq
	qpqp" );

	final test4Result = parseResult(
	"ERROR" );

	final test5 = parseInput(
	"zz zi ia ao
	4
	zzzz
	iiii
	aaaa
	zzzz" );

	final test5Result = parseResult(
	"oooo
	oooo
	oooo
	oooo" );

	final test6 = parseInput(
	"zo zi tw ax
	5
	zizhm
	ioerc
	asrfb
	tuoge
	urebe" );

	final test6Result = parseResult(
	"ERROR" );

	final test7 = parseInput(
	"ty rt er we
	5
	wwwww
	eeeee
	rrrrr
	ttttt
	yyyyy" );

	final test7Result = parseResult(
	"yyyyy
	yyyyy
	yyyyy
	yyyyy
	yyyyy" );

	final test8 = parseInput(
	"qw ws aq za sd
	6
	zzzzzz
	aaaaaa
	qqqqqq
	wwwwww
	ssssss
	dddddd" );

	final test8Result = parseResult(
	"dddddd
	dddddd
	dddddd
	dddddd
	dddddd
	dddddd" );
}
