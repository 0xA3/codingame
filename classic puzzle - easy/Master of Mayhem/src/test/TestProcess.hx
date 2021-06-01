package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test getAttributes", {
			it( "One report", {
				final reports = Main.getAttributes( "SPEEDO's hat is a FEDORA" );
				reports.length.should.be( 1 );
			});
			it( "One report name", {
				final reports = Main.getAttributes( "SPEEDO's hat is a FEDORA" );
				reports[0].name.should.be( "SPEEDO" );
			});
			it( "One report type", {
				final reports = Main.getAttributes( "SPEEDO's hat is a FEDORAA" );
				reports[0].type.should.be( "hat" );
			});
			it( "One report attribute", {
				final reports = Main.getAttributes( "SPEEDO's hat is a FEDORA" );
				reports[0].attribute.should.be( "FEDORA" );
			});
			it( "One report an attribute", {
				final reports = Main.getAttributes( "GROUCHO's neckwear is an INT OF PEARLS" );
				reports[0].attribute.should.be( "INT OF PEARLS" );
			});
			it( "One report word", {
				final reports = Main.getAttributes( 'Mayhem\'s word is "SNARK"' );
				reports[0].attribute.should.be( "SNARK" );
			});
			it( "Two reports", {
				final reports = Main.getAttributes( "Mayhem's hat is a FEDORA\nTYPO's companion is a MINIATURE DRAGON" );
				reports.length.should.be( 2 );
			});
			it( "Two reports second attribute", {
				final reports = Main.getAttributes( "Mayhem's hat is a FEDORA\nTYPO's companion is a MINIATURE DRAGON" );
				reports[1].attribute.should.be( "MINIATURE DRAGON" );
			});

		});
		
		describe( "Test getWords", {
			it( "One catchphrase 2 words", {
				final words = Main.getWords( 'I am HUNTING for a SNARK' );
				words.length.should.be( 2 );
			});
			it( "One catchphrase first word", {
				final words = Main.getWords( 'I am HUNTING for a SNARK' );
				words[0].should.be( "HUNTING" );
			});
			
		});
		
		describe( "Test process", {
			it( "Simple", {
				final ip = simple;
				Main.process( ip.cyborgs, ip.mayhemReports, ip.cyborgReports ).should.be( "SPEEDO" );
			});
			
			it( "No Info", {
				final ip = noInfo;
				Main.process( ip.cyborgs, ip.mayhemReports, ip.cyborgReports ).should.be( "CHICO" );
			});
			
			it( "Too Many Cooks", {
				final ip = tooManyCooks;
				Main.process( ip.cyborgs, ip.mayhemReports, ip.cyborgReports ).should.be( "INDETERMINATE" );
			});
			
			it( "Nobody Left", {
				final ip = nobodyLeft;
				Main.process( ip.cyborgs, ip.mayhemReports, ip.cyborgReports ).should.be( "MISSING" );
			});
			
			it( "Only One", {
				final ip = onlyOne;
				Main.process( ip.cyborgs, ip.mayhemReports, ip.cyborgReports ).should.be( "SOLO" );
			});
			
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final cyborgCount = parseInt( lines[0] );
		final cyborgs = [for( i in 0...cyborgCount ) lines[i + 1]];
		
		final mayhemReportCount = parseInt( lines[cyborgCount + 1] );
		final mayhemReports = [for( i in 0...mayhemReportCount ) lines[i + cyborgCount + 2]];

		final cyborgReportCount = parseInt( lines[cyborgCount + mayhemReportCount + 2] );
		final cyborgReports = [for( i in 0...cyborgReportCount ) lines[i + cyborgCount + mayhemReportCount + 3]];

		return { cyborgs: cyborgs, mayhemReports: mayhemReports, cyborgReports: cyborgReports };
	}
	
	final simple = parseInput(
		"2
		SPEEDO
		TYPO
		3
		Mayhem's hat is a FEDORA
		Mayhem's neckwear is a STRING OF PEARLS
		Mayhem's word is \"SNARK\"
		7
		SPEEDO's hat is a FEDORA
		TYPO's catchphrase is \"I am HUNTING for a SNARK\"
		TYPO's companion is a MINIATURE DRAGON
		SPEEDO's neckwear is a STRING OF PEARLS
		SPEEDO's companion is a BEAVER
		TYPO's hat is a FEDORA
		TYPO's neckwear is a PENDANT"
	);

	final noInfo = parseInput(
		"3
		GROUCHO
		HARPO
		CHICO
		2
		Mayhem's hat is a TYROLEAN ALPINE
		Mayhem's companion is a HONEY BADGER
		6
		GROUCHO's neckwear is an INT OF PEARLS
		HARPO's catchphrase is \"You will not CATCH me SLEEPING\"
		GROUCHO's companion is a RAVEN
		GROUCHO's hat is a TYROLEAN ALPINE
		HARPO's hat is a BERET
		HARPO's neckwear is a FEATHER BOA"
	);

	final tooManyCooks = parseInput(
		"6
		SPEEDO
		DITTO
		ERGO
		TYPO
		UHOH
		OHNO
		1
		Mayhem's word is \"DOUBLE\"
		20
		UHOH's catchphrase is \"DOUBLE TROUBLE\"
		TYPO's catchphrase is \"I DOUBLE DARE you\"
		OHNO's neckwear is a PAISLEY SHAWL
		TYPO's companion is a BOWL OF PEANUTS
		UHOH's neckwear is a DOG COLLAR
		TYPO's hat is a STRAW BOATER
		OHNO's catchphrase is \"I will make your TROUBLE DOUBLE\"
		OHNO's companion is a PANTS WEARING PANGOLIN
		DITTO's hat is a GINGHAM BONNET
		TYPO's neckwear is a LACE RUFF
		DITTO's neckwear is a CRAVAT
		ERGO's companion is a CUBE
		SPEEDO's catchphrase is \"You BETTER BOOK it\"
		ERGO's catchphrase is \"FIGHT me if you DARE\"
		UHOH's companion is a PARASITIC DRAGON
		ERGO's hat is a PROPELLER BEANIE
		SPEEDO's hat is a GOLD CROWN
		SPEEDO's companion is a UNICORN
		SPEEDO's neckwear is a WALL CLOCK
		OHNO's hat is a ROASTED TURKEY"
	);

	final nobodyLeft = parseInput(
		"7
		MELLOW
		YELLOW
		FELLOW
		BELLOW
		JELLO
		HELLO
		CELLO
		4
		Mayhem's hat is a LAUREL WREATH
		Mayhem's word is \"DANGER\"
		Mayhem's neckwear is an ASCOT
		Mayhem's companion is an AMORPHOUS BLOB
		28
		MELLOW's hat is a LAUREL WREATH
		YELLOW's hat is a LAUREL WREATH
		FELLOW's hat is a LAUREL WREATH
		BELLOW's hat is a LAUREL WREATH
		JELLO's hat is a LAUREL WREATH
		HELLO's hat is a LAMPSHADE
		CELLO's hat is a BOWLER
		MELLOW's neckwear is an ASCOT
		YELLOW's neckwear is an ASCOT
		FELLOW's neckwear is an ASCOT
		BELLOW's neckwear is a STETHOSCOPE
		JELLO's neckwear is an PENDANT
		HELLO's neckwear is an ASCOT
		CELLO's neckwear is an ASCOT
		MELLOW's companion is an AMORPHOUS BLOB
		YELLOW's companion is a FISH OUT OF WATER
		FELLOW's companion is an AMORPHOUS BLOB
		BELLOW's companion is an AMORPHOUS BLOB
		JELLO's companion is an AMORPHOUS BLOB
		HELLO's companion is an AMORPHOUS BLOB
		CELLO's companion is an AMORPHOUS BLOB
		MELLOW's catchphrase is \"CARE for a game of CATCH\"
		YELLOW's catchphrase is \"FOLLOW me for DANGER\"
		CELLO's catchphrase is \"STRANGER DANGER\"
		BELLOW's catchphrase is \"DANGER is my MIDDLE name\"
		JELLO's catchphrase is \"I LIVE for DANGER\"
		HELLO's catchphrase is \"You are in DANGER of my WRATH\"
		FELLOW's catchphrase is \"TIPTOE through the TULIPS\""
	);

	final onlyOne = parseInput(
		"1
		SOLO
		0
		1
		SOLO's catchphrase is \"I have a BAD FEELING\""
	);

}

