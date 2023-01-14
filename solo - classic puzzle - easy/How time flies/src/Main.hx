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
		
		final totalmonths = ( endDate.getFullYear() - beginDate.getFullYear()) * 12 - beginDate.getMonth() + endDate.getMonth() - ( beginDate.getDate() > endDate.getDate() ? 1 : 0 );
		final years = int( totalmonths / 12 );
		final months = totalmonths % 12;
		final totalDays = int( round(( endDate.getTime() - beginDate.getTime()) / MILLISECONDS_PER_DAY ));

		final yearsOutput = years == 0 ? "" : years == 1 ? "1 year" : '$years years';
		final monthsOutput = months == 0 ? "" : months == 1 ? "1 month" : '$months months';
		final daysOutput = totalDays == 1 ? "total 1 day" : 'total $totalDays days';

		final result = [yearsOutput, monthsOutput, daysOutput].filter( s -> s != "" ).join( ", " );

		return result;
	}

	static function parseDate( s:String ) {
		final a = s.split( "." ).map( s -> parseInt( s ));
		return new Date( a[2], a[1] - 1, a[0], 0, 0, 0 );
	}

}
