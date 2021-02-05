import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;
import Math.round;

using Lambda;

class Main {
	
	public static inline var MILLISECONDS_PER_MINUTE = 60 * 1000;
	public static inline var MILLISECONDS_PER_HOUR = 60 * MILLISECONDS_PER_MINUTE;
	public static inline var MILLISECONDS_PER_DAY = 24 * MILLISECONDS_PER_HOUR;
	public static inline var MILLISECONDS_PER_MONTH = 365.25 / 12 * MILLISECONDS_PER_DAY;
	
	static function main() {
		
		final begin = readline();
		final end = readline();		
		final result = process( begin, end );
		print( result );
	}

	static function process( begin:String, end:String ) {
		final beginDate = parseDate( begin );
		final endDate = parseDate( end );
		
		final years = endDate.getFullYear() - beginDate.getFullYear();
		final months = endDate.getMonth() - beginDate.getMonth();
		final days = endDate.getDate() - beginDate.getDate();
		final totalDays = int( round(( endDate.getTime() - beginDate.getTime()) / MILLISECONDS_PER_DAY ));

		// trace( years, months, totalDays );

		final deltaYears = months < 0 ? years - 1 : years;
		final deltaMonths = days < 0 ? months - 1 : months;
		final realMonths = deltaMonths < 0 ? 12 + deltaMonths : deltaMonths;

		final yearsOutput = deltaYears == 0 ? "" : '$deltaYears' + ( deltaYears == 1 ? " year" : " years" );
		final monthsOutput = realMonths == 0 ? "" : '$realMonths' + ( realMonths == 1 ? " month" : " months" );
		final daysOutput = 'total $totalDays ' + ( totalDays == 1 ? "day" : "days" );

		final result = [yearsOutput, monthsOutput, daysOutput].filter( s -> s != "" ).join( ", " );

		return result;
	}

	static function parseDate( s:String ) {
		final date = Std.parseInt( s.substr( 0, 2 ));
		final month = Std.parseInt( s.substr( 3, 2 ));
		final year = s.length < 10 ? Std.parseInt( s.substr( 6, 2 )) + 2000 : Std.parseInt( s.substr( 6, 4 ));
		
		return new Date( year, month - 1, date, 0, 0, 0 );
	}

}
