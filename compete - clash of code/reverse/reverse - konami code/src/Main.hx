import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	var comboCode = readline();
	if( comboCode == "KONAMI CODE!" ) {
		print( "^^vv<<>>BA" );
		return;
	}
	comboCode = comboCode.replace( "L", "<" );
	comboCode = comboCode.replace( "D", "v" );
	comboCode = comboCode.replace( "P", "A" );
	comboCode = comboCode.replace( "K", "B" );
	comboCode = comboCode.replace( "R", ">" );
	comboCode = comboCode.replace( "U", "^" );

	print( comboCode );
}
