package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Example", {
				final ip = example;
				Main.process( ip.maxClients, ip.clients ).should.be( exampleResult ); });
			it( "Slow Start", {
				final ip = slowStart;
				Main.process( ip.maxClients, ip.clients ).should.be( slowStartResult ); });
			it( "Medium", {
				final ip = medium;
				Main.process( ip.maxClients, ip.clients ).should.be( mediumResult ); });
			it( "Lot of services", {
				final ip = lotOfServices;
				Main.process( ip.maxClients, ip.clients ).should.be( lotOfServicesResult ); });
			it( "One service", {
				final ip = oneService;
				Main.process( ip.maxClients, ip.clients ).should.be( oneServiceResult ); });
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final inputs = lines[0].split(' ');
		final s = parseInt( inputs[0] );
		final m = parseInt( inputs[1] );
		final inputs = lines[1].split(' ');
		final maxClients = [for( i in 0...s ) parseInt( inputs[i] )];
		final clients = [for( i in 0...m ){
			final inputs = lines[i + 2].split(' ');
			[for( j in 0...s ) parseInt( inputs[j] )];
		}];	
		
		return { maxClients: maxClients, clients: clients };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final example = parseInput(
		"4 3
		5 10 4 3
		20 5 10 7
		25 3 14 16
		15 4 20 10"
	);
	
	final exampleResult = parseResult(
		"4 1 3 3
		1 0 1 3
		-2 0 1 -2"
	);
	
	final slowStart = parseInput(
		"5 5
		8 10 5 47 20
		0 0 0 0 0
		1 2 1 1 2
		4 5 4 7 8
		10 15 30 40 50
		20 40 5 60 70"
	);
	
	final slowStartResult = parseResult(
		"0 0 0 0 0
		1 1 1 1 1
		0 0 0 0 0
		1 1 5 0 2
		1 2 -5 1 1"
	);

	final medium = parseInput(
		"10 10
		72 120 782 55 682 962 604 547 900 695
		346 697 471 901 520 294 346 935 928 274
		456 281 789 625 459 952 360 830 183 191
		519 653 110 67 111 293 510 168 79 901
		72 120 782 55 682 962 604 547 900 695
		785 38 768 62 304 204 924 334 143 53
		722 9 133 388 678 547 552 742 935 800
		697 664 666 404 277 924 363 224 909 896
		281 849 239 954 403 73 216 264 632 270
		976 481 651 700 315 445 747 685 32 924
		116 512 554 651 643 772 246 259 874 349"
	);
	
	final mediumResult = parseResult(
		"5 6 1 17 1 1 1 2 2 1
		2 -3 1 -5 0 0 0 0 -1 0
		1 3 -1 -10 0 0 0 -1 0 1
		-7 -5 0 -1 0 0 0 0 0 -1
		10 0 0 1 0 0 1 0 0 0
		0 0 0 6 0 0 -1 1 1 1
		-1 5 0 0 0 0 0 -1 0 0
		-6 2 0 10 0 0 0 0 -1 -1
		10 -3 0 -5 0 0 1 1 0 1
		-12 0 0 -1 0 0 -1 -1 0 -1"
	);

	final lotOfServices = parseInput(
		"50 7
		63 130 269 91 264 95 37 91 103 81 249 182 223 50 91 270 80 124 126 94 40 28 238 245 203 65 263 224 127 52 197 226 15 154 92 288 29 236 14 20 226 253 263 135 64 149 92 61 269 272
		654 487 189 116 761 928 879 775 452 866 316 476 353 689 837 177 194 231 766 298 12 339 667 260 530 883 289 571 68 836 996 950 488 832 847 305 290 413 412 255 566 166 673 138 166 903 317 391 194 92
		184 606 957 374 50 397 692 833 623 330 676 164 546 94 609 299 765 651 55 178 830 157 632 816 68 563 885 346 684 406 293 240 655 549 75 665 916 781 8 505 326 36 160 478 396 201 404 164 46 496
		642 564 35 321 914 537 652 538 92 245 274 384 194 898 563 122 80 458 850 235 772 619 674 718 988 917 40 386 456 602 32 362 986 251 649 750 825 379 634 87 689 162 764 92 553 300 649 98 476 434
		575 201 5 263 988 446 593 195 342 603 701 951 447 7 592 512 129 932 860 235 142 220 978 174 206 494 22 138 752 337 677 265 815 423 640 289 387 309 745 473 166 545 830 265 160 452 729 63 347 433
		862 106 84 218 706 277 746 772 564 659 654 497 848 892 868 591 625 737 92 95 764 42 137 644 194 335 355 134 93 772 216 415 277 692 121 602 163 442 105 551 358 434 863 506 575 611 993 660 852 799
		694 794 560 222 477 350 279 72 214 465 807 882 169 846 771 85 767 75 845 722 891 690 807 116 928 279 693 386 294 857 31 869 462 765 740 473 179 649 480 433 592 410 174 483 843 498 129 32 719 538
		312 135 687 347 863 412 653 247 328 91 749 494 497 426 617 416 613 201 600 42 443 250 7 484 937 307 908 873 685 300 287 866 167 868 986 978 503 281 312 284 126 191 589 181 108 194 914 672 121 900"
	);
	
	final lotOfServicesResult = parseResult(
		"11 4 1 2 3 10 24 9 5 11 2 3 2 14 10 1 3 2 7 4 1 13 3 2 3 14 2 3 1 17 6 5 33 6 10 2 10 2 30 13 3 1 3 2 3 7 4 7 1 1
		-8 1 3 3 -2 -5 -5 1 2 -6 1 -2 1 -12 -3 1 7 4 -6 -2 20 -7 0 2 -2 -5 2 -1 5 -9 -4 -3 11 -2 -9 1 22 2 -29 13 -1 0 -2 2 4 -5 1 -4 0 1
		8 0 -3 -1 3 1 -1 -4 -6 -1 -1 2 -2 16 0 -1 -9 -2 6 1 -1 17 0 -1 4 6 -3 0 -2 4 -1 0 22 -2 7 0 -3 -2 45 -21 2 0 2 -3 2 1 3 -1 1 0
		-1 -3 0 -1 0 -1 -1 -3 3 4 1 3 2 -17 0 1 1 4 0 0 -16 -15 2 -2 -3 -7 0 -1 2 -5 3 0 -11 1 -1 -1 -15 0 8 19 -3 2 1 1 -6 1 0 0 0 0
		4 -1 0 0 -1 -2 4 6 2 1 0 -3 1 17 3 1 6 -2 -6 -1 16 -6 -4 2 -1 -2 1 0 -5 8 -2 0 -36 2 -5 1 -8 0 -46 4 1 -1 0 2 6 1 3 9 2 1
		-2 6 2 0 -1 1 -13 -8 -3 -3 1 2 -3 -1 -1 -2 2 -5 6 6 3 23 3 -2 4 -1 1 1 2 2 -1 2 12 0 7 -1 1 1 27 -6 1 0 -3 0 5 -1 -9 -10 -1 -1
		-7 -5 0 1 2 1 10 2 1 -4 0 -2 2 -8 -2 1 -2 1 -2 -7 -11 -16 -3 1 0 0 1 2 3 -11 1 0 -19 1 2 2 11 -1 -12 -7 -2 -1 2 -2 -12 -2 8 11 -2 2"
	);

	final oneService = parseInput(
		"1 5
		3
		5
		9
		4
		3
		2"
	);
	
	final oneServiceResult = parseResult(
		"2
		1
		-1
		-1
		0"
	);

}

