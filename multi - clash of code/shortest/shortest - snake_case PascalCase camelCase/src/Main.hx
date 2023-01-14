import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.round;
import Std.int;
import Std.parseInt;

/*
THE PROBLEM

Figure out which naming style is the variable.

VARIABLE NAMING CONVENTIONS

snake_case: Words are delimited by an underscore: "variable_one", "variable_two".
PascalCase: Words are delimited by capital letters: "VariableOne", "VariableTwo".
camelCase: Words are delimited by capital letters (except the initial word): "variableOne", "variableTwo".

Note: Only one of the above three naming conventions will be used.
*/

class Main {
	
	static function main() {
		
		final message = readline().split( "" );
		if( message.contains( "_" )) print( "snake_case" );
		else if( message[0].toLowerCase() == message[0] ) print( "camelCase" );
		else print( "PascalCase" );
	}
}
