import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

final alphabets = [
	["Authority","Bills","Capture","Destroy","Englishmen","Fractious","Galloping","High","Invariably","Juggling","Knights","Loose","Managing","Never","Owners","Play","Queen","Remarks","Support","The","Unless","Vindictive","When","Xpeditiously","Your","Zigzag"],
	["Apples","Butter","Charlie","Duff","Edward","Freddy","George","Harry","Ink","Johnnie","King","London","Monkey","Nuts","Orange","Pudding","Queenie","Robert","Sugar","Tommy","Uncle","Vinegar","Willie","Xerxes","Yellow","Zebra"],
	["Amsterdam","Baltimore","Casablanca","Denmark","Edison","Florida","Gallipoli","Havana","Italia","Jerusalem","Kilogramme","Liverpool","Madagascar","New-York","Oslo","Paris","Quebec","Roma","Santiago","Tripoli","Uppsala","Valencia","Washington","Xanthippe","Yokohama","Zurich"],
	["Alfa","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India","Juliett","Kilo","Lima","Mike","November","Oscar","Papa","Quebec","Romeo","Sierra","Tango","Uniform","Victor","Whiskey","X-ray","Yankee","Zulu"]
];

function main() {
	final aWordSpelledOut = readline();
	
	final result = process( aWordSpelledOut );
	print( result );
}

function process( aWordSpelledOut:String ) {
	final words = aWordSpelledOut.split(" ");
	
	final version = getVersion( words );
	if( version == -1 ) throw 'Error: no version found for $words';

	final wordIndices = words.map( word -> word.charCodeAt( 0 ) - "A".code );
	
	final solutionVersion = ( version + 1 ) % alphabets.length;
	final solutions = wordIndices.map( index -> alphabets[solutionVersion][index] );

	return solutions.join(" ");
}

function getVersion( words:Array<String> ) {
	final possibleVersions = [for( i in 0...alphabets.length ) i];
	for( word in words ) {
		final notContains = [for( i in 0...alphabets.length ) if( !alphabets[i].contains( word )) i];
		for( version in notContains ) possibleVersions.remove( version );
		if( possibleVersions.length == 1 ) return possibleVersions[0];
	}
	return -1;
}

