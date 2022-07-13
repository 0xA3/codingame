import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringUtils;

function main() {

	final n = parseInt( readline() );
	final answers = [for( _ in 0...n ) readline()];

	final result = process( answers );
	print( result );
}

function process( answers:Array<String> ) {

	final completeAnswers = [];
	final missingAnswers = [];
	for( answer in answers ) {
		final parts = answer.split( " " );
		if( parts.length == 3 ) completeAnswers.push( parts );
		else if( parts.length == 2 ) missingAnswers.push( parts );
		else throw 'Error in answer $answer';
	}

	final genderRanges = createRanges( completeAnswers );

	final predictions = [];
	for( parts in missingAnswers ) {
		final age = parseInt( parts[0] );
		final gender = parts[1];

		final ranges = gender == "male" ? genderRanges.male : genderRanges.female;
		var isFound = false;
		for( genre => range in ranges ) {
			// trace( 'check range ${range.start}-${range.end} for $gender age $age  ${range.start <= age && range.end >= age}  - $genre' );
			if( range.start <= age && range.end >= age ) {
				// trace( 'is $genre' );
				predictions.push( genre );
				isFound = true;
				break;
			}
		}
		if( !isFound ) {
			// trace( 'is None' );
			predictions.push( "None" );
		}
	}

	return predictions.join( "\n" );
}

function createRanges( completeAnswers:Array<Array<String>> ) {
	final maleRanges:Map<String, Range> = [];
	final femaleRanges:Map<String, Range> = [];
	for( parts in completeAnswers ) {
		final age = parseInt( parts[0] );
		final gender = parts[1];
		final genre = parts[2];

		final ranges = gender == "male" ? maleRanges : femaleRanges;

		if( !ranges.exists( genre ) ) ranges.set( genre, { start: age, end: age } );
		else {
			final range = ranges[genre];
			final start = min( range.start, age );
			final end = max( range.end, age );
			ranges.set( genre, { start: start, end: end } );
		}
	}

	return { male: maleRanges, female: femaleRanges };
}

function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;

typedef Range = {
	final start:Int;
	final end:Int;
}
