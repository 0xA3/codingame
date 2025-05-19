import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

typedef RepeatInstruction = {
	var repeat:Int;
	var instruction:String;
}

function main() {

	final expressions = readline().split(" ");

	final result = process( expressions );
	print( result );
}

function process( expressions:Array<String> ) {
	if( expressions[0] != "-" ) expressions.unshift( "+" );

	final iMap:Map<String,Int> = [];
	final repeatInstructions:Array<RepeatInstruction> = [];
	
	var i = 0;
	while( i < expressions.length - 1 ) {
		final op = expressions[i];
		final v = parseInt( expressions[i + 1] );

		final instruction = switch op {
			case "+": 'ADD cgx $v';
			case "-": 'SUB cgx $v';
			default: throw 'Error: Unknown operator: $op';
		}

		if( !iMap.exists( instruction )) {
			repeatInstructions.push({ repeat: 1, instruction: instruction });
			iMap.set( instruction, repeatInstructions.length - 1 );
		} else repeatInstructions[iMap[instruction]].repeat++;

		i += 2;
	}

	var outputs = [];
	for( repeatInstruction in repeatInstructions ) {
		if( repeatInstruction.repeat > 1 ) outputs.push( "REPEAT " + repeatInstruction.repeat );
		outputs.push( repeatInstruction.instruction );
	}

	outputs.push( "EXIT" );
	
	return outputs.join( "\n" );
}
