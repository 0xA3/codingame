import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import TChar;

using Lambda;

var candidateCounter = 0;
var doPrintErr = false;
function main() {

	final letterCase = readline() == "true";
	final letterFuzz = parseInt( readline() );
	final numberFuzz = parseInt( readline() );
	final otherFuzz = readline() == "true";
	final template = readline();
	final n = parseInt( readline() );
	final candidates = [for( _ in 0...n ) readline()];

	final result = process( letterCase, letterFuzz, numberFuzz, otherFuzz, template, candidates );
	print( result );
}


function process( letterCase:Bool, letterFuzz:Int, numberFuzz:Int, otherFuzz:Bool, template:String, candidates:Array<String> ) {
	// printErr( 'letterCase: $letterCase\nletterFuzz: $letterFuzz\nnumberFuzz: $numberFuzz\notherFuzz: $otherFuzz\ntemplate: $template\ncandidates: $candidates' );
	final templateParts = new Parser().parse( template );
	// printErr( 'templateParts:  [${templateParts.join(" ")}]  length ${templateParts.length}' );
	final outputs = [];
	candidateCounter = 0;
	for( candidate in candidates ) {
		candidateCounter++;
		// doPrintErr = candidateCounter == 1 ? true : false;
		
		if( doPrintErr ) printErr( '\ncheck $candidate : $template' );
		final partsMatches = [];
		final candidateParts = new Parser().parse( candidate );
		
		final maxLength = max( templateParts.length, candidateParts.length );
		for( i in 0...maxLength ) {
			final templatePart = i < templateParts.length ? templateParts[i] : None;
			final candidatePart = i < candidateParts.length ? candidateParts[i] : None;

			partsMatches.push( match( candidatePart, templatePart, letterCase, letterFuzz, numberFuzz, otherFuzz ) );
		}
		
		final compoundMatch = partsMatches.fold(( output, and ) -> and && output, true );
		if( doPrintErr ) printErr( 'compoundMatch: $compoundMatch' );
		outputs.push( compoundMatch ? "true" : "false" );
	}

	return outputs.join( "\n" );
}

function match( candidatePart:TChar, templatePart:TChar, letterCase:Bool, letterFuzz:Int, numberFuzz:Int, otherFuzz:Bool ) {
	switch [candidatePart, templatePart] {
		case [Letter( c ), Letter( t )]:
			final m = checkLetterFuzz( c, t, letterCase, letterFuzz );
			if( doPrintErr ) printErr( 'LetterFuzz $c $t  case: $letterCase  fuzz: $letterFuzz : $m' );
			return m;
		case [Number( c ), Number( t )]:
			final m = checkNumberFuzz( c, t, numberFuzz );
			if( doPrintErr ) printErr( 'NumberFuzz $c $t numberFuzz: $numberFuzz : $m' );
			return m;
		case [Other( c ), Other( t )]:
			final m = checkOtherFuzz( c, t, otherFuzz );
			if( doPrintErr ) printErr( 'OtherFuzz $c $t otherFuzz: $otherFuzz : $m' );
			return m;
		default: return false;
	}
}

function checkLetterFuzz( candidate:String, template:String, letterCase:Bool, letterFuzz:Int ) {
	final a = ( letterCase ? candidate : candidate.toLowerCase()).charCodeAt( 0 );
	final b = ( letterCase ? template : template.toLowerCase()).charCodeAt( 0 );
	return Math.abs( a - b ) <= letterFuzz ? true : false;
}

function checkNumberFuzz( candidate:Int, template:Int, numberFuzz:Int ) {
	return Math.abs( candidate - template ) <= numberFuzz ? true : false;
}

function checkOtherFuzz( candidate:String, template:String, otherFuzz:Bool ) {
	return otherFuzz ? candidate == template : true;
}

function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
