package test;

import haxe.Int64;
import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Example", {
				final ip = example;
				Main.process( ip.width, ip.height, ip.numbers, ip.grid ).should.be( true );
			});
			
			it( "Example 2", {
				final ip = example2;
				Main.process( ip.width, ip.height, ip.numbers, ip.grid ).should.be( false );
			});
			
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.width, ip.height, ip.numbers, ip.grid ).should.be( true );
			});
			
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.width, ip.height, ip.numbers, ip.grid ).should.be( true );
			});
			
			it( "Test 5", {
				final ip = example;
				Main.process( ip.width, ip.height, ip.numbers, ip.grid ).should.be( true );
			});
			
			it( "Test 6", {
				final ip = example;
				Main.process( ip.width, ip.height, ip.numbers, ip.grid ).should.be( true );
			});
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final inputs = lines[0].split(' ');
		final height = parseInt( inputs[0] );
		final width = parseInt( inputs[1] );
		final numbers = [for( i in 0...height ) lines[i + 1].split(" ").map( line -> parseInt( line ))].flatten();
		final grid = [for( i in 0...height ) lines[height + i + 1].split(" ")].flatten();
		
		return { width: width, height: height, numbers: numbers, grid: grid };
	}
	
	final example = parseInput(
		"5 4
		12 -1 4 -21
		3 8 99 4
		96 -92 1 -31
		18 -69 -15 26
		23 7 -77 -73
		X X X X
		0 0 0 0
		0 0 0 0
		0 0 0 0
		0 0 0 0"
	);

	final example2 = parseInput(
		"3 5
		36 324 -140 33 37
		115 -289 -225 -372 6
		-302 198 -403 -202 48
		X X X X X
		0 X X X 0
		0 0 X 0 0"
	);

	final test3 = parseInput(
		"5 6
		13 -1 -34 68 10 -29
		5 -98 54 50 -92 10
		51 92 -16 -8 -80 -19
		-4 93 18 49 -36 -65
		28 38 -72 76 -55 12
		0 0 0 0 0 0
		0 0 0 0 0 0
		0 0 0 0 0 0
		0 0 0 0 0 0
		0 0 0 0 0 0"
	);

	final test4 = parseInput(
		"10 4
		-6 76 82 -48
		74 39 -232 -149
		24 -36 -115 90
		-43 -40 405 28
		-87 -2 -115 -469
		-56 89 -472 -20
		-49 73 233 191
		-73 79 -113 449
		72 212 -178 384
		21 197 238 451
		X 0 0 0
		0 X 0 0
		0 0 X 0
		0 0 0 X
		0 0 X 0
		0 X 0 0
		X 0 0 0
		0 X 0 0
		0 0 X 0
		0 0 0 X"
	);

	final test5 = parseInput(
		"10 10
		-391 -285 -997 245 -130 33 898 -406 913 -882
		-478 -409 -16 -978 692 -988 832 -830 269 -53
		378 -187 251 517 -508 -186 680 -761 521 727
		47 -871 -559 50 374 312 -917 271 906 997
		390 -573 -413 -626 -550 -722 -614 -382 -551 656
		566 827 -532 183 -344 39 -631 24 -200 151
		-250 -753 281 192 298 -346 -496 381 926 -591
		378 -316 -163 965 -691 287 -757 -923 905 -308
		733 471 -481 -799 -713 863 162 -919 -114 -638
		70 637 -391 -650 -171 907 5 -333 288 -69
		0 0 0 0 0 0 0 X 0 0
		0 0 0 0 0 0 X 0 0 0
		0 0 0 0 0 X 0 0 0 0
		0 0 0 0 0 X 0 0 0 0
		0 0 0 0 0 X 0 0 0 0
		0 X X X X X X X 0 0
		0 X 0 0 0 0 0 X 0 0
		0 X 0 X X X 0 X 0 0
		0 X 0 X 0 X 0 X 0 0
		0 X 0 X 0 X 0 X 0 0"
	);

	final test6 = parseInput(
		"60 20
		651 -568 552 -976 748 -314 456 -655 450 -965 314 -449 432 -333 264 -126 412 -797 644 -249
		606 -847 448 -574 713 -592 708 -216 110 -170 138 -993 682 -310 969 -934 997 -424 722 -454
		460 -885 607 -92 458 -894 500 -751 322 -610 80 -364 839 -489 303 -425 638 -285 222 -282
		466 -917 275 -785 394 -243 851 -390 334 -572 936 -874 688 -671 34 -771 565 -534 521 -758
		144 -559 607 -306 930 -696 269 -708 589 -953 11 -877 964 -737 661 -430 506 -512 180 -828
		935 -449 259 -283 554 -29 817 -430 63 -147 927 -880 357 -239 65 -313 225 -925 579 -455
		447 -767 201 -667 11 -148 884 -663 976 -405 526 -911 147 -216 373 -593 755 -556 837 -183
		591 -763 62 -766 2 -997 78 -777 921 -499 679 -526 266 -121 860 -723 973 -976 385 -949
		429 -860 859 -718 76 -514 311 -321 70 -474 496 -479 712 -566 245 -290 563 -677 67 -483
		823 -389 957 -89 490 -903 366 -518 879 -981 569 -550 880 -711 833 -45 225 -479 724 -705
		651 -568 552 -976 748 -314 456 -655 450 -965 314 -449 432 -333 264 -126 412 -797 644 -249
		606 -847 448 -574 713 -592 708 -216 110 -170 138 -993 682 -310 969 -934 997 -424 722 -454
		460 -885 607 -92 458 -894 500 -751 322 -610 80 -364 839 -489 303 -425 638 -285 222 -282
		466 -917 275 -785 394 -243 851 -390 334 -572 936 -874 688 -671 34 -771 565 -534 521 -758
		144 -559 607 -306 930 -696 269 -708 589 -953 11 -877 964 -737 661 -430 506 -512 180 -828
		935 -449 259 -283 554 -29 817 -430 63 -147 927 -880 357 -239 65 -313 225 -925 579 -455
		447 -767 201 -667 11 -148 884 -663 976 -405 526 -911 147 -216 373 -593 755 -556 837 -183
		591 -763 62 -766 2 -997 78 -777 921 -499 679 -526 266 -121 860 -723 973 -976 385 -949
		429 -860 859 -718 76 -514 311 -321 70 -474 496 -479 712 -566 245 -290 563 -677 67 -483
		823 -389 957 -89 490 -903 366 -518 879 -981 569 -550 880 -711 833 -45 225 -479 724 -705
		935 -449 259 -283 554 -29 817 -430 63 -147 927 -880 357 -239 65 -313 225 -925 579 -455
		447 -767 201 -667 11 -148 884 -663 976 -405 526 -911 147 -216 373 -593 755 -556 837 -183
		591 -763 62 -766 2 -997 78 -777 921 -499 679 -526 266 -121 860 -723 973 -976 385 -949
		429 -860 859 -718 76 -514 311 -321 70 -474 496 -479 712 -566 245 -290 563 -677 67 -483
		823 -389 957 -89 490 -903 366 -518 879 -981 569 -550 880 -711 833 -45 225 -479 724 -705
		651 -568 552 -976 748 -314 456 -655 450 -965 314 -449 432 -333 264 -126 412 -797 644 -249
		606 -847 448 -574 713 -592 708 -216 110 -170 138 -993 682 -310 969 -934 997 -424 722 -454
		460 -885 607 -92 458 -894 500 -751 322 -610 80 -364 839 -489 303 -425 638 -285 222 -282
		466 -917 275 -785 394 -243 851 -390 334 -572 936 -874 688 -671 34 -771 565 -534 521 -758
		144 -559 607 -306 930 -696 269 -708 589 -953 11 -877 964 -737 661 -430 506 -512 180 -828
		651 -568 552 -976 748 -314 456 -655 450 -965 314 -449 432 -333 264 -126 412 -797 644 -249
		606 -847 448 -574 713 -592 708 -216 110 -170 138 -993 682 -310 969 -934 997 -424 722 -454
		460 -885 607 -92 458 -894 500 -751 322 -610 80 -364 839 -489 303 -425 638 -285 222 -282
		466 -917 275 -785 394 -243 851 -390 334 -572 936 -874 688 -671 34 -771 565 -534 521 -758
		144 -559 607 -306 930 -696 269 -708 589 -953 11 -877 964 -737 661 -430 506 -512 180 -828
		935 -449 259 -283 554 -29 817 -430 63 -147 927 -880 357 -239 65 -313 225 -925 579 -455
		447 -767 201 -667 11 -148 884 -663 976 -405 526 -911 147 -216 373 -593 755 -556 837 -183
		591 -763 62 -766 2 -997 78 -777 921 -499 679 -526 266 -121 860 -723 973 -976 385 -949
		429 -860 859 -718 76 -514 311 -321 70 -474 496 -479 712 -566 245 -290 563 -677 67 -483
		823 -389 957 -89 490 -903 366 -518 879 -981 569 -550 880 -711 833 -45 225 -479 724 -705
		651 -568 552 -976 748 -314 456 -655 450 -965 314 -449 432 -333 264 -126 412 -797 644 -249
		606 -847 448 -574 713 -592 708 -216 110 -170 138 -993 682 -310 969 -934 997 -424 722 -454
		460 -885 607 -92 458 -894 500 -751 322 -610 80 -364 839 -489 303 -425 638 -285 222 -282
		466 -917 275 -785 394 -243 851 -390 334 -572 936 -874 688 -671 34 -771 565 -534 521 -758
		144 -559 607 -306 930 -696 269 -708 589 -953 11 -877 964 -737 661 -430 506 -512 180 -828
		935 -449 259 -283 554 -29 817 -430 63 -147 927 -880 357 -239 65 -313 225 -925 579 -455
		447 -767 201 -667 11 -148 884 -663 976 -405 526 -911 147 -216 373 -593 755 -556 837 -183
		591 -763 62 -766 2 -997 78 -777 921 -499 679 -526 266 -121 860 -723 973 -976 385 -949
		429 -860 859 -718 76 -514 311 -321 70 -474 496 -479 712 -566 245 -290 563 -677 67 -483
		823 -389 957 -89 490 -903 366 -518 879 -981 569 -550 880 -711 833 -45 225 -479 724 -705
		935 -449 259 -283 554 -29 817 -430 63 -147 927 -880 357 -239 65 -313 225 -925 579 -455
		447 -767 201 -667 11 -148 884 -663 976 -405 526 -911 147 -216 373 -593 755 -556 837 -183
		591 -763 62 -766 2 -997 78 -777 921 -499 679 -526 266 -121 860 -723 973 -976 385 -949
		429 -860 859 -718 76 -514 311 -321 70 -474 496 -479 712 -566 245 -290 563 -677 67 -483
		823 -389 957 -89 490 -903 366 -518 879 -981 569 -550 880 -711 833 -45 225 -479 724 -705
		651 -568 552 -976 748 -314 456 -655 450 -965 314 -449 432 -333 264 -126 412 -797 644 -249
		606 -847 448 -574 713 -592 708 -216 110 -170 138 -993 682 -310 969 -934 997 -424 722 -454
		460 -885 607 -92 458 -894 500 -751 322 -610 80 -364 839 -489 303 -425 638 -285 222 -282
		466 -917 275 -785 394 -243 851 -390 334 -572 936 -874 688 -671 34 -771 565 -534 521 -758
		144 -559 607 -306 930 -696 269 -708 589 -953 11 -877 964 -737 661 -430 506 -512 180 -828
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X
		X X X X X X X X X X X X X X X X X X X X"
	);

}

