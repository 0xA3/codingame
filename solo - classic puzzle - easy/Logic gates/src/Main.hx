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

final gates = [
	"AND" => ( v1, v2 ) -> v1 & v2,
	"OR" => ( v1, v2 ) -> v1 | v2,
	"XOR" => ( v1, v2 ) -> v1 ^ v2,
	"NAND" => ( v1, v2 ) ->  1 - ( v1 & v2 ),
	"NOR" => ( v1, v2 ) ->  1 - ( v1 | v2 ),
	"NXOR" => ( v1, v2 ) ->  1 - ( v1 ^ v2 )
];

function main() {
		
	final n = parseInt( readline() );
	final m = parseInt( readline() );
	final inputs:Map<String, Array<Int>> = [for( _ in 0...n ) {
		var inputs = readline().split(' ');
		inputs[0] => inputs[1].split( '' ).map( s -> lev2Int( s ));
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
	final result = input1.mapi(( i, _ ) -> gates[operation.type]( input1[i], input2[i] )).map( v -> int2Lev( v ));

	return '${operation.outputName} ${result.join( "" )}';
}

function lev2Int( s:String ) return s == "_" ? 0 : 1;
function int2Lev( v:Int ) return v == 0 ? "_" : "-";
