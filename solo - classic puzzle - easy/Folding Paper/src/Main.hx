import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final order = readline();
	final side = readline();
	
	final result = process( order, side );
	print( result );
}

function process( order:String, side:String ) {

	var r = 1;
	var l = 1;
	var u = 1;
	var d = 1;

	var current = { r: r, l: l, u: u, d: d }
	final folds = order.split( "" );
	for( fold in folds ) {
		current = switch fold {
			case "R": {
				r: 1,
				l: current.l + current.r,
				u: current.u * 2,
				d: current.d * 2 }
			case "L": {
				r: current.r + current.l,
				l: 1,
				u: current.u * 2,
				d: current.d * 2 }
			case "U": {
				r: current.r * 2,
				l: current.l * 2,
				u: 1,
				d: current.u + current.d }
			case "D": {
				r: current.r * 2,
				l: current.l * 2,
				u: current.u + current.d,
				d: 1 }
			default: current;
		}
	}

	return switch side {
		case "R": current.r;
		case "L": current.l;
		case "U": current.u;
		case "D": current.d;
		default: 0;
	}
}

typedef SidesDataset = {
	final r:Int;
	final l:Int;
	final u:Int;
	final d:Int;
}