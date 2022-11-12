import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using xa3.StringUtils;

function main() {

	final height = parseInt( readline());
	final width = parseInt( readline());
	final material = readline();
	
	for( i in 0...height ) print( material.repeat( width ));

}
