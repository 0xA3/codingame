import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

typedef Operation = {
	final outputName:String;
	final type:String;
	final inputName1:String;
	final inputName2:String;
}

function main() {
		
	final n = parseInt( readline() );
	final m = parseInt( readline() );
	final inputs:Map<String, Array<Int>> = [for( _ in 0...n ) {
		var inputs = readline().split(' ');
		inputs[0] => inputs[1].split( '' ).map( s -> s == "_" ? 0 : 1 );
	}];

	final operations:Array<Operation> = [for( _ in 0...m ) {
		var inputs = readline().split(' ');
		{ outputName: inputs[0], type: inputs[1], inputName1: inputs[2], inputName2: inputs[3] }
	}];

	final result = process( inputs, operations );
	print( result );
}

function process( inputs:Map<String, Array<Int>>, operations:Array<Operation> ) {
	final outputs = operations.map( operation -> processOperation( inputs, operation ));
	return outputs.join( "\n" );
}

function processOperation( inputs:Map<String, Array<Int>>, operation:Operation ) {
	final input1 = inputs[operation.inputName1];
	final input2 = inputs[operation.inputName2];
	final result = input1
		.mapi(( i, _ ) -> processGate( operation.type, input1[i], input2[i] ))
		.map( v -> v == 0 ? "_" : "-" );

	return '${operation.outputName} ${result.join( "" )}';
}

function processGate( type:String, v1:Int, v2:Int ) {
	switch type {
		case "AND": return v1 & v2;
		case "OR": return v1 | v2;
		case "XOR": return v1 ^ v2;
		case "NAND": return 1 - ( v1 & v2 );
		case "NOR": return 1 - (v1 | v2);
		case "NXOR": return 1 - (v1 ^ v2);
		default: throw 'Error: illegal type $type';
	}
}

