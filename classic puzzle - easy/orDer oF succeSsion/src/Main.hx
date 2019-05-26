/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/

using Lambda;

class Main {
	
	static function main() {

		final n = Std.parseInt( CodinGame.readline() );
		final persons:Array<Person> = [];
		for( i in 0...n ) {
			var inputs = CodinGame.readline().split(' ');
			final person = {
				name: inputs[0],
				parent: inputs[1],
				birth: Std.parseInt( inputs[2] ),
				death: inputs[3],
				religion: inputs[4],
				gender: inputs[5] == "M" ? Male : Female
			}
			CodinGame.printErr( inputs );
		}


		// Write an action using console.log()
		// To debug: console.error('Debug messages...');

		CodinGame.print('Elizabeth');
	}

}

typedef Person = {
	final name:String;
	final parent:String;
	final birth:Int;
	final death:String;
	final religion:String;
	final gender:Gender;
}

enum abstract Gender(String) {
	var Male = "M";
	var Female = "F";
}
