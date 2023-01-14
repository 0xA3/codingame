import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final cyborgCount = parseInt( readline() );
	final cyborgs = [for( i in 0...cyborgCount ) readline()];
	
	final mayhemReportCount = parseInt( readline() );
	final mayhemReports = [for( i in 0...mayhemReportCount ) readline()];

	final cyborgReportCount = parseInt( readline() );
	final cyborgReports = [for( i in 0...cyborgReportCount ) readline()];
			
	final result = process( cyborgs, mayhemReports, cyborgReports );
	print( result );
}

function process( cyborgNames:Array<String>, mayhemReports:Array<String>, cyborgReports:Array<String> ) {
	
	final mayhem = new Cyborg( "Mayhem" );
	final cyborgs = [for( name in cyborgNames ) name => new Cyborg( name )];
	
	final mayhemAttributes = getAttributes( mayhemReports.join("\n"));
	for( attribute in mayhemAttributes ) {
		if( attribute.type == "word" ) {
			mayhem.addWords( [attribute.attribute] );
		} else {
			mayhem.addAttribute( attribute.type, attribute.attribute );
		}
		
	}

	final cyborgAttributes = getAttributes( cyborgReports.join("\n"));
	for( attribute in cyborgAttributes ) {
		if( attribute.type == "catchphrase" ) {
			final words = getWords( attribute.attribute );
			cyborgs[attribute.name].addWords( words );
		} else {
			cyborgs[attribute.name].addAttribute( attribute.type, attribute.attribute );
		}
	}

	final cyborgsWithAttributesOfMayhem = cyborgs.filter( cyborg -> {
		var isEqual = true;
		for( name => attribute in cyborg.attributes ) {
			if( mayhem.attributes.exists( name ) && mayhem.attributes[name] != attribute ) return false;
		}
		if( mayhem.words.length == 1 && cyborg.words.length > 0 ) {
			final mayhemsWord = mayhem.words[0];
			if( !cyborg.words.contains( mayhemsWord )) return false;
	
		}
		return isEqual;
	});

	if( cyborgsWithAttributesOfMayhem.length == 0 ) return "MISSING";
	if( cyborgsWithAttributesOfMayhem.length == 1 ) return cyborgsWithAttributesOfMayhem[0].name;
	
	return "INDETERMINATE";
}

function getAttributes( s:String ) {
	final ereg = ~/(\w+)'s (\w+) is [an "]*([a-zA-Z ]+)"*/g;
	
	final reports:Array<Report> = [];
	var input = s;
	while( ereg.match( input )) {
		final report:Report = {
			name: ereg.matched( 1 ),
			type: ereg.matched( 2 ),
			attribute: ereg.matched( 3 )
		}
		reports.push( report );
		input = ereg.matchedRight();
	}
	return reports;
}

function getWords( sentence:String ) {
	final wordsEreg = ~/([A-Z]+)/g;
	
	final words = [];
	var wordsInput = sentence;
	while( wordsEreg.match( wordsInput )) {
		words.push( wordsEreg.matched( 1 ));
		wordsInput = wordsEreg.matchedRight();
	}
	final char2PlusWords = words.filter( word -> word.length > 1 );
	
	return char2PlusWords;
}

typedef Report = {
	final name:String;
	final type:String;
	final attribute:String;
}

typedef CatchPhrase = {
	final name:String;
	final words:Array<String>;
}
