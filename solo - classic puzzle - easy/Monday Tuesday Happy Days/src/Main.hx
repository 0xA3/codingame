import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static final dayNames = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
	static final monthNames = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];
	static final daysOfMonths = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

	static function main() {
		
		final leapYear = parseInt( readline() );
		final inputs = readline().split(' ');
		final sourceDayOfWeek = inputs[0];
		final sourceMonth = inputs[1];
		final sourceDayOfMonth = parseInt( inputs[2] );
		final inputs = readline().split(' ');
		final targetMonth = inputs[0];
		final targetDayOfMonth = parseInt( inputs[1] );
		
		final result = process( leapYear, sourceDayOfWeek, sourceMonth, sourceDayOfMonth, targetMonth, targetDayOfMonth );
		print( result );
	}

	static function process( leapYear:Int, sourceDayOfWeek:String, sourceMonth:String, sourceDayOfMonth:Int, targetMonth:String, targetDayOfMonth:Int ) {
		
		final thisYearDaysOfMonth = daysOfMonths.copy();
		thisYearDaysOfMonth[1] += leapYear;

		final sDayNameIndex = dayNames.indexOf( sourceDayOfWeek );
		final sMonthIndex = monthNames.indexOf( sourceMonth );
		final tMonthIndex = monthNames.indexOf( targetMonth );

		final dayOffset = getDayOffset( sMonthIndex, sourceDayOfMonth, tMonthIndex, targetDayOfMonth, thisYearDaysOfMonth );
		final modDayOffset = dayOffset % dayNames.length;
		
		final tDayNameIndex = ( sDayNameIndex + modDayOffset + dayNames.length ) % dayNames.length;
		
		// trace( 'dayOffset $dayOffset, modDayOffset $modDayOffset, sDayNameIndex $sDayNameIndex,  tDayNameIndex $tDayNameIndex ${dayNames[tDayNameIndex]}' );

		return dayNames[tDayNameIndex];

	}

	static function getDayOffset( sMonthIndex:Int, sourceDayOfMonth:Int, tMonthIndex:Int, targetDayOfMonth:Int, thisYearDaysOfMonth:Array<Int> ) {
		if( sMonthIndex <= tMonthIndex ) {
			return [for( i in sMonthIndex...tMonthIndex ) thisYearDaysOfMonth[i]].fold(( days, sum ) -> sum + days, 0 ) + targetDayOfMonth - sourceDayOfMonth;
		} else {
			final sum = [for( i in tMonthIndex...sMonthIndex ) thisYearDaysOfMonth[i]].fold(( days, sum ) -> sum + days, 0 ) + sourceDayOfMonth - targetDayOfMonth;
			return -sum;
		}
	}

}
