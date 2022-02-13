package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Tiny picture, thin frame", {
				final ip = tinyPictureThinFrame;
				Main.process( ip.framePattern, ip.h, ip.w, ip.lines ).should.be( tinyPictureThinFrameResult );
			});
			it( "Small picture, thin frame", {
				final ip = smallPictureThinFrame;
				Main.process( ip.framePattern, ip.h, ip.w, ip.lines ).should.be( smallPictureThinFrameResult );
			});
			it( "Small picture, 2-character frame", {
				final ip = smallPicture2CharacterFrame;
				Main.process( ip.framePattern, ip.h, ip.w, ip.lines ).should.be( smallPicture2CharacterFrameResult );
			});
			it( "Medium picture, 3-character frame", {
				final ip = mediumPicture3CharacterFrame;
				Main.process( ip.framePattern, ip.h, ip.w, ip.lines ).should.be( mediumPicture3CharacterFrameResult );
			});
			it( "Some art", {
				final ip = someArt;
				Main.process( ip.framePattern, ip.h, ip.w, ip.lines ).should.be( someArtResult );
			});
		});
		
		describe( "Test process2", {
			
			it( "Tiny picture, thin frame", {
				final ip = tinyPictureThinFrame;
				Main.process2( ip.framePattern, ip.h, ip.w, ip.lines ).should.be( tinyPictureThinFrameResult );
			});
			it( "Small picture, thin frame", {
				final ip = smallPictureThinFrame;
				Main.process2( ip.framePattern, ip.h, ip.w, ip.lines ).should.be( smallPictureThinFrameResult );
			});
			it( "Small picture, 2-character frame", {
				final ip = smallPicture2CharacterFrame;
				Main.process2( ip.framePattern, ip.h, ip.w, ip.lines ).should.be( smallPicture2CharacterFrameResult );
			});
			it( "Medium picture, 3-character frame", {
				final ip = mediumPicture3CharacterFrame;
				Main.process2( ip.framePattern, ip.h, ip.w, ip.lines ).should.be( mediumPicture3CharacterFrameResult );
			});
			it( "Some art", {
				final ip = someArt;
				Main.process2( ip.framePattern, ip.h, ip.w, ip.lines ).should.be( someArtResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final framePattern = lines[0]; // the ASCII art pattern to use to frame the picture
		final inputs = lines[1].split(' ');
		final h = parseInt( inputs[0] ); // the height of the picture
		final w = parseInt( inputs[1] ); // the width  of the picture
			
		return { framePattern: framePattern, h: h, w: w, lines: lines.slice( 2 ) }
	}
	
	static function parseResult( input:String ) return input.replace( "\t", "" ).replace( "\r", "" );

	final tinyPictureThinFrame = parseInput(
		"#
		1 1
		x"
	);

	final tinyPictureThinFrameResult = parseResult(
		"#####
		#   #
		# x #
		#   #
		#####"
	);

	final smallPictureThinFrame = parseInput(
		"*
		1 4
		[ ]o"
	);

	final smallPictureThinFrameResult = parseResult(
		"********
		*      *
		* [ ]o *
		*      *
		********"
	);

	final smallPicture2CharacterFrame = parseInput(
		"**
		2 3
		 . 
		(_)"
	);

	final smallPicture2CharacterFrameResult = parseResult(
		"*********
		*********
		**     **
		**  .  **
		** (_) **
		**     **
		*********
		*********"
	);

	final mediumPicture3CharacterFrame = parseInput(
		"Oo:
		3 7
		   _o  
		 _< \\_ 
		(_)>(_)"
	);

	final mediumPicture3CharacterFrameResult = parseResult(
		"OOOOOOOOOOOOOOO
		OoooooooooooooO
		Oo:::::::::::oO
		Oo:         :oO
		Oo:    _o   :oO
		Oo:  _< \\_  :oO
		Oo: (_)>(_) :oO
		Oo:         :oO
		Oo:::::::::::oO
		OoooooooooooooO
		OOOOOOOOOOOOOOO"
	);

	final someArt = parseInput(
		"o
		5 17
		PLEASE DO NOT USE
		UNICODE IN THE   
		INPUT OR OUTPUT  
		                 
		OF A PUZZLE     /"
	);
	
	final someArtResult = parseResult(
		"ooooooooooooooooooooo
		o                   o
		o PLEASE DO NOT USE o
		o UNICODE IN THE    o
		o INPUT OR OUTPUT   o
		o                   o
		o OF A PUZZLE     / o
		o                   o
		ooooooooooooooooooooo"
	);
}

