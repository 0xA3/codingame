import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using xa3.StringUtils;

/*
My mom is convinced she is being hunted by the FBI, thus she uses a code when she sends me messages.
She told me to use this conversion table :

a -> c         A -> C
b -> d         B -> D
c -> e         C -> E
.    .         .    .
.    .         .    .
x -> z         X -> Z
y -> a         Y -> A
z -> b         Z -> B

*/

function main() {

	final message = readline();
	
	print( message.caesarShift( 2 ));
}
