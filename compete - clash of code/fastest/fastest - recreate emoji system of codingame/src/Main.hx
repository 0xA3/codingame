import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using StringTools;

/*
In this Clash you have to recreate the emoji system of CodinGame.
For example, if you type this in the chat you get:
:slight_smile: --> :)
:disappointed: --> :(
:loud_laugh: --> XD
:open_mouth: --> :o
:stuck_out_tongue: --> :p

Input
This is SOO easy :loud_laugh:

This is SOO easy XD
*/

function main() {

	var s = readline();

	print( s
		.replace( ":slight_smile:", ":)" )
		.replace( ":disappointed:",":(" )
		.replace( ":loud_laugh:","XD" )
		.replace( ":open_mouth:",":o" )
		.replace( ":stuck_out_tongue:",":p" )
	);
}
