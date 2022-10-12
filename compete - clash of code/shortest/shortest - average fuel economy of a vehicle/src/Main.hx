import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.string;
import Std.parseFloat;
import Math.ceil;

/*
Given the average fuel economy of a vehicle (The number of kilometres a vehicle can travel for each litre of fuel), the amount of fuel in the vehicle's fuel tank, the price of fuel, and the distance of a journey, calculate the total cost of the trip.

You should return
0.00
if the fuel already in the tank is sufficient to cover the journey.

Input
13.0
2.6
1.64
110

Output
9.62
*/

function main() {

	final e = parseFloat( readline());
	final f = parseFloat( readline());
	final p = parseFloat( readline());
	final d = parseFloat( readline());
	final cost = ceil(( d / e - f ) * p * 100 );
	
	final sCost = string( cost );
	final output = sCost.substr( 0, sCost.length - 2 ) + "." + sCost.substr( sCost.length - 2 );

	print( cost <= 0 ? "0.00" : output );
}
