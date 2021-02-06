package test;

import haxe.Int64;
import Main;
import Std.parseInt;
import Std.parseFloat;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test dms to deg", {
			
			it( "N450915", { Main.dmsToDeg( "N450915" ).should.beCloseTo( 45.154166666667 ); });
			it( "E0125549", { Main.dmsToDeg( "E0125549" ).should.beCloseTo( 12.930277777778 ); });
			it( "N373800", { Main.dmsToDeg( "N373800" ).should.beCloseTo( 37.633333333333 ); });
			it( "E0230800", { Main.dmsToDeg( "E0230800" ).should.beCloseTo( 23.133333333333 ); });
			it( "N513025", { Main.dmsToDeg( "N513025" ).should.beCloseTo( 51.506944444444 ); });
			it( "W0000542", { Main.dmsToDeg( "W0000542" ).should.beCloseTo( -0.095 ); });
			it( "N404532", { Main.dmsToDeg( "N404532" ).should.beCloseTo( 40.758888888889 ); });
			it( "W0735906", { Main.dmsToDeg( "W0735906" ).should.beCloseTo( -73.985 ); });

		});

		describe( "Test getDistance", {

			final l1 = Main.createLocation( "N450915 E0125549" );

			it( "Travel point #3 to Epidaurus", {
				final l2 = Main.createLocation( "N373800 E0230800" );
				Main.getDistance( l1, l2 ).should.be( 1191 );
			});

			it( "Travel point #3 to The_Globe_Theatre", {
				final l2 = Main.createLocation( "N513025 W0000542" );
				Main.getDistance( l1, l2 ).should.be( 1191 );
			});

			it( "Travel point #3 to Broadway", {
				final l2 = Main.createLocation( "N404532 W0735906" );
				Main.getDistance( l1, l2 ).should.be( 6733 );
			});

		});

		describe( "Test process", {
			
			it( "Dualism", {
				final g = dualism;
				Main.process( g.capitalNameGeolocs, g.messages, g.travelGeolocs ).should.be( dualismResult );
			});
			
			it( "Border travels in TriTheatreLand", {
				final g = borderTravelsInTriTheatreLand;
				Main.process( g.capitalNameGeolocs, g.messages, g.travelGeolocs ).should.be( borderTravelsInTriTheatreLandResult );
			});
			
			it( "CodinGame World", {
				final g = codinGameWorld;
				Main.process( g.capitalNameGeolocs, g.messages, g.travelGeolocs ).should.be( codinGameWorldResult );
			});
			
			it( "Lonely Planet", {
				final g = lonelyPlanet;
				Main.process( g.capitalNameGeolocs, g.messages, g.travelGeolocs ).should.be( lonelyPlanetResult );
			});
			
			it( "Roundtrip in Europe", {
				final g = roundtripInEurope;
				Main.process( g.capitalNameGeolocs, g.messages, g.travelGeolocs ).should.be( roundtripInEuropeResult );
			});
			
			it( "Pole to Pole with Michael Palin", {
				final g = poleToPoleWithMichaelPalin;
				Main.process( g.capitalNameGeolocs, g.messages, g.travelGeolocs ).should.be( poleToPoleWithMichaelPalinResult );
			});
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final n = parseInt( lines[0] ); // number of capitals
		final m = parseInt( lines[1] ); // number of geolocations for which to find the closest capital
		final capitalNameGeolocs = [for( i in 0...n ) lines[i + 2]];
		final messages = [for( i in 0...n ) lines[i + 2 + n]];
		final travelGeolocs = [for( i in 0...m ) lines[i + 2 + 2 * n]];

		return { capitalNameGeolocs: capitalNameGeolocs, messages: messages, travelGeolocs: travelGeolocs };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final dualism = parseInput(
		"2
		2
		Wien N481200 E0162100
		Budapest N472933 E0190305
		Servus, Welt!
		Szia, Vilag!
		N472059 E0183005
		N481330 E0172100" );
	
	final dualismResult = parseResult(
		"Szia, Vilag!
		Servus, Welt!" );
	
	final borderTravelsInTriTheatreLand = parseInput(
		"3
		9
		Epidaurus N373800 E0230800
		The_Globe_Theatre N513025 W0000542
		Broadway N404532 W0735906
		Chairete!
		Haile to thee, Noble Master!
		Hello, Dolly!
		N373800 E0230800
		N513025 W0000542
		N404532 W0735906
		N450915 E0125549
		N505540 W0235856
		N522335 W0411458
		N450815 E0125649
		N451015 E0125449
		N512335 W0511458" );
	
	final borderTravelsInTriTheatreLandResult = parseResult(
		"Chairete!
		Haile to thee, Noble Master!
		Hello, Dolly!
		Chairete! Haile to thee, Noble Master!
		Haile to thee, Noble Master!
		Haile to thee, Noble Master! Hello, Dolly!
		Chairete!
		Haile to thee, Noble Master!
		Hello, Dolly!" );
	
	final codinGameWorld = parseInput(
		'28
		7
		Bash_land N000000 E0000000
		Befunge_land N010000 E0000000
		C#_land N020000 E0000000
		C_land N030000 E0000000
		C++_land N040000 E0000000
		C64_Assembly_land N050000 E0000000
		C64_BASIC_land N060000 E0000000
		Clojure_land N070000 E0000000
		CSS_land N080000 E0000000
		Dart_land N090000 E0000000
		F#_land N100000 E0000000
		Go_land N110000 E0000000
		Groovy_land N120000 E0000000
		Haskell_land N130000 E0000000
		Java_land N140000 E0000000
		Javascript_land N150000 E0000000
		Kotlin_land N160000 E0000000
		Lua_land N170000 E0000000
		OCaml_land N180000 E0000000
		Pascal_land N190000 E0000000
		Perl_land N200000 E0000000
		PHP_land N210000 E0000000
		PowerShell_land N220000 E0000000
		Python_land N230000 E0000000
		Ruby_land N240000 E0000000
		Rust_land N250000 E0000000
		Scala_land N260000 E0000000
		Swift_land N270000 E0000000
		echo Hello World
		>"dlroW olleH",,,,,,,,,,,@
		class HelloWorld { static void Main() System.Console.WriteLine("Hello, World!"); } }
		#include <stdio.h> main( ) { printf("Hello, World!\\n"); }
		#include <iostream.h> main() { cout << "Hello, World!" << endl; return 0; }
		LDY #0 ; BEQ in; loop: JSR $$FFD2 ; INY ; in: LDA hello,Y; BNE loop ; RTS ; hello: .TXT "Hello, World!" ;  .BYTE 13,10,0
		10 PRINT "Hello, World!"
		(defn hello [] (println "Hello, World!")) (hello)
		body:before { content: "Hello, World!"; }
		main() { print(\'Hello, World!\'); }
		printf "Hello, World!\\n"
		package main import "fmt" func main() { fmt.Printf("Hello, World!\\n") }
		println "Hello, World!"
		main = putStrLn "Hello, World!"
		class HelloWorld { static public void main( String args[] ) { System.out.println( "Hello, World!" ); } }
		console.log("Hello, World!");
		fun main(args : Array<String>) { println("Hello, World!") }
		print "Hello, World!"
		print_string "Hello, World!\\n";;
		program HelloWorld(output); begin WriteLn(\'Hello, World!\'); end.
		print "Hello, World!\\n";
		<?php echo "Hello, World!\\n"; ?>
		\'Hello, World!\'
		print("Hello, World!")
		puts "Hello, World!"
		fn main() { println!("Hello, World!"); }
		object HelloWorld extends App { println("Hello, World!") }
		println("Hello, World!")
		N210000 E0000000
		N040000 E0000000
		N140000 E0000000
		N230000 E0000000
		N020000 E0000000
		N050000 E0000000
		N010000 E0000000' );
	
	final codinGameWorldResult = parseResult(
		'<?php echo "Hello, World!\\n"; ?>
		#include <iostream.h> main() { cout << "Hello, World!" << endl; return 0; }
		class HelloWorld { static public void main( String args[] ) { System.out.println( "Hello, World!" ); } }
		print("Hello, World!")
		class HelloWorld { static void Main() System.Console.WriteLine("Hello, World!"); } }
		LDY #0 ; BEQ in; loop: JSR $$FFD2 ; INY ; in: LDA hello,Y; BNE loop ; RTS ; hello: .TXT "Hello, World!" ;  .BYTE 13,10,0
		>"dlroW olleH",,,,,,,,,,,@' );
	
	final lonelyPlanet = parseInput(
		"1
		1
		Earth N000000 E1800000
		Hello, Earth!
		N000000 E0000000" );
	
	final lonelyPlanetResult = parseResult(
		"Hello, Earth!" );
	
	final roundtripInEurope = parseInput(
		"38
		5
		Andorra_La_Vella_Andorra N423000 E0013100
		Tirana_Albania N411900 E0194900
		Vienna_Austria N481200 E0162100
		Sarajevo_Bosnia_and_Herzegovina N435200 E0182500
		Sofia_Bulgaria N424100 E0231900
		Minsk_Belarus N535500 E0273300
		Prague_Czech_Republic N500500 E0142800
		Berlin_Germany N523100 E0132300
		Copenhagen_Denmark N554300 E0123400
		Tallin_Estonia N592500 E0244500
		Madrid_Spain N402600 W0034200
		Helsinki_Finland N601000 E0245600
		Paris_France N485124 E0022103
		London_United_Kingdom N513000 W0000700
		Athens_Greece N375800 E0234300
		Zagreb_Croatia N454900 E0155900
		Budapest_Hungary N472933 E0190305
		Dublin_Ireland N532039 W0061603
		Reykjavik_Iceland N640800 W0215600
		Rome_Italy N415400 E0123000
		Vilnius_Lithuania N544100 E0251900
		Luxembourg_City_Luxembourg N493636 E0060800
		Riga_Latvia N565656 E0240623
		Podgorica_Montenegro N422627 E0191548
		Skopje_North_Macedonia N420000 E0212600
		Valletta_Malta N355352 E0143045
		Amsterdam_Netherlands N522200 E0045400
		Oslo_Norway N595700 E0104500
		Warsaw_Poland N521400 E0210100
		Lisbon_Portugal N384250 W0090822
		Bucharest_Romania N442557 E0260614
		Belgrade_Serbia N444900 E0202800
		Moscow_Russia N554500 E0373700
		Stockholm_Sweden N591946 E0180407
		Ljubljana_Slovenia N460320 E0143030
		Bratislava_Slovakia N480838 E0170635
		Kyiv_Ukraine N502700 E0303124
		Vatican_City_Holy_See N415412 E0122712
		Hola, Mon!
		Tjeta, Bote!
		Servus, Welt!
		Zdravo, Svijet!
		Zdravej, Svjet!
		Vitaju, Svet!
		Ahoj, Svet!
		Hallo, Welt!
		Hej, Verden!
		Tere, Maailm!
		Hola, Mundo!
		Terve, Maailman!
		Salut, Le Monde!
		Hello, World!
		Yassou, Kosmos!
		Bok, Svijet!
		Szia, Vilag!
		Dia duit, Domhan!
		Hallo, Heimurinn!
		Ciao, Mondo!
		Labas, Pasaulis!
		Moien, Welt!
		Sveiks, Pasaule!
		Zdravo, Svet!
		Zdravo, Svetot!
		Bongu, Dinja!
		Hallo, Wereld!
		Hei, Verden!
		Czesc, Swiat!
		Ola, Mundo!
		Salut, Lume!
		Zdravo, Svet!
		Privet, Mir!
		Hej, Varld!
		Zdravo, Svet!
		Ahoj, Svet!
		Pryvit, Svit!
		Salve, Mundus!
		N485124 E0023103
		N375800 E0244300
		N472933 E0190405
		N523100 E0132400
		N415512 E0122712" );
	
	final roundtripInEuropeResult = parseResult(
		"Salut, Le Monde!
		Yassou, Kosmos!
		Szia, Vilag!
		Hallo, Welt!
		Salve, Mundus!" );
	
	final poleToPoleWithMichaelPalin = parseInput(
		"3
		7
		Joe_s_Place S000000 E1790000
		Jack_s_Place S000000 W1700000
		Laplace N000000 E1790000
		Hello, I am Joe!
		Hello, I am Jack!
		Hello, I am Sorry!
		N000000 W1753000
		N900000 E1790000
		N900000 W1700000
		S900000 W0123456
		N000000 E0043000
		N123456 E0043000
		S123456 E0123456" );
	
	final poleToPoleWithMichaelPalinResult = parseResult(
		"Hello, I am Joe! Hello, I am Jack! Hello, I am Sorry!
		Hello, I am Joe! Hello, I am Jack! Hello, I am Sorry!
		Hello, I am Joe! Hello, I am Jack! Hello, I am Sorry!
		Hello, I am Joe! Hello, I am Jack! Hello, I am Sorry!
		Hello, I am Joe! Hello, I am Jack! Hello, I am Sorry!
		Hello, I am Joe! Hello, I am Jack! Hello, I am Sorry!
		Hello, I am Joe! Hello, I am Sorry!" );
	
}

