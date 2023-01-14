import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

/*
Print a vertical banner with 3 columns.

You will be given one line of input which contains the message to be printed on the banner.

The left column contains the input text from top to bottom.
The middle column must be filled with space characters.
The right column contains the input text from bottom to top.

Input
Hello World

Output
H d
e l
l r
l o
o W
   
W o
o l
r l
l e
d H

*/

function main() {

	final n = readline().split( "" );
	final n2 = n.copy();
	n2.reverse();
	
	final lines = [];
	for( i in 0...n.length ) {
		lines.push( '${n[i]} ${n2[i]}' );
	}
	
	print( lines.join( "\n" ) );
}
