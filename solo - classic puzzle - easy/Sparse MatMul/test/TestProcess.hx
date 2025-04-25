package test;

import Main.Entry;
import Std.parseFloat;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			@include it( "Example", {
				final ip = example;
				Main.process( ip.m, ip.n, ip.p, ip.matrix1Entries, ip.matrix2Entries ).should.be( exampleResult );
			});
			it( "Corners", {
				final ip = corners;
				Main.process( ip.m, ip.n, ip.p, ip.matrix1Entries, ip.matrix2Entries ).should.be( cornersResult );
			});
			it( "Dense", {
				final ip = dense;
				Main.process( ip.m, ip.n, ip.p, ip.matrix1Entries, ip.matrix2Entries ).should.be( denseResult );
			});
			it( "Cancellation", {
				final ip = cancellation;
				Main.process( ip.m, ip.n, ip.p, ip.matrix1Entries, ip.matrix2Entries ).should.be( cancellationResult );
			});
			it( "Banded", {
				final ip = banded;
				Main.process( ip.m, ip.n, ip.p, ip.matrix1Entries, ip.matrix2Entries ).should.be( bandedResult );
			});
			it( "Supertask", {
				final ip = supertask;
				Main.process( ip.m, ip.n, ip.p, ip.matrix1Entries, ip.matrix2Entries ).should.be( supertaskResult );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final inputs = readline().split(' ');
		final m = parseInt(inputs[0]);
		final n = parseInt(inputs[1]);
		final p = parseInt(inputs[2]);
		final inputs = readline().split(' ');
		final countA = parseInt(inputs[0]);
		final countB = parseInt(inputs[1]);
		final matrix1Entries = readEntries( countA );
		final matrix2Entries = readEntries( countB );
				
		return { m: m, n: n, p: p, matrix1Entries: matrix1Entries, matrix2Entries: matrix2Entries };
	}

	static function readEntries( count:Int ) {
		return [for( i in 0...count ) {
			final inputs = readline().split(' ');
			final entry:Entry = { row: parseInt( inputs[0] ), col: parseInt( inputs[1] ), value: parseFloat( inputs[2] ) }
			entry;
		}];
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final example = parseInput(
		"4 3 5
		3 2
		1 0 1.0
		1 1 2.0
		1 2 3.0
		0 3 5.0
		2 3 1.0"
	);

	final exampleResult = parseResult(
		"1 3 8.0"
	);

	final corners = parseInput(
		"400001 300001 500001
		4 4
		0 0 1.0
		0 300000 5.0
		400000 0 3.0
		400000 300000 1.0
		0 0 3.0
		0 500000 1.0
		300000 0 2.0
		300000 500000 4.0"
	);

	final cornersResult = parseResult(
		"0 0 13.0
		0 500000 21.0
		400000 0 11.0
		400000 500000 7.0"
	);

	final dense = parseInput(
		"10 1 10
		9 9
		1 0 1.25
		2 0 2.5
		3 0 3.75
		4 0 5.0
		5 0 6.25
		6 0 7.5
		7 0 8.75
		8 0 10.0
		9 0 11.25
		0 1 1.25
		0 2 2.5
		0 3 3.75
		0 4 5.0
		0 5 6.25
		0 6 7.5
		0 7 8.75
		0 8 10.0
		0 9 11.25"
	);

	final denseResult = parseResult(
		"1 1 1.5625
		1 2 3.125
		1 3 4.6875
		1 4 6.25
		1 5 7.8125
		1 6 9.375
		1 7 10.9375
		1 8 12.5
		1 9 14.0625
		2 1 3.125
		2 2 6.25
		2 3 9.375
		2 4 12.5
		2 5 15.625
		2 6 18.75
		2 7 21.875
		2 8 25.0
		2 9 28.125
		3 1 4.6875
		3 2 9.375
		3 3 14.0625
		3 4 18.75
		3 5 23.4375
		3 6 28.125
		3 7 32.8125
		3 8 37.5
		3 9 42.1875
		4 1 6.25
		4 2 12.5
		4 3 18.75
		4 4 25.0
		4 5 31.25
		4 6 37.5
		4 7 43.75
		4 8 50.0
		4 9 56.25
		5 1 7.8125
		5 2 15.625
		5 3 23.4375
		5 4 31.25
		5 5 39.0625
		5 6 46.875
		5 7 54.6875
		5 8 62.5
		5 9 70.3125
		6 1 9.375
		6 2 18.75
		6 3 28.125
		6 4 37.5
		6 5 46.875
		6 6 56.25
		6 7 65.625
		6 8 75.0
		6 9 84.375
		7 1 10.9375
		7 2 21.875
		7 3 32.8125
		7 4 43.75
		7 5 54.6875
		7 6 65.625
		7 7 76.5625
		7 8 87.5
		7 9 98.4375
		8 1 12.5
		8 2 25.0
		8 3 37.5
		8 4 50.0
		8 5 62.5
		8 6 75.0
		8 7 87.5
		8 8 100.0
		8 9 112.5
		9 1 14.0625
		9 2 28.125
		9 3 42.1875
		9 4 56.25
		9 5 70.3125
		9 6 84.375
		9 7 98.4375
		9 8 112.5
		9 9 126.5625"
	);

	final cancellation = parseInput(
		"10 10 10
		5 5
		0 0 2.0
		0 7 -1.0
		2 2 2.25
		7 0 1.0
		7 7 -2.0
		0 0 0.5
		0 7 -1.0
		5 5 5.5
		7 0 1.0
		7 7 -0.5"
	);

	final cancellationResult = parseResult(
		"0 7 -1.5
		7 0 -1.5"
	);

	final banded = parseInput(
		"10 10 10
		27 27
		0 0 6.125
		0 1 9.875
		1 0 -0.875
		1 1 1.25
		1 2 3.0
		2 1 -0.25
		2 2 6.0
		2 3 -1.25
		3 2 6.25
		3 3 7.125
		3 4 7.0
		4 3 6.625
		4 5 -5.0
		5 4 3.5
		5 5 9.0
		5 6 3.875
		6 5 -7.5
		6 6 -8.0
		6 7 6.25
		7 6 -8.75
		7 7 6.125
		7 8 3.125
		8 7 -5.0
		8 8 2.25
		8 9 8.75
		9 8 6.25
		9 9 -7.0
		0 0 -5.75
		0 1 -8.875
		1 0 5.0
		1 1 2.5
		1 2 -5.5
		2 1 9.25
		2 2 10.0
		2 3 1.25
		3 2 9.25
		3 3 6.0
		3 4 6.125
		4 3 4.125
		4 5 6.5
		5 4 9.0
		5 5 -1.0
		5 6 9.5
		6 5 2.375
		6 6 3.25
		6 7 -0.5
		7 6 7.5
		7 7 0.5
		7 8 8.5
		8 7 2.5
		8 8 5.75
		8 9 9.0
		9 8 -3.375
		9 9 8.625"
	);

	final bandedResult = parseResult(
		"0 0 14.15625
		0 1 -29.671875
		0 2 -54.3125
		1 0 11.28125
		1 1 38.640625
		1 2 23.125
		1 3 3.75
		2 0 -1.25
		2 1 54.875
		2 2 49.8125
		2 4 -7.65625
		3 1 57.8125
		3 2 128.40625
		3 3 79.4375
		3 4 43.640625
		3 5 45.5
		4 2 61.28125
		4 3 39.75
		4 4 -4.421875
		4 5 5.0
		4 6 -47.5
		5 3 14.4375
		5 4 81.0
		5 5 22.953125
		5 6 98.09375
		5 7 -1.9375
		6 4 -67.5
		6 5 -11.5
		6 6 -50.375
		6 7 7.125
		6 8 53.125
		7 5 -20.78125
		7 6 17.5
		7 7 15.25
		7 8 70.03125
		7 9 28.125
		8 6 -37.5
		8 7 3.125
		8 8 -59.09375
		8 9 95.71875
		9 7 15.625
		9 8 59.5625
		9 9 -4.125"
	);

	final supertask = parseInput(
		"999999 999999 999999
		19 42
		32015 637228 -8.75
		66238 637228 4.75
		176689 576751 -7.5
		184860 728927 2.0
		193653 637228 4.5
		251533 747153 -2.75
		257676 665614 6.625
		290436 251019 1.875
		363175 975558 4.5
		456601 115685 4.625
		538719 221698 -6.375
		823185 518010 1.25
		829589 866115 3.25
		908296 728927 4.75
		948050 612857 4.75
		951147 637228 3.5
		966481 104709 2.0
		973240 612857 -8.5
		989830 975558 -2.375
		74359 62355 -5.875
		74359 797746 6.0
		104709 123929 2.5
		115685 71392 7.0
		115685 167214 5.125
		115685 256194 4.5
		115685 297754 -2.375
		115685 877173 -3.875
		221698 274902 6.5
		221698 359612 4.125
		221698 549877 -2.75
		251019 260934 4.5
		251019 422195 -6.625
		251019 592711 -1.0
		251019 758740 7.0
		251019 908624 6.125
		378372 884363 -4.25
		383965 198264 -0.5
		383965 247456 1.5
		383965 658497 7.5
		383965 728534 9.75
		518010 139533 6.5
		518010 654555 -4.0
		518010 878634 -1.5
		549575 221900 -7.5
		576751 369129 1.0
		612857 387980 -4.625
		612857 433496 -4.5
		612857 604133 6.25
		637228 367280 2.375
		657081 635525 -4.625
		665614 909517 2.75
		665614 962318 8.875
		679367 842107 6.25
		728927 379413 8.0
		728927 572572 1.875
		747153 180415 -6.0
		747153 708847 5.25
		813725 697486 0.125
		866115 465921 -2.25
		975558 653211 2.75
		975558 772471 2.875"
	);

	final supertaskResult = parseResult(
		"32015 367280 -20.78125
		66238 367280 11.28125
		176689 369129 -7.5
		184860 379413 16.0
		184860 572572 3.75
		193653 367280 10.6875
		251533 180415 16.5
		251533 708847 -14.4375
		257676 909517 18.21875
		257676 962318 58.796875
		290436 260934 8.4375
		290436 422195 -12.421875
		290436 592711 -1.875
		290436 758740 13.125
		290436 908624 11.484375
		363175 653211 12.375
		363175 772471 12.9375
		456601 71392 32.375
		456601 167214 23.703125
		456601 256194 20.8125
		456601 297754 -10.984375
		456601 877173 -17.921875
		538719 274902 -41.4375
		538719 359612 -26.296875
		538719 549877 17.53125
		823185 139533 8.125
		823185 654555 -5.0
		823185 878634 -1.875
		829589 465921 -7.3125
		908296 379413 38.0
		908296 572572 8.90625
		948050 387980 -21.96875
		948050 433496 -21.375
		948050 604133 29.6875
		951147 367280 8.3125
		966481 123929 5.0
		973240 387980 39.3125
		973240 433496 38.25
		973240 604133 -53.125
		989830 653211 -6.53125
		989830 772471 -6.828125"
	);
}
