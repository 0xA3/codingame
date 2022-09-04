import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseFloat;
import Std.parseInt;

/*
The dose of capecitabine chemotherapy is prescribed based on body surface area.

Body surface area (in square meters) is best calculated from the weight (in kg) and the height (in cm) with the Mosteller formula:

Body surface area = square root ( height * weight / 3600 )

The calculated total daily dose of capecitabine is 2500 mg per square meter, which is then split into two doses (morning and night).

Given a patient's height in cm and weight in kg, output the calculated amount of capecitabine to prescribe, per dose. Truncate answers to an integer.

Input
1
175 89.2

2602
*/

function main() {

	final n = parseInt( readline());
	final patients = [for( _ in 0...n ) {
		final inputs = readline().split(' ');
		[parseFloat( inputs[0] ), parseFloat( inputs[1] )];
	}];
	final surfaceAreas = patients.map( hw -> Math.sqrt( hw[0] * hw[1] / 3600 ));
	final doses = surfaceAreas.map( surfaceArea -> int( 2500 * surfaceArea / 2 ));
	
	print( doses.join( "\n" ));
}
