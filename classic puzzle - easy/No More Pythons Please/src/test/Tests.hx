package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Easy (One Snake)", {
				final ip = easy;
				Main.process( ip.grid, ip.w, ip.h ).should.be( easyResult );
			});
			it( "Medium 1 (3 Snakes, One Pattern)", {
				final ip = medium1;
				Main.process( ip.grid, ip.w, ip.h ).should.be( medium1Result );
			});
			it( "Medium 2 (More than 1 large snake)", {
				final ip = medium2;
				Main.process( ip.grid, ip.w, ip.h ).should.be( medium2Result );
			});
			it( "Hard (One VERY large snake)", {
				final ip = hard;
				Main.process( ip.grid, ip.w, ip.h ).should.be( hardResult );
			});
			it( "Hard2 (One VERY large snake)", {
				final ip = hard2;
				Main.process( ip.grid, ip.w, ip.h ).should.be( hard2Result );
			});
			it( "Hard3 (One VERY large snake)", {
				final ip = hard3;
				Main.process( ip.grid, ip.w, ip.h ).should.be( hard3Result );
			});
			it( "Snake Madness (for Geeks)", {
				final ip = snakeMadness;
				Main.process( ip.grid, ip.w, ip.h ).should.be( snakeMadnessResult );
			});
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final h = parseInt( inputs[0] );
		final w = parseInt( inputs[1] );
		final grid = [for( i in 0...h ) lines[i + 1].split( '' )];
			
		return { w: w, h: h, grid: grid }
	}

	static function parseResult( input:String ) {
		return input.split( "\n" ).map( line -> line.trim()).join( "\n" );
	}

	static final easy = parseInput(
	"7 7
	.......
	.......
	.......
	<-----o
	.......
	.......
	......." );

	static final easyResult = parseResult(
	"7
	1" );

	static final medium1 = parseInput(
	"5 7
	*-----*
	|*---*|
	||*-*||
	|||.|||
	vov.ovo" );

	static final medium1Result = parseResult(
	"15
	1" );

	static final medium2 = parseInput(
	"6 10
	^o^o^o^o^o
	||||||||||
	||||||||||
	||||||||||
	||||||||||
	ovovovovov" );

	static final medium2Result = parseResult(
	"6
	10" );

	static final hard = parseInput(
	"16 16
	*--------------*
	|*------------*|
	||*----------*||
	|||*--------*|||
	||||*------*||||
	|||||*----*|||||
	||||||*--*||||||
	|||||||o.|||||||
	||||||||.|||||||
	|||||||*-*||||||
	||||||*---*|||||
	|||||*-----*||||
	||||*-------*|||
	|||*---------*||
	||*-----------*|
	v*-------------*" );

	static final hardResult = parseResult(
	"254
	1" );
	
	static final hard2 = parseInput(
	"16 16
	*--------------*
	|*------------*|
	||*----------*||
	|||*--------*|||
	||||*------*||||
	|||||*----*|||||
	||||||*--*||||||
	|||||||^.|||||||
	||||||||.|||||||
	|||||||*-*||||||
	||||||*---*|||||
	|||||*-----*||||
	||||*-------*|||
	|||*---------*||
	||*-----------*|
	o*-------------*" );
	
	static final hard2Result = parseResult(
	"254
	1" );
		
	static final hard3 = parseInput(
	"62 62
	*------------------------------------------------------------*
	|*----------------------------------------------------------*|
	||*--------------------------------------------------------*||
	|||*------------------------------------------------------*|||
	||||*----------------------------------------------------*||||
	|||||*--------------------------------------------------*|||||
	||||||*------------------------------------------------*||||||
	|||||||*----------------------------------------------*|||||||
	||||||||*--------------------------------------------*||||||||
	|||||||||*------------------------------------------*|||||||||
	||||||||||*----------------------------------------*||||||||||
	|||||||||||*--------------------------------------*|||||||||||
	||||||||||||*------------------------------------*||||||||||||
	|||||||||||||*----------------------------------*|||||||||||||
	||||||||||||||*--------------------------------*||||||||||||||
	|||||||||||||||*------------------------------*|||||||||||||||
	||||||||||||||||*----------------------------*||||||||||||||||
	|||||||||||||||||*--------------------------*|||||||||||||||||
	||||||||||||||||||*------------------------*||||||||||||||||||
	|||||||||||||||||||*----------------------*|||||||||||||||||||
	||||||||||||||||||||*--------------------*||||||||||||||||||||
	|||||||||||||||||||||*------------------*|||||||||||||||||||||
	||||||||||||||||||||||*----------------*||||||||||||||||||||||
	|||||||||||||||||||||||*--------------*|||||||||||||||||||||||
	||||||||||||||||||||||||*------------*||||||||||||||||||||||||
	|||||||||||||||||||||||||*----------*|||||||||||||||||||||||||
	||||||||||||||||||||||||||*--------*||||||||||||||||||||||||||
	|||||||||||||||||||||||||||*------*|||||||||||||||||||||||||||
	||||||||||||||||||||||||||||*----*||||||||||||||||||||||||||||
	|||||||||||||||||||||||||||||*--*|||||||||||||||||||||||||||||
	||||||||||||||||||||||||||||||^.||||||||||||||||||||||||||||||
	|||||||||||||||||||||||||||||||.||||||||||||||||||||||||||||||
	||||||||||||||||||||||||||||||*-*|||||||||||||||||||||||||||||
	|||||||||||||||||||||||||||||*---*||||||||||||||||||||||||||||
	||||||||||||||||||||||||||||*-----*|||||||||||||||||||||||||||
	|||||||||||||||||||||||||||*-------*||||||||||||||||||||||||||
	||||||||||||||||||||||||||*---------*|||||||||||||||||||||||||
	|||||||||||||||||||||||||*-----------*||||||||||||||||||||||||
	||||||||||||||||||||||||*-------------*|||||||||||||||||||||||
	|||||||||||||||||||||||*---------------*||||||||||||||||||||||
	||||||||||||||||||||||*-----------------*|||||||||||||||||||||
	|||||||||||||||||||||*-------------------*||||||||||||||||||||
	||||||||||||||||||||*---------------------*|||||||||||||||||||
	|||||||||||||||||||*-----------------------*||||||||||||||||||
	||||||||||||||||||*-------------------------*|||||||||||||||||
	|||||||||||||||||*---------------------------*||||||||||||||||
	||||||||||||||||*-----------------------------*|||||||||||||||
	|||||||||||||||*-------------------------------*||||||||||||||
	||||||||||||||*---------------------------------*|||||||||||||
	|||||||||||||*-----------------------------------*||||||||||||
	||||||||||||*-------------------------------------*|||||||||||
	|||||||||||*---------------------------------------*||||||||||
	||||||||||*-----------------------------------------*|||||||||
	|||||||||*-------------------------------------------*||||||||
	||||||||*---------------------------------------------*|||||||
	|||||||*-----------------------------------------------*||||||
	||||||*-------------------------------------------------*|||||
	|||||*---------------------------------------------------*||||
	||||*-----------------------------------------------------*|||
	|||*-------------------------------------------------------*||
	||*---------------------------------------------------------*|
	o*-----------------------------------------------------------*" );
	
	static final hard3Result = parseResult(
	"3842
	1" );
		
	static final snakeMadness = parseInput(
	"80 80
	................................................................................
	................................................................................
	...o....................................................o.......................
	...|....................................................|.......................
	...|....................................................|.......................
	...|....................................................|.......................
	...|.................o->................................|.......................
	...|....................................................|.......................
	...*----->..............................................|.......................
	........................................................|.......................
	........................................................|.......................
	.................................................o----->|.......................
	........................................................v.......................
	................................................................................
	................................................................................
	o-----------------------------------*...........................................
	............................o------*|...........................................
	......................^............||...........................................
	......................|............||...........................................
	....................o-*............||...........................................
	...................................||...........................................
	...................................||...........................................
	...................................||...........................................
	...................................||...........................................
	...................................||...........................................
	...................................||...........................................
	...................................v|...........................................
	....................................|...........................................
	....................................|............................^^^^^^.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|.................*-----*....||||||.........
	....................................|.................|*---*|....||||||.........
	....................................|.................||o..||....||||||.........
	....................................|.................|||..||....||||||.........
	....................................|.................v|*--*|....||||||.........
	....................................|..................*----*....||||||.........
	....................................|............................||||||.........
	....................................|............................||||||.........
	....................................|............................o|||||.........
	................<-----------------o.|.............................|||||.........
	....................................|.............................|||||.........
	..................................o.|.............................|||||.........
	^.................................|.|.............................||o||.........
	|.................................|.|.............................||.||.........
	|.................................|.|.*------------*..............||.||.........
	|.................................|.|.|*---------->|..............||.||.........
	|..........o--------------------->|.|.||...........|..............||.||.........
	|....o--------------------------->|.|.||...........|..............||.||.........
	|..o----------------------------->|.|.||...........|..............o|.||.........
	*--------------------------------o|.|.||...........|...............|.||.........
	..................................|.|.||...........|...............|.||.........
	..................................|.|.||...........|...............|.||.........
	..................................|.|.||...........|...............|.||.........
	..................................|.|.||...........|...............|.||.........
	..................................|.|.v|...........|...............|.o|.........
	..................................|.*--*...........|...............|..|.........
	..................................*----------------*...............o..|.........
	.............................................................o--------*........." );

	static final snakeMadnessResult = parseResult(
	"123
	1" );
}

