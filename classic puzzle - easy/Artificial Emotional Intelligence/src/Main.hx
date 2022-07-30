import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

final adjList = "Adaptable Adventurous Affectionate Courageous Creative Dependable Determined Diplomatic Giving Gregarious Hardworking Helpful Hilarious Honest Non-judgmental Observant Passionate Sensible Sensitive Sincere".split(" ");
final goodList = "Love, Forgiveness, Friendship, Inspiration, Epic Transformations, Wins".split(", ");
final badList = "Crime, Disappointment, Disasters, Illness, Injury, Investment Loss".split(", ");
final alphabet = "abcdefghijklmnopqrstuvwxyz".split( "" );
final vovels = "aeiouy".split( "" );

function main() {

	final name = readline();

	final result = process( name );
	print( result );
}

function process( name:String ) {
	final consonants = alphabet.filter( c -> !vovels.contains( c ));

	final na = name.toLowerCase().split( "" );
	final chars = na.filter( s -> isInAlphabet( s ));
	
	final nameConsonants = getUniqueConsonants( chars );
	final nameVovels = chars.filter( c -> vovels.contains( c )).slice( 0, 2 );

	if( nameConsonants.length < 3 || nameVovels.length < 2 ) return 'Hello $name.';

	final consonantIndices = nameConsonants.map( c -> consonants.indexOf( c ));
	final vovelIndices = nameVovels.map( c -> vovels.indexOf( c ));

	final adjectives = consonantIndices.map( v -> adjList[v].toLowerCase());
	final good = goodList[vovelIndices[0]].toLowerCase();
	final bad = badList[vovelIndices[1]].toLowerCase();

	final output = 'It\'s so nice to meet you, my dear ${adjectives[0]} $name.\nI sense you are both ${adjectives[1]} and ${adjectives[2]}.\nMay our future together have much more $good than $bad.';

	return output;
}

function isInAlphabet( s:String ) {
	final code = s.charCodeAt( 0 );
	return ( code >= 65 && code <= 90 ) || ( code >= 97 && code <= 122 );
}

function getUniqueConsonants( chars:Array<String> ) {
	final consonants = [];
	for( char in chars ) {
		if( !vovels.contains( char ) && !consonants.contains( char )) consonants.push( char );
		if( consonants.length == 3 ) break;
	}

	return consonants;
}
