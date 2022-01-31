package test;

import Main.charCodeMap;
import Main.process;
import Std.parseInt;

using Converter;
using Lambda;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {

			final charCodeMap = [for( i in 0...Main.ALPHABET.length ) i => Main.ALPHABET.charAt( i )];
			var interpreter:Interpreter;
			
			beforeEach({
				interpreter = new Interpreter( Main.NUM_ZONES, Main.ALPHABET.length );
			});

			it( "AZ", {
				final phrase = "AZ";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Sample 1", {
				final phrase = "MINAS";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Short spell", {
				final phrase = "UMNE TALMAR RAHTAINE NIXENEN UMIR";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "One letter x15", {
				final phrase = "OOOOOOOOOOOOOOO";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Close letters", {
				final phrase = "BABCDEDCBABCDCB";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Edge of the alphabet", {
				final phrase = "ZAZYA YAZ";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "One letter x31", {
				final phrase = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Two letter word x20", {
				final phrase = "NONONONONONONONONONONONONONONONONONONONO";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Far away letters", {
				final phrase = "GUZ MUG ZOG GUMMOG ZUMGUM ZUM MOZMOZ MOG ZOGMOG GUZMUGGUM";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "One letter x53 + one letter x28", {
				final phrase = "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "One letter x70", {
				final phrase = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Ten letter word x8", {
				final phrase = "GAAVOOOLLUGAAVOOOLLUGAAVOOOLLUGAAVOOOLLUGAAVOOOLLUGAAVOOOLLUGAAVOOOLLUGAAVOOOLLU";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Medium spell", {
				final phrase = "O OROFARNE LASSEMISTA CARNIMIRIE O ROWAN FAIR UPON YOUR HAIR HOW WHITE THE BLOSSOM LAY";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Seven letter word x26", {
				final phrase = "ALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG BALROG B";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Long random sequence of 4 letters", {
				final phrase = "OYLO Y OOOYYY LLLYOOYY O YO YLOO O OLY YL OY L YY L YOO LYL YYYOOYLOL L Y O YYYLLOY O L YYYOOYLOL YOLOLOY";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Incremental sequence of 18 letters", {
				final phrase = "TUVWXYZ ABCDEFGHIJ";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Entire alphabet x11 separated by one letter", {
				final phrase = "ABCDEFGHIJKLMNOPQRSTUVWXYZAABCDEFGHIJKLMNOPQRSTUVWXYZAABCDEFGHIJKLMNOPQRSTUVWXYZAABCDEFGHIJKLMNOPQRSTUVWXYZAABCDEFGHIJKLMNOPQRSTUVWXYZAABCDEFGHIJKLMNOPQRSTUVWXYZAABCDEFGHIJKLMNOPQRSTUVWXYZAABCDEFGHIJKLMNOPQRSTUVWXYZAABCDEFGHIJKLMNOPQRSTUVWXYZAABCDEFGHIJKLMNOPQRSTUVWXYZAABCDEFGHIJKLMNOPQRSTUVWXYZA";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "One same letter + a random letter x32", {
				final phrase = "OROZOLOKOTONOFOGOMOJOHOFOTOLOPO ODOYOWOAOZO OPOJOTO OROXOVOXO OC";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Incremental space separated sequence", {
				final phrase = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Pattern followed by other pattern", {
				final phrase = "FIFOFIFOFIFOFIFOFIFOFIFOFIFOFIFOFIFOFIFOFIFOFIFO FUM FUM FUM FUM FUM FUM FUM FUM FUM FUM FUM FUM FUM FUM FUM";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Pattern followed by random sequence of two letters", {
				final phrase = "GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY GY HIJIHIJIJIJIHIHIHIJIHIJIHIJIJIJIHHHIJIJHIHH";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Two patterns repeated randomly", {
				final phrase = "MELLON MORIAMELLON MORIAMORIAMORIAMELLON MELLON MELLON MORIAMORIAMELLON MELLON MORIA";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Pattern followed by incremental sequence", {
				final phrase = "ZAZAZAZAZAZAZAZAZAZAZAZAZAZAZAZAZAZAZAZACEGIKMOQSUWY BDFHJLNPRTVXZACEGIKMOQSUWY BDFHJLNPRTVXZA";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
			it( "Long spell", {
				final phrase = "THREE RINGS FOR THE ELVEN KINGS UNDER THE SKY SEVEN FOR THE DWARF LORDS IN THEIR HALLS OF STONE NINE FOR MORTAL MEN DOOMED TO DIE ONE FOR THE DARK LORD ON HIS DARK THRONEIN THE LAND OF MORDOR WHERE THE SHADOWS LIE ONE RING TO RULE THEM ALL ONE RING TO FIND THEM ONE RING TO BRING THEM ALL AND IN THE DARKNESS BIND THEM IN THE LAND OF MORDOR WHERE THE SHADOWS LIE";
				interpreter.execute( Main.process( phrase ).map( s -> s.charCodeAt( 0 )) ).combine( charCodeMap ).should.be( phrase );
			});
			
		});
	}
}

