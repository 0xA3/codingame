package test;

import Main.GrainPos;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Example", {
				final ip = example;
				Main.process( ip.w, ip.h, ip.grainPositions ).should.be( exampleResult );
			});
			it( "Wall Hug", {
				final ip = wallHug;
				Main.process( ip.w, ip.h, ip.grainPositions ).should.be( wallHugResult );
			});
			it( "Single Pile", {
				final ip = singlePile;
				Main.process( ip.w, ip.h, ip.grainPositions ).should.be( singlePileResult );
			});
			it( "Close Fit", {
				final ip = closeFit;
				Main.process( ip.w, ip.h, ip.grainPositions ).should.be( closeFitResult );
			});
			it( "Fibo", {
				final ip = fibo;
				Main.process( ip.w, ip.h, ip.grainPositions ).should.be( fiboResult );
			});
			it( "Pop Culture", {
				final ip = popCulture;
				Main.process( ip.w, ip.h, ip.grainPositions ).should.be( popCultureResult );
			});
			it( "Chess - Italian opening", {
				final ip = chessItalianOpening;
				Main.process( ip.w, ip.h, ip.grainPositions ).should.be( chessItalianOpeningResult );
			});
			it( "Landscape", {
				final ip = landscape;
				Main.process( ip.w, ip.h, ip.grainPositions ).should.be( landscapeResult );
			});
			it( "Big Box", {
				final ip = bigBox;
				Main.process( ip.w, ip.h, ip.grainPositions ).should.be( bigBoxResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final inputs = lines[0].split(' ');
		final w = parseInt( inputs[0] );
		final h = parseInt( inputs[1] );
		final n = parseInt( lines[1] );
		final grainPositions:Array<GrainPos> = [for( i in 0...n ) {
			final inputs = lines[i + 2].split(' ');
			{ grain: inputs[0], pos: parseInt( inputs[1] ) }
		}];
		
		return { w: w, h: h, grainPositions: grainPositions };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final example = parseInput(
		"3 3
		4
		n 1
		e 1
		o 1
		A 1"
	);

	final exampleResult = parseResult(
		"|   |
		| A |
		|one|
		+---+"
	);

	final wallHug = parseInput(
		"4 4
		8
		S 0
		A 0
		l 0
		N 0
		o 0
		I 0
		D 0
		v 0"
	);

	final wallHugResult = parseResult(
		"|    |
		|I   |
		|lov |
		|SAND|
		+----+"
	);

	final singlePile = parseInput(
		"7 6
		16
		g 3
		G 3
		g 3
		g 3
		G 3
		G 3
		g 3
		g 3
		g 3
		G 3
		G 3
		G 3
		g 3
		G 3
		g 3
		G 3"
	);

	final singlePileResult = parseResult(
		"|       |
		|       |
		|   G   |
		|  Ggg  |
		| GGggG |
		|GGGgggg|
		+-------+"
	);

	final closeFit = parseInput(
		"2 2
		4
		S 0
		T 1
		u 1
		J 1"
	);

	final closeFitResult = parseResult(
		"|Ju|
		|ST|
		+--+"
	);

	final fibo = parseInput(
		"50 5
		88
		F 0
		i 2
		B 5
		B 5
		o 8
		o 8
		o 8
		N 13
		N 13
		N 13
		N 13
		N 13
		a 18
		a 18
		a 18
		a 18
		a 18
		a 18
		a 18
		a 18
		C 25
		C 25
		C 25
		C 25
		C 25
		C 25
		C 25
		C 25
		C 25
		C 25
		C 25
		C 25
		C 25
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		c 34
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45
		I 45"
	);

	final fiboResult = parseResult(
		"|                                            III   |
		|                                  cc       IIIII  |
		|                        CC       cccc     IIIIIII |
		|             N   aaa   CCCC     cccccc   IIIIIIIII|
		|F i BB ooo NNNN aaaaa CCCCCCC ccccccccc IIIIIIIIII|
		+--------------------------------------------------+"
	);

	final popCulture = parseInput(
		"11 9
		69
		w 3
		w 3
		w 7
		w 7
		w 3
		w 7
		Z 3
		A 7
		w 5
		D 7
		L 6
		E 5
		b 0
		d 10
		w 0
		w 10
		H 0
		H 10
		x 0
		x 10
		x 3
		x 7
		m 3
		m 3
		m 3
		m 7
		m 7
		m 7
		q 10
		p 0
		m 0
		m 10
		m 5
		A 4
		A 10
		A 4
		A 10
		A 3
		A 9
		A 3
		A 9
		A 2
		A 8
		A 2
		A 8
		A 2
		A 8
		A 2
		A 8
		A 2
		A 8
		v 3
		v 7
		v 3
		v 7
		v 3
		v 7
		v 3
		v 5
		v 5
		A 4
		A 6
		A 4
		A 7
		A 5
		A 5
		A 5
		A 5
		A 5"
	);

	final popCultureResult = parseResult(
		"|     A     |
		|    AAA    |
		|   AAAAA   |
		|  AvvvvvA  |
		| AAAvvvAAA |
		|AAAAAvAAAAA|
		|pmmmmmmmmmq|
		|HxxZELDAxxH|
		|bwwwwwwwwwd|
		+-----------+"
	);

	final chessItalianOpening = parseInput(
		"8 8
		64
		R 0
		B 2
		K 4
		o 6
		N 0
		Q 2
		z 4
		R 6
		z 4
		P 4
		P 4
		o 4
		P 4
		P 5
		N 5
		z 4
		P 4
		P 5
		o 5
		o 5
		z 5
		z 5
		z 5
		o 6
		o 6
		z 6
		z 6
		o 6
		p 7
		P 7
		o 7
		o 7
		p 7
		o 7
		p 7
		r 7
		P 7
		z 7
		B 7
		z 7
		z 7
		p 7
		n 7
		o 6
		o 6
		o 6
		o 6
		o 6
		b 6
		z 5
		z 5
		n 5
		p 5
		k 5
		o 4
		o 4
		p 4
		q 4
		z 3
		p 3
		b 3
		p 2
		o 2
		r 1"
	);

	final chessItalianOpeningResult = parseResult(
		"|robqkbnr|
		|ppppoppp|
		|zonozozo|
		|ozozpzoz|
		|zoBoPozo|
		|ozozoNoz|
		|PPPPzPPP|
		|RNBQKzoR|
		+--------+"
	);

	final landscape = parseInput(
		"32 10
		192
		a 4
		a 4
		a 4
		a 4
		a 4
		a 4
		a 4
		a 4
		a 4
		a 4
		a 4
		a 4
		a 3
		a 3
		a 1
		a 6
		a 6
		a 8
		A 0
		A 2
		A 2
		A 4
		A 4
		A 5
		A 5
		A 7
		A 7
		A 9
		A 9
		A 10
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 20
		b 18
		b 18
		b 18
		b 18
		b 18
		b 18
		b 18
		b 18
		b 18
		b 18
		b 16
		b 16
		b 16
		b 16
		b 16
		b 22
		b 22
		b 22
		b 22
		b 22
		b 10
		b 10
		b 11
		b 11
		B 11
		b 15
		b 15
		b 15
		b 15
		b 14
		B 14
		b 17
		B 17
		B 16
		B 15
		B 14
		B 11
		B 19
		B 19
		B 18
		B 21
		B 21
		b 22
		b 22
		B 8
		B 8
		b 31
		b 31
		b 31
		b 31
		b 31
		b 29
		b 29
		B 31
		B 31
		b 30
		B 30
		b 28
		b 28
		b 27
		b 26
		b 26
		B 28
		B 28
		B 27
		b 22
		B 22
		b 23
		B 23
		B 24
		B 22
		c 3
		c 3
		c 3
		c 3
		c 3
		c 3
		c 3
		c 3
		c 3
		c 3
		c 3
		c 3
		c 3
		c 3
		c 3
		c 0
		c 9
		c 9
		c 9
		c 9
		c 5
		c 5
		c 5
		c 7
		c 7
		C 2
		C 2
		C 1
		C 4
		C 4
		C 4
		C 5
		C 5
		C 8
		C 8
		C 8
		C 11
		C 11
		d 30
		d 30
		d 30
		d 30
		d 30
		d 30
		d 30
		d 30
		d 30
		d 30
		d 30
		d 30
		d 30
		d 30
		d 30
		d 30
		D 30
		D 30
		D 30
		D 30
		D 30
		D 30"
	);

	final landscapeResult = parseResult(
		"|                                |
		|                              D |
		|                             DdD|
		|  CCCC                      Dddd|
		|CCccccCCCC       BBBBBB    Ddddd|
		|ccccccccccCCC BBBbbbbbbBBBDddddd|
		|ccccAAcccccBBBbbbbbbbbbbbbBBBddd|
		|ccAAaaAABBBbbbbbbbbbbbbbbbbbbBBB|
		|AAaaaaaaAAbbbbbbbbbbbbbbbbbbbbbb|
		|aaaaaaaaaaAAbbbbbbbbbbbbbbbbbbbb|
		+--------------------------------+"
	);

	final bigBox = parseInput(
		"30 15
		202
		W 10
		h 20
		e 10
		n 20
		f 10
		a 20
		l 10
		l 20
		i 10
		n 20
		g 10
		e 20
		a 10
		c 20
		h 10
		g 20
		r 10
		a 20
		i 10
		n 20
		f 10
		o 20
		l 10
		l 20
		o 10
		w 20
		s 10
		s 20
		i 10
		m 20
		p 10
		l 20
		e 10
		r 20
		u 10
		l 20
		e 10
		s 20
		I 10
		f 20
		t 10
		h 20
		e 10
		r 20
		e 10
		i 20
		s 10
		a 20
		n 10
		e 20
		m 10
		p 20
		t 10
		y 20
		s 10
		p 20
		a 10
		c 20
		e 10
		b 20
		e 10
		l 20
		l 10
		o 20
		w 10
		i 20
		t 10
		i 20
		t 10
		f 20
		a 10
		l 20
		l 10
		s 20
		d 10
		o 20
		w 10
		n 20
		I 10
		f 20
		i 10
		t 20
		i 10
		s 20
		a 10
		l 20
		o 10
		w 20
		e 10
		r 20
		c 10
		a 20
		s 10
		e 20
		c 10
		h 20
		a 10
		r 20
		a 10
		c 20
		t 10
		e 20
		r 10
		i 20
		t 10
		f 20
		i 10
		r 20
		s 10
		t 20
		t 10
		r 20
		i 10
		e 20
		s 10
		t 20
		o 10
		f 20
		a 10
		l 20
		l 10
		d 20
		o 10
		w 20
		n 10
		t 20
		o 10
		w 20
		a 10
		r 20
		d 10
		s 20
		t 10
		h 20
		e 10
		r 20
		i 10
		g 20
		h 10
		t 20
		I 10
		f 20
		i 10
		t 20
		i 10
		s 20
		a 10
		n 20
		u 10
		p 20
		p 10
		e 20
		r 10
		c 20
		a 10
		s 20
		e 10
		c 20
		h 10
		a 20
		r 10
		a 20
		c 10
		t 20
		e 10
		r 20
		i 10
		t 20
		f 10
		i 20
		r 10
		s 20
		t 10
		t 20
		r 10
		i 20
		e 10
		s 20
		t 10
		o 20
		f 10
		a 20
		l 10
		l 20
		d 10
		o 20
		w 10
		n 20
		t 10
		o 20
		w 10
		a 20
		r 10
		d 20
		s 10
		t 20
		h 10
		e 20
		l 10
		e 20
		f 10
		t 20"
	);

	final bigBoxResult = parseResult(
		"|                              |
		|                              |
		|                              |
		|                              |
		|                    e         |
		|          tt       tin        |
		|         euhw     dtfao       |
		|        ralded   arttscl      |
		|       tiactaal otgeafrsa     |
		|     friosairorfarrrftiwco    |
		|    lfIsctneitnphtwiebfetes   |
		|   hihietsptawaorlialfcncwpit |
		|  seitoweirlesdasoimalspordnte|
		| rcesaleshlgfutllrsgleolyshlss|
		|wrtiIeIoafWeiiemhwcahnnnrpleft|
		+------------------------------+"
	);

}
