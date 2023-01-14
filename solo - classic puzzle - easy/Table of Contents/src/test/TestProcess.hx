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
				Main.process( ip.lengthOfLine, ip.entries ).should.be( testResult );
			});
			it( "Chapters", {
				final ip = chapters;
				Main.process( ip.lengthOfLine, ip.entries ).should.be( chaptersResult );
			});
			it( "Hell of subsections", {
				final ip = hellOfSubsections;
				Main.process( ip.lengthOfLine, ip.entries ).should.be( hellOfSubsectionsResult );
			});
			it( "World book", {
				final ip = worldBook;
				Main.process( ip.lengthOfLine, ip.entries ).should.be( worldBookResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final lengthOfLine = parseInt( lines[0] );
		final n = parseInt( lines[1] );
		final entries = lines.slice( 2 );
				
		return { lengthOfLine: lengthOfLine, entries: entries };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test = parseInput(
	"40
	5
	Title1 4
	>Subtitle1 5
	>>Subsubtitle1 5
	>Subtitle2 6
	Title2 10" );

	final testResult = parseResult(
"1 Title1...............................4
    1 Subtitle1........................5
        1 Subsubtitle1.................5
    2 Subtitle2........................6
2 Title2..............................10" );

	final chapters = parseInput(
"30
3
One 5
Two 50
AppendixA 100" );

	final chaptersResult = parseResult(
"1 One........................5
2 Two.......................50
3 AppendixA................100" );

	final hellOfSubsections = parseInput(
"45
18
A 1
>AA 5
>>AAA 8
>>>AAAA 8
>>>>AAAAA 9
>>AAB 10
>>>AABA 12
>>>>AABAA 12
>>>>AABAB 13
>>>>>AABABA 14
>AB 15
>>ABA 20
>>ABB 25
>>>ABBA 26
>>>>ABBAA 27
>>>>>ABBAAA 28
>AC 29
B 5005" );

	final hellOfSubsectionsResult = parseResult(
"1 A.........................................1
    1 AA....................................5
        1 AAA...............................8
            1 AAAA..........................8
                1 AAAAA.....................9
        2 AAB..............................10
            1 AABA.........................12
                1 AABAA....................12
                2 AABAB....................13
                    1 AABABA...............14
    2 AB...................................15
        1 ABA..............................20
        2 ABB..............................25
            1 ABBA.........................26
                1 ABBAA....................27
                    1 ABBAAA...............28
    3 AC...................................29
2 B......................................5005" );

	final worldBook = parseInput(
"50
13
Sudamerica 1
>Argentina 5
>>BuenosAires 8
>>Cordoba 10
>Brasil 15
>>SaoPaulo 20
>>Fortaleza 25
Asia 30
>Japan 32
>>Yokohama 35
>>Tokio 40
>Iran 42
>>Teheran 45" );

	final worldBookResult = parseResult(
"1 Sudamerica.....................................1
    1 Argentina..................................5
        1 BuenosAires............................8
        2 Cordoba...............................10
    2 Brasil....................................15
        1 SaoPaulo..............................20
        2 Fortaleza.............................25
2 Asia..........................................30
    1 Japan.....................................32
        1 Yokohama..............................35
        2 Tokio.................................40
    2 Iran......................................42
        1 Teheran...............................45" );
}
