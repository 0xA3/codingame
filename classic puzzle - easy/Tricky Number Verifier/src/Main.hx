import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.string;

using Lambda;

final zero = "0".code;
final nine = "9".code;

final OK = "OK";
final INVALID_SYNTAX = "INVALID SYNTAX";
final INVALID_DATE = "INVALID DATE";

final multipliers = [3, 7, 9, 5, 8, 4, 2, 1, 6];

function main() {

	final n = parseInt( readline() );
	final numbers = [for( i in 0...n ) readline()];
	
	final result = process( numbers );
	print( result );
}

function process( numbers:Array<String> ) {
	final resultNumbers = numbers.map( number -> processNumber( number ));
	// for( i in 0...numbers.length ) trace( numbers[i], resultNumbers[i] );
	return resultNumbers.join( "\n" );
}

function processNumber( number:String ) {
	if( number.length != 10 ) return INVALID_SYNTAX;
	if( number.charAt( 0 ) == "0" ) return INVALID_SYNTAX;
	for( i in 0...number.length ) {
		final code = number.charCodeAt( i );
		if( code < zero || code > nine ) return INVALID_SYNTAX;
	}

	final birthday = number.substr( 4 );
	if( !checkDate( birthday )) return INVALID_DATE;
	
	final lll = number.substr( 0, 3 );
	final check = number.substr( 3, 1 );

	final identifier = getIdentifier( lll, birthday );
	
	if( identifier != 10 ) {
		return parseInt( check ) == identifier ? OK : '$lll$identifier$birthday';
	}

	final lll2 = string( parseInt( lll ) + 1 );
	final id2 = getIdentifier( lll2, birthday );
	
	final securityNumber = '$lll2$id2$birthday';

	return securityNumber;
}

function checkDate( birthday:String ) {
	
	final day = parseInt( birthday.substr( 0, 2 ));
	final month = parseInt( birthday.substr( 2, 2 )) - 1;
	final year2 = parseInt( birthday.substr( 4, 2 ));

	final year = parseInt(	year2 < 10 ? '200$year2' :
							year2 < 70 ? '20$year2' :
							'19$year2' );

	final date = try {
		new Date( year, month, day, 0, 0, 0 );
	} catch( e ) return false;

	return 	date.getDate() == day &&
			date.getMonth() == month &&
			date.getFullYear() == year ? true : false;
}

function getIdentifier( lll:String, birthday:String ) {
	final idInts = toInts( lll );
	final birthdayInts = toInts( birthday );

	final digits = idInts.concat( birthdayInts );
	final multipliedDigits = digits.mapi(( i, digit ) -> digit * multipliers[i] );
	final sum = multipliedDigits.fold(( v, sum ) -> sum + v, 0 );
	
	return sum % 11;
}

function toInts( s:String ) {
	return s.split( "" ).map( s -> parseInt( s ));
}