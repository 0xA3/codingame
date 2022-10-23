import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

function main() {

	final number1 = parseInt( readline());
	final equation = readline();
	final number2 =  parseInt( readline());
	
	final result = switch equation {
		case "x": number1 * number2;
		case "+": number1 + number2;
		case "-": number1 - number2;
		case "/": number1 / number2;
		default: throw 'Error: undefined equation sign $equation';
	}
	
	print( result );
}
