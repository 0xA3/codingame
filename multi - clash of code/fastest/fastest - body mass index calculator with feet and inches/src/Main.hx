import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.NumberFormat;

/*
You are tasked by the United States Department of Health and Human Services with creating a Body Mass Index (BMI) calculator. You will be given a weight in pounds (lb) and a height in feet (ft) and inches (in) and must output the users BMI. The output must be rounded to the nearest one tenth.

Additionally, the user should be informed of their weight status given the following categories associated with BMI ranges:

Below 18.5: "Underweight"
18.5 - 24.9: "Normal"
25.0 - 29.9: "Overweight"
30.0 and Above: "Obese"

The weight status is defined after rounding. A BMI calculation of 29.99 would be considered "Obese".

There are 12 inches in a foot.

The formula for BMI is: 703 * weight (lb) / [height (in)]^2

Example:

weight = 150lbs
height = 5ft 5in

703 * [150 ÷ (5 * 12 + 5)^2] = 25.0

Their weight status is "Overweight"


Input
150
5 5

Output
25.0
Overweight
*/

function main() {

	final weight = parseInt( readline());
	final inputs = readline().split(' ');
	final feet = parseInt(inputs[0]);
	final inches = parseInt(inputs[1]);

	final bmi = 703 * ( weight / Math.pow( feet * 12 + inches , 2 ));

	print( bmi.fixed( 1 ) );
	if( bmi < 18.5 ) print( "Underweight" );
	else if( bmi <= 24.9 ) print( "Normal" );
	else if( bmi <= 29.9 ) print( "Overweight" );
	else print( "Obese");
}
