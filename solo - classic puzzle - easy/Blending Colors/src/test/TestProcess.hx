package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test", {
				final ip = test;
				Main.process( ip.shapes, ip.points ).should.be( testResult );
			});
			it( "RGB", {
				final ip = rgb;
				Main.process( ip.shapes, ip.points ).should.be( rgbResult );
			});
			it( "CMY", {
				final ip = cmy;
				Main.process( ip.shapes, ip.points ).should.be( cmyResult );
			});
			it( "All colors", {
				final ip = allColors;
				Main.process( ip.shapes, ip.points ).should.be( allColorsResult );
			});
			it( "Concentric", {
				final ip = concentric;
				Main.process( ip.shapes, ip.points ).should.be( concentricResult );
			});
			it( "Big Canvas", {
				final ip = bigCanvas;
				Main.process( ip.shapes, ip.points ).should.be( bigCanvasResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		var inputs = lines[0].split(' ');
		final s = parseInt( inputs[0] );
		final p = parseInt( inputs[1] );
		final shapes = [for( i in 0...s ) lines[1 + i]];
	
		final points = [for( i in 0...p ) {
			var inputs = lines[1 + shapes.length + i].split(' ');
			final point:Point = { x: parseInt( inputs[0] ), y: parseInt( inputs[1] ) }
			point;
		}];
		return { shapes: shapes, points: points }
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test = parseInput(
	"3 1
	SQUARE 0 5 6 255 0 0
	SQUARE 4 2 3 0 255 0
	CIRCLE 4 6 3 0 0 255
	5 3" );
	
	final testResult = parseResult(
	"(0, 255, 0)" );
	
	final rgb = parseInput(
	"3 6
	SQUARE 0 5 6 255 0 0
	SQUARE 4 2 3 0 255 0
	CIRCLE 4 6 3 0 0 255
	0 0
	4 5
	2 6
	5 3
	5 4
	3 4" );

	final rgbResult = parseResult(
	"(255, 255, 255)
	(0, 0, 0)
	(128, 0, 128)
	(0, 255, 0)
	(0, 128, 128)
	(0, 0, 255)" );

	final cmy = parseInput(
	"10 20
	CIRCLE 60 99 42 255 0 255
	SQUARE 40 9 26 255 255 0
	CIRCLE 33 2 25 255 0 255
	CIRCLE 53 88 25 255 255 0
	CIRCLE 0 27 69 255 255 0
	SQUARE 15 13 58 255 0 255
	SQUARE 68 25 95 0 255 255
	SQUARE 21 69 55 255 0 255
	CIRCLE 13 32 86 255 255 0
	SQUARE 25 77 40 0 255 255
	34 38
	21 55
	92 16
	77 67
	90 51
	8 41
	73 17
	93 67
	83 90
	66 50
	42 77
	31 55
	33 91
	88 30
	12 9
	41 78
	77 54
	19 24
	40 96
	51 22" );

	final cmyResult = parseResult(
	"(255, 170, 85)
	(255, 170, 85)
	(255, 255, 0)
	(170, 170, 170)
	(128, 255, 128)
	(255, 255, 0)
	(0, 0, 0)
	(0, 255, 255)
	(128, 128, 255)
	(255, 128, 128)
	(0, 0, 0)
	(255, 170, 85)
	(204, 153, 153)
	(128, 255, 128)
	(255, 170, 85)
	(213, 170, 128)
	(128, 255, 128)
	(255, 170, 85)
	(204, 153, 153)
	(255, 191, 64)" );

	final allColors = parseInput(
	"10 50
	SQUARE 78 56 96 0 255 0
	CIRCLE 41 5 52 255 255 0
	CIRCLE 81 0 32 255 0 0
	SQUARE 29 53 82 255 0 0
	CIRCLE 72 45 74 0 0 255
	CIRCLE 91 62 60 255 0 0
	CIRCLE 39 53 47 255 0 255
	SQUARE 54 89 82 255 0 0
	SQUARE 32 75 75 0 255 0
	SQUARE 86 1 90 0 255 255
	40 87
	134 70
	141 8
	81 18
	50 110
	5 6
	159 41
	60 94
	44 106
	48 80
	8 70
	116 77
	109 19
	135 23
	72 44
	154 37
	67 167
	42 27
	41 67
	29 18
	53 148
	50 119
	69 117
	160 16
	135 162
	60 79
	0 29
	99 127
	110 27
	43 42
	116 17
	137 10
	101 26
	87 165
	122 22
	76 136
	127 25
	59 99
	42 41
	101 156
	143 137
	159 46
	95 14
	104 30
	157 86
	48 140
	165 134
	123 29
	83 1
	65 165" );

	final allColorsResult = parseResult(
	"(153, 51, 102)
	(64, 128, 128)
	(0, 255, 255)
	(191, 64, 64)
	(85, 85, 85)
	(255, 255, 0)
	(0, 255, 255)
	(170, 43, 85)
	(85, 85, 85)
	(153, 51, 102)
	(128, 0, 255)
	(64, 128, 128)
	(85, 85, 170)
	(85, 85, 170)
	(191, 64, 128)
	(0, 255, 255)
	(255, 0, 0)
	(170, 85, 170)
	(191, 0, 128)
	(170, 85, 170)
	(0, 255, 0)
	(128, 128, 0)
	(153, 51, 51)
	(0, 255, 255)
	(255, 0, 0)
	(153, 51, 102)
	(170, 85, 170)
	(128, 128, 0)
	(85, 85, 170)
	(191, 64, 128)
	(85, 85, 170)
	(0, 128, 255)
	(85, 85, 170)
	(255, 0, 0)
	(85, 85, 170)
	(128, 128, 0)
	(85, 85, 170)
	(153, 51, 51)
	(191, 64, 128)
	(255, 0, 0)
	(0, 255, 0)
	(0, 255, 255)
	(128, 64, 128)
	(85, 85, 170)
	(0, 255, 128)
	(0, 255, 0)
	(0, 255, 0)
	(85, 85, 170)
	(170, 85, 85)
	(255, 0, 0)" );

	final concentric = parseInput(
	"6 8
	CIRCLE 500 500 500 255 255 0
	CIRCLE 500 500 300 255 0 255
	CIRCLE 500 500 100 255 255 0
	CIRCLE 500 500 70 0 255 0
	CIRCLE 500 500 13 0 255 255
	CIRCLE 500 500 13 0 255 255
	500 500
	500 510
	500 550
	500 590
	500 600
	500 700
	500 1000
	1000 1000" );

	final concentricResult = parseResult(
	"(128, 213, 128)
	(128, 213, 128)
	(191, 191, 64)
	(255, 170, 85)
	(0, 0, 0)
	(255, 128, 128)
	(0, 0, 0)
	(255, 255, 255)" );

	final bigCanvas = parseInput(
	"50 50
	CIRCLE 733 830 266 255 0 0
	SQUARE 494 228 33 0 255 255
	CIRCLE 938 272 3 0 0 255
	SQUARE 201 570 7 0 255 0
	SQUARE 260 936 24 255 0 0
	CIRCLE 177 120 206 0 0 255
	SQUARE 412 725 114 0 255 0
	SQUARE 40 559 208 255 0 0
	CIRCLE 810 84 98 255 0 0
	CIRCLE 867 613 6 255 255 0
	CIRCLE 845 531 146 255 0 0
	SQUARE 975 325 172 0 0 255
	SQUARE 489 485 69 255 0 0
	SQUARE 421 758 12 255 0 0
	CIRCLE 877 315 217 255 255 0
	SQUARE 740 941 216 255 0 0
	CIRCLE 531 794 286 0 255 255
	SQUARE 280 783 76 0 255 255
	CIRCLE 780 89 42 255 0 255
	SQUARE 98 100 112 0 255 0
	CIRCLE 91 189 128 255 0 0
	CIRCLE 219 216 42 255 255 0
	CIRCLE 440 784 83 255 0 255
	SQUARE 276 203 199 0 255 0
	SQUARE 688 278 198 0 255 0
	CIRCLE 363 820 25 255 0 0
	SQUARE 342 153 35 255 255 0
	CIRCLE 384 734 35 255 0 0
	SQUARE 608 938 5 255 0 0
	SQUARE 558 97 57 255 255 0
	SQUARE 627 793 200 0 0 255
	SQUARE 489 501 205 0 255 255
	CIRCLE 910 407 299 0 255 0
	CIRCLE 764 914 282 0 255 255
	SQUARE 843 358 10 255 0 255
	CIRCLE 402 229 210 255 0 255
	SQUARE 373 802 205 255 255 0
	CIRCLE 452 601 249 255 0 0
	CIRCLE 185 736 230 255 255 0
	SQUARE 860 897 236 0 255 255
	SQUARE 875 432 57 0 255 255
	SQUARE 140 998 162 0 0 255
	SQUARE 897 383 154 255 0 0
	SQUARE 162 1 168 0 255 0
	SQUARE 748 876 63 0 255 255
	SQUARE 255 959 180 255 0 255
	CIRCLE 443 541 159 0 255 255
	CIRCLE 116 17 13 0 0 255
	SQUARE 973 559 262 255 0 0
	CIRCLE 644 786 121 255 0 255
	32 618
	427 62
	783 207
	227 835
	769 464
	971 283
	198 763
	551 636
	480 46
	977 124
	925 119
	528 275
	884 922
	402 442
	687 398
	906 201
	463 847
	119 290
	137 156
	713 978
	207 4
	770 270
	762 455
	464 78
	419 139
	576 188
	324 704
	107 82
	424 382
	780 931
	226 13
	952 647
	349 176
	569 227
	139 943
	562 991
	85 801
	947 171
	944 948
	641 810
	834 871
	585 105
	267 141
	580 328
	368 963
	335 948
	434 831
	894 87
	319 997
	650 639" );

	final bigCanvasResult = parseResult(
	"(255, 255, 0)
	(255, 0, 255)
	(128, 255, 0)
	(255, 255, 0)
	(128, 191, 0)
	(128, 255, 0)
	(255, 128, 0)
	(64, 191, 191)
	(255, 0, 255)
	(128, 255, 0)
	(128, 255, 0)
	(255, 0, 255)
	(85, 170, 170)
	(128, 128, 128)
	(128, 255, 0)
	(128, 255, 0)
	(191, 128, 128)
	(128, 0, 128)
	(85, 85, 85)
	(64, 128, 191)
	(0, 128, 128)
	(128, 255, 0)
	(128, 191, 0)
	(255, 0, 255)
	(255, 0, 255)
	(255, 0, 255)
	(170, 170, 85)
	(128, 0, 128)
	(170, 85, 85)
	(51, 153, 204)
	(0, 128, 128)
	(0, 255, 0)
	(170, 85, 170)
	(255, 0, 255)
	(255, 255, 0)
	(128, 191, 128)
	(255, 255, 0)
	(128, 255, 0)
	(128, 128, 128)
	(102, 102, 204)
	(128, 128, 128)
	(255, 255, 0)
	(85, 85, 170)
	(255, 0, 255)
	(128, 128, 255)
	(0, 255, 255)
	(153, 153, 102)
	(255, 0, 0)
	(255, 0, 255)
	(128, 128, 128)" );
}
