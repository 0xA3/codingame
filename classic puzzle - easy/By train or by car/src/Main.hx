import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;
import Std.parseInt;

using Lambda;
using xa3.MathUtils;

inline var MINUTES = 60;

final train:Constraints = {
	averageSpeed: 284,
	citySpeed: 50,
	cityDistance: 3,
	cityPauseTime: 8,
	startCommmuteTime: 35,
	endCommuteTime: 30
}
final car:Constraints = {
	averageSpeed: 105,
	citySpeed: 50,
	cityDistance: 7,
	cityPauseTime: 0,
	startCommmuteTime: 0,
	endCommuteTime: 0
}

function main() {

	final t = readline().split(" ");
	final n = parseInt( readline());
	final segments = [for( _ in 0...n ) readline().split(" ")];
	
	final result = process( t[0], t[1], segments );
	print( result );
}

function process( origin:String, destination:String, segments:Array<Array<String>>  ) {

	final relevantSegments = [];
	var station = origin;
	while( station != destination ) {
		for( segment in segments ) {
			if( station == segment[0] ) {
				relevantSegments.push( segment );
				station = segment[1];
				break;
			}
		}
	}

	final trainTime = getTotalTime( relevantSegments, train );
	final carTime = getTotalTime( relevantSegments, car );

	return trainTime < carTime ? 'TRAIN ${getHoursMinutes( trainTime )}' : 'CAR ${getHoursMinutes( carTime )}';
}

function getTotalTime( segments:Array<Array<String>>, constraints:Constraints ) {
	var totalMinutes:Float = constraints.startCommmuteTime + constraints.endCommuteTime;
	for( i in 0...segments.length ) {
		final segmentDistance = parseFloat( segments[i][2] );
		
		final doubleCityDistance = Math.min( 2 * constraints.cityDistance, segmentDistance );
		final cityTime = doubleCityDistance / constraints.citySpeed * MINUTES;
		
		final overlandDistance = segmentDistance - doubleCityDistance;
		final overlandTime = overlandDistance / constraints.averageSpeed * MINUTES;
		
		totalMinutes += cityTime + overlandTime;
	}
	totalMinutes += ( segments.length - 1 ) * constraints.cityPauseTime;

	return totalMinutes;
}

function getHoursMinutes( totalMinutes:Float ) {
	final minutes = int( totalMinutes % 60 );
	final minutesString = minutes > 9 ? '$minutes' : '0$minutes';
	final hours = int( totalMinutes / 60 );
	return '$hours:$minutesString'	;
}

typedef Constraints = {
	final averageSpeed:Int;
	final citySpeed:Int;
	final cityDistance:Int;
	final cityPauseTime:Int;
	final startCommmuteTime:Int;
	final endCommuteTime:Int;
}