package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "ABC", {
				final ip = abc;
				Main.process( ip.characters, ip.message ).should.be( "100100" );
			});
			it( "Alphabet", {
				final ip = alphabet;
				Main.process( ip.characters, ip.message ).should.be( "07041212152415181203" );
			});
			it( "Reverse Alphabet", {
				final ip = reverseAlphabet;
				Main.process( ip.characters, ip.message ).should.be( "42513232230323203252" );
			});
			it( "Serious Encode", {
				final ip = seriousEncode;
				Main.process( ip.characters, ip.message ).should.be( "323343523141542234" );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final rows = parseInt( lines[0] );
		final characters = [for( i in 0...rows) lines[i + 1].split(" ")];
		final message = lines[rows + 1];
			
		return { characters: characters, message: message };
	}
	
	final abc = parseInput(
		"2
		A B
		C D
		CBA"
	);

	final alphabet = parseInput(
		"3
		A B C D E F G H I
		J K L M N O P Q R
		S T U V W X Y Z
		HELLOWORLD"
	);

	final reverseAlphabet = parseInput(
		"7
		Z Y X W
		V U T S
		R Q P O
		N M L K
		J I H G
		F E D C
		B A
		HELLOWORLD"
	);

	final seriousEncode = parseInput(
		"6
		H U P N I
		J W C F T
		B Z A Q Y
		L O S X R
		M E V D G
		K # @ ! ?
		SXD@OE?AR"
	);

}

