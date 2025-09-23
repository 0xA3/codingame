import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Main;
using StringTools;

function main() {
	
	final username = readline();

	final result = process( username );
	print( result );
}

function process( username:String ) {
	// Part 1 - Generating a Core Seed
	// 1. Add up all the ASCII values of each of the characters of the string.
	var sum = 0;
	for( i in 0...username.length ) sum += username.charCodeAt( i );

	// 2. Get the length of the characters in the username string.
	final length = username.length;

	// 3. Multiply the two values above with each other, and perform a bitwise
	// XOR operation with the number 20480. The answer will be your SEED, which
	// you will be using in the next part.
	final seed = ( sum * length ) ^ 20480;

	// Part 2 - Generating the 4 Key Segments
	// First Segment: Perform a bitwise AND with your SEED and the number 65535
	// to get the first key segment.
	final firstSegment = seed & 65535;

	// Second Segment: Take your SEED and do a bitwise right shift by 16 bits
	final secondSegment = seed >> 16;

	// Third Segment: Add the first and last ASCII values of your username
	// variable and multiply the sum by the length of the username variable.
	final thirdSegment = ( username.charCodeAt( 0 ) + username.charCodeAt( username.length - 1 ) ) * username.length;

	// final Segment: Add the numerical values of all the segments above
	// (First, Second, and Third segments added together), and take the
	// remainder of this sum when divided by 65536
	final fourthSegment = ( firstSegment + secondSegment + thirdSegment ) % 65536;

	// convert them all to 4 character hexadecimal strings (by removing the 0x)
	//and combine them together to form the key. It should be in the format of:
	// First-Second-Third-Final
	
	return  lpad( StringTools.hex( firstSegment  )) + "-" +
			lpad( StringTools.hex( secondSegment )) + "-" +
			lpad( StringTools.hex( thirdSegment  )) + "-" +
			lpad( StringTools.hex( fourthSegment ));

}

function lpad( value:String, length = 4, padChar = "0" ) {
	var result = value;
	while( result.length < length ) result = padChar + result;
	return result;
}