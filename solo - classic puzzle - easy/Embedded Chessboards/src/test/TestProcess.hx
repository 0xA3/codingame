package test;

import Main.processPainting;
import Main.Painting;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test processPainting", {
			it( "8 8 white", { processPainting( 8, 8, true ).should.be( 1 ); });
			it( "9 8 white", { processPainting( 9, 8, true ).should.be( 1 ); });
			it( "10 8 white", { processPainting( 10, 8, true ).should.be( 2 ); });
			it( "11 8 white", { processPainting( 11, 8, true ).should.be( 2 ); });
			it( "12 8 white", { processPainting( 12, 8, true ).should.be( 3 ); });
			
			it( "8 8 black", { processPainting( 8, 8, false ).should.be( 0 ); });
			it( "9 8 black", { processPainting( 9, 8, false ).should.be( 1 ); });
			it( "10 8 black", { processPainting( 10, 8, false ).should.be( 1 ); });
			it( "11 8 black", { processPainting( 11, 8, false ).should.be( 2 ); });
			it( "12 8 black", { processPainting( 12, 8, false ).should.be( 2 ); });
		});

		describe( "Test process", {
			it( "Small Painting", { Main.process( smallPainting ).should.be( smallPaintingResult ); });
			it( "Bigger Painting", { Main.process( biggerPainting ).should.be( biggerPaintingResult ); });
			it( "Random 1", { Main.process( random1 ).should.be( random1Result ); });
			it( "Random 2", { Main.process( random2 ).should.be( random2Result ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final n = parseInt( lines[0] );
		final paintings:Array<Painting> = [
			for( i in 0...n ) {
				final inputs = lines[i + 1].split(" ");
				{ rows: parseInt( inputs[0] ), cols: parseInt( inputs[1] ), isWhite: inputs[2] == "1" }
			}
		];

		return paintings;
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final smallPainting = parseInput(
	"5
	8 8 0
	9 8 1
	8 10 0
	10 9 0
	10 11 1" );

	final smallPaintingResult = parseResult(
	"0
	1
	1
	3
	6" );

	final biggerPainting = parseInput(
	"5
	12 48 0
	17 62 1
	40 8 1
	57 12 0
	39 100 0" );

	final biggerPaintingResult = parseResult(
	"102
	275
	17
	125
	1488" );

	final random1 = parseInput(
	"50
	72 542 0
	281 260 1
	299 714 1
	626 987 1
	683 270 1
	839 124 0
	793 703 1
	64 649 1
	253 491 1
	127 549 0
	962 180 0
	753 202 0
	616 501 1
	446 913 0
	196 182 1
	119 886 0
	619 677 1
	951 612 1
	382 717 1
	335 409 1
	891 343 1
	776 255 1
	582 471 1
	336 70 1
	877 414 1
	700 992 0
	736 109 1
	219 243 0
	281 588 1
	202 494 0
	658 312 1
	644 104 1
	704 100 0
	720 89 1
	411 438 0
	547 440 0
	791 38 1
	756 422 0
	875 21 0
	706 186 1
	37 254 0
	992 689 0
	502 51 1
	459 56 1
	174 306 0
	160 627 0
	618 698 1
	949 110 1
	699 367 1
	738 972 1" );

	final random1Result = parseResult(
	"17387
	34661
	103222
	303310
	88894
	48672
	273528
	18297
	59532
	32520
	82607
	72735
	150423
	198867
	16538
	49224
	205020
	285560
	133125
	65928
	148512
	95356
	133400
	10364
	177045
	341302
	37179
	25016
	79597
	47482
	99278
	30895
	32410
	29233
	87062
	116910
	12152
	155417
	6076
	62561
	3705
	335885
	10890
	11074
	24966
	47430
	211101
	48513
	124560
	352708" );

	final random2 = parseInput(
	"50
	6661 2198 0
	4872 1793 0
	4039 4293 1
	4168 9586 0
	7096 3916 0
	6694 4160 1
	7040 6225 1
	2135 7381 0
	7401 2582 1
	3945 2546 1
	4235 5421 0
	3746 2587 0
	9391 8994 1
	7486 3683 0
	185 5895 1
	1857 3776 1
	6379 3449 1
	2942 4018 1
	2981 8907 1
	2081 4914 0
	1165 1406 0
	9590 1274 1
	8864 8288 1
	4184 5112 1
	1197 4291 1
	5944 8470 0
	5768 1100 0
	2030 9522 1
	4773 2673 0
	4827 2126 1
	678 3673 0
	8605 4348 0
	1716 33 1
	9795 2887 1
	1534 6228 1
	7062 36 1
	1247 2764 1
	197 744 1
	6849 5873 0
	9264 1498 0
	4041 7619 1
	859 4712 1
	2590 9789 1
	7741 1790 0
	42 204 0
	3823 9347 0
	9711 9057 1
	5906 621 0
	996 6210 1
	3751 5356 0" );

	final random2Result = parseResult(
	"7289457
	4344445
	8640576
	19929109
	13855450
	13885556
	21865597
	7845936
	9519775
	4999291
	11445196
	4823310
	42167004
	13746402
	524032
	3486325
	10966212
	5886143
	13234300
	5088559
	810021
	6070831
	36672409
	10661793
	2548980
	25122415
	3148386
	9624423
	6353078
	5106790
	1229943
	18661959
	22217
	14094720
	4749734
	102298
	1709340
	70015
	20067586
	6901093
	15353404
	2004330
	12633453
	6894861
	3447
	17820720
	43910600
	1810993
	3067384
	10013328" );
}
