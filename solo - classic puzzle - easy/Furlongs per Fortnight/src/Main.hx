import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using NumberFormat;

final distanceUnits = [
	"inches" => 1,
	"feet" => 12,
	"yards" => 3 * 12,
	"chains" => 3 * 12 * 22,
	"furlongs" => 3 * 12 * 22 * 10,
	"miles" => 3 * 12 * 22 * 10 * 8
];

final timeUnits = [
	"second" => 1,
	"minute" => 60,
	"hour" => 60 * 60,
	"day" => 24 * 60 * 60,
	"week" => 7 * 24 * 60 * 60,
	"fortnight" => 2 * 7 * 24 * 60 * 60
];

function main() {
	final aSpeed = readline();

	final result = process( aSpeed );
	print( result );
}

function process( aSpeed:String ) {
	final parts = aSpeed.split(" ");
	final value = parseInt( parts[0] );
	final distance1 = parts[1];
	final time1 = parts[3];
	final distance2 = parts[6];
	final time2 = parts[8];

	// trace( 'value $value  distance1 $distance1  time1 $time1  distance2 $distance2  time2 $time2' );
	final inchesPerSecond = value / timeUnits[time1] * distanceUnits[distance1];
	final result = inchesPerSecond * timeUnits[time2] / distanceUnits[distance2];
	// trace( 'result $result' );

	final stringResult = result % 1 == 0 ? '$result.0' : result.fixed( 1 );

	final output = '$stringResult $distance2 per $time2';

	return output;
}
