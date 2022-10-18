import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.NumberConvert;
using xa3.NumberFormat;
using xa3.RegexUtils;
using xa3.StringUtils;

/*
Storyline:
You work in NASA, and must check if the rocket will reach Mars

The Problem:
You must create a program to calculate if rocket will reach Mars

Criterion of a Failing rocket:
- If velocity multiplied by the time is less than distance to Mars
- If fuel multiplied by the fuel consumption is less than distance

Notes:
If there is less time, print 'Failure, Not enough time'
If there is less fuel, print 'Failure, Not enough fuel'
If both only print 'Failure, Not enough time'
If rocket is successful, print 'Welcome to Mars'
time will be in hours
fuel will be in liters
fuel_consumption will be in distance per 1 liter of fuel
distance will be in kilometers


Input
1000
10
10
100
100

Output
Failure, Not enough time

*/

function main() {

	final distance = parseInt(readline());
	final time = parseInt(readline());
	final velocity = parseInt(readline());
	final fuel = parseInt(readline());
	final fuelConsumption = parseInt(readline());
	
	final noTime = velocity * time < distance;
	final noFuel = fuel * fuelConsumption < distance;

	if( noTime ) print( "Failure, Not enough time" );
	else if( noFuel ) print( "Failure, Not enough fuel" );
	else print( "Welcome to Mars" );
}
