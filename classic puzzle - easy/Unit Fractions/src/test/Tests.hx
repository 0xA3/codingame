package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Example", { Main.process( 2 ).should.be( exampleResult ); });
			it( "12", { Main.process( 12 ).should.be( _12Result ); });
			it( "17", { Main.process( 17 ).should.be( _17Result ); });
			it( "100", { Main.process( 100 ).should.be( _100Result ); });
			it( "102", { Main.process( 102 ).should.be( _102Result ); });
			it( "9999", { Main.process( 9999 ).should.be( _9999Result ); });
			it( "71339", { Main.process( 71339 ).should.be( _71339Result ); });
			it( "104027", { Main.process( 104027 ).should.be( _104027Result ); });
			
		});

	}

	static function parseResult( input:String ) {
		return input.split( "\n" ).map( line -> line.trim()).join( "\n" );
	}

	static final exampleResult = parseResult (
	"1/2 = 1/6 + 1/3
	1/2 = 1/4 + 1/4" );

	static final _12Result = parseResult (
	"1/12 = 1/156 + 1/13
	1/12 = 1/84 + 1/14
	1/12 = 1/60 + 1/15
	1/12 = 1/48 + 1/16
	1/12 = 1/36 + 1/18
	1/12 = 1/30 + 1/20
	1/12 = 1/28 + 1/21
	1/12 = 1/24 + 1/24" );

	static final _17Result = parseResult (
	"1/17 = 1/306 + 1/18
	1/17 = 1/34 + 1/34" );

	static final _100Result = parseResult (
	"1/100 = 1/10100 + 1/101
	1/100 = 1/5100 + 1/102
	1/100 = 1/2600 + 1/104
	1/100 = 1/2100 + 1/105
	1/100 = 1/1350 + 1/108
	1/100 = 1/1100 + 1/110
	1/100 = 1/725 + 1/116
	1/100 = 1/600 + 1/120
	1/100 = 1/500 + 1/125
	1/100 = 1/350 + 1/140
	1/100 = 1/300 + 1/150
	1/100 = 1/225 + 1/180
	1/100 = 1/200 + 1/200" );

	static final _102Result = parseResult (
	"1/102 = 1/10506 + 1/103
	1/102 = 1/5304 + 1/104
	1/102 = 1/3570 + 1/105
	1/102 = 1/2703 + 1/106
	1/102 = 1/1836 + 1/108
	1/102 = 1/1258 + 1/111
	1/102 = 1/969 + 1/114
	1/102 = 1/714 + 1/119
	1/102 = 1/680 + 1/120
	1/102 = 1/408 + 1/136
	1/102 = 1/391 + 1/138
	1/102 = 1/306 + 1/153
	1/102 = 1/255 + 1/170
	1/102 = 1/204 + 1/204" );

	static final _9999Result = parseResult (
	"1/9999 = 1/99990000 + 1/10000
	1/9999 = 1/33336666 + 1/10002
	1/9999 = 1/11118888 + 1/10008
	1/9999 = 1/9099090 + 1/10010
	1/9999 = 1/3712962 + 1/10026
	1/9999 = 1/3039696 + 1/10032
	1/9999 = 1/1244320 + 1/10080
	1/9999 = 1/1019898 + 1/10098
	1/9999 = 1/999900 + 1/10100
	1/9999 = 1/836280 + 1/10120
	1/9999 = 1/346632 + 1/10296
	1/9999 = 1/339966 + 1/10302
	1/9999 = 1/285426 + 1/10362
	1/9999 = 1/122210 + 1/10890
	1/9999 = 1/119988 + 1/10908
	1/9999 = 1/101808 + 1/11088
	1/9999 = 1/99990 + 1/11110
	1/9999 = 1/46662 + 1/12726
	1/9999 = 1/40602 + 1/13266
	1/9999 = 1/39996 + 1/13332
	1/9999 = 1/22220 + 1/18180
	1/9999 = 1/20200 + 1/19800
	1/9999 = 1/19998 + 1/19998" );

	static final _71339Result = parseResult (
	"1/71339 = 1/5089324260 + 1/71340
	1/71339 = 1/142678 + 1/142678" );

	static final _104027Result = parseResult (
	"1/104027 = 1/10821720756 + 1/104028
	1/104027 = 1/1546049274 + 1/104034
	1/104027 = 1/983887366 + 1/104038
	1/104027 = 1/220953348 + 1/104076
	1/104027 = 1/140644504 + 1/104104
	1/104027 = 1/89538876 + 1/104148
	1/104027 = 1/56174580 + 1/104220
	1/104027 = 1/31653930 + 1/104370
	1/104027 = 1/20181238 + 1/104566
	1/104027 = 1/12880434 + 1/104874
	1/104027 = 1/8114106 + 1/105378
	1/104027 = 1/5201350 + 1/106150
	1/104027 = 1/4611156 + 1/106428
	1/104027 = 1/2972200 + 1/107800
	1/104027 = 1/1929228 + 1/109956
	1/104027 = 1/1248324 + 1/113484
	1/104027 = 1/832216 + 1/118888
	1/104027 = 1/567420 + 1/127380
	1/104027 = 1/513766 + 1/130438
	1/104027 = 1/394548 + 1/141276
	1/104027 = 1/364770 + 1/145530
	1/104027 = 1/267498 + 1/170226
	1/104027 = 1/208054 + 1/208054" );

}

