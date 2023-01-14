import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;

using Lambda;
using StringTools;
using xa3.ERegUtils;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.StringUtils;

/*
You're texting a friend while driving your brand new Gami Codella © of mass m1. When suddenly: BAAAAM!!!!
You crash into the car in front of you of mass m2 which was going at a speed of u2 and see it skidding off at a speed of v2!

Knowing that your speedometer is now reading v1, calculate the speed you were going the instant before the crash.

Please Note: In any collision with an absence of external forces the total momentum of the system will be conserved, even if there is energy loss.

Also:
Momentum of an object = mass * velocity
Momentum of the system = sum of the different object's momentums

Input
100 100
0 10
0

Output
10

*/

function main() {

	final inputs = readline().split(" ");
	final m1 = parseFloat( inputs[0] );
	final m2 = parseFloat( inputs[1] );
	final inputs = readline().split(" ");
	final u2 = parseFloat( inputs[0] );
	final v2 = parseFloat( inputs[1] );
	final v1 = parseFloat( readline() );
	
	// m1 * u1 + m2 * u2 = m1 * v1 + m2 * v2
	// m1 * u1 = m1 * v1 + m2 * v2 - m2 * u2
	final u1 = ( m1 * v1 + m2 * v2 - m2 * u2 ) / m1;

	print( u1.fixed( 3 ).rstrip( "0" ).rstrip( "." ));
}
