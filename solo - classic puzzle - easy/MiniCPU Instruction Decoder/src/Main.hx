import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using xa3.NumberConvert;

function main() {

	final program = readline();

	final result = process( program );
	print( result );
}

var pos = 0;
var program = [];
function process( sProgram:String ) {
	
	final registers = [0, 0, 0, 0];
	program = sProgram.split(" ").map( s -> s.fromHex() );
	pos = 0;
	
	while( pos < program.length ) {
		switch token() {
			// 01 X V: MOV - Load value V into register RX
			case 1:
			registers[token()] = token();
		
			// 02 X Y: ADD - Add register RY to register RX
			case 2:
			final rx = token();
			final ry = token();
			final sum = wrap( registers[ry] + registers[rx] );
			registers[rx] = sum;

			// 03 X Y: SUB - Subtract register RY from register RX
			case 3:
			final rx = token();
			final ry = token();
			final difference = wrap( registers[rx] - registers[ry] );
			registers[rx] = difference;

			// 04 X Y: MUL - Multiply register RX by register RY
			case 4:
			final rx = token();
			final ry = token();
			final product = wrap( registers[rx] * registers[ry] );
			registers[rx] = product;

			// 05 X: INC - Increment register RX by 1
			case 5:
			final rx = token();
			final inc = wrap( registers[rx] + 1 );
			registers[rx] = inc;

			// 06 X: DEC - Decrement register RX by 1
			case 6:
			final rx = token();
			final dec = wrap( registers[rx] - 1 );
			registers[rx] = dec;

			// FF: HLT - Halt execution
			case 0xff:
				break;

			default: throw 'Error: unexpected opcode ${program[pos - 1]}';
		}
	}
	return registers.join( "\n" );
}

function token() return program[pos++];
function wrap( v:Int ) return ( v + 256 ) % 256;