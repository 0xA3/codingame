import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {
	final mother = readline();
	final child = readline();
	final numOfPossibleFathers = parseInt( readline() );
	final possibleFathers = [for( _ in 0...numOfPossibleFathers ) readline()];

	final result = process( mother, child, possibleFathers );
	print( result );
}

function process( mother:String, child:String, possibleFathers:Array<String> ) {
	
	final motherDataset = parsePerson( mother );
	final childDataset = parsePerson( child );

	final possibleFatherDatasets = possibleFathers.map( possibleFather -> parsePerson( possibleFather ));

	final fatherDatasets = possibleFatherDatasets.filter( possibleFather -> {
		// trace( 'check ${possibleFather.name}' );
		return compareChromosomePairs( possibleFather.chromosomePairs, motherDataset.chromosomePairs, childDataset.chromosomePairs );
	});

	if( fatherDatasets.length == 0 ) throw 'Error: no father found';
	if( fatherDatasets.length > 1 ) throw 'Error: multiple fatherDatasets found. ${fatherDatasets.map( p -> p.name )}';

	return '${fatherDatasets[0].name}, you are the father!';
}

function compareChromosomePairs( cf:Array<Array<String>>, cm:Array<Array<String>>, cc:Array<Array<String>> ) {
	if( cf.length != cm.length || cm.length != cc.length ) throw 'Error: chromosome lengths are different cf: ${cf.length} cm: ${cm.length} cc: ${cc.length}';
	
	for( i in 0...cf.length ) if( compareChromosomePair( cf[i], cm[i], cc[i] ) == false ) return false;

	return true;
}

function compareChromosomePair( cf:Array<String>, cm:Array<String>, cc:Array<String> ) {
	if( cf.length != cm.length || cm.length != cc.length ) throw 'Error: chromosome lengths are different cf: ${cf.length} cm: ${cm.length} cc: ${cc.length}';

	final combinations = [for( f in cf ) for( m in cm ) ['$f$m', '$m$f']].flatten();
	final childChromosome = cc.join( "" );
	// trace( 'father ${cf.join( "" )}  mother ${cm.join( "" )} combinations $combinations  child $childChromosome  ${combinations.contains( childChromosome )}' );
	if( combinations.contains( childChromosome )) return true;
	return false;

	// trace( 'child ${cc.join( "" )}  father ${cf.join( "" )}  mother ${cm.join( "" )}  fc $fatherContribution  mc $motherContribution' );

}

function parsePerson( person:String ) {
	final ereg = ~/^([A-Za-z ]+):\s+(.+)$/;

	ereg.match( person );
	final name = ereg.matched( 1 );
	final chromosomePairs = ereg.matched( 2 ).split(" ").map( s -> s.split( "" ));
	final personDataset= { name: name, chromosomePairs: chromosomePairs }
	
	return personDataset;
}


typedef PersonDataset = {
	final name:String;
	final chromosomePairs:Array<Array<String>>;
}