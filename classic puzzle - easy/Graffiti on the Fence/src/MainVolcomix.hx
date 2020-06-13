import haxe.ds.Vector;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

class MainVolcomix {
	
	static function main() {
		
		final fenceLength = parseInt(readline());
		final reportCount = parseInt(readline());
		// final reports = Array.from({ length: reportCount }, () -> readline().split(' ').map( Number ));
		final reports:Array<Array<Int>> = [for( i in 0...reportCount ) readline().split(' ')].map( a -> [parseInt( a[0] ), parseInt( a[1] )]);
		reports.sort((a, b) -> a[0] - b[0] );
		
		// printErr( reports );

		var i = 0;
		var allPainted = true;
		for( report in reports ) {
			final st = report[0];
			final ed = report[1];
			// printErr( 'report $st $ed' );
			if (st > i) {
				// printErr( 'st > i   $st > $i' );
				print( '$i $st' );
				allPainted = false;
			}
			// printErr( 'i = max( $i, $ed )  ${Std.int( Math.max( i, ed ))}' );
			i = Std.int( Math.max( i, ed ));
		}
		if( i < fenceLength ) {
			// printErr( 'i < fenceLength' );
			print( '$i $fenceLength' );
			allPainted = false;
		}
		if( allPainted ) {
			print( 'All painted' );
		}
	}
	
}

/*
const fenceLength = parseInt(readline());
const reportCount = parseInt(readline());
const reports = Array.from({ length: reportCount }, () => readline().split(' ').map(Number));
reports.sort(([st1], [st2]) => st1 - st2);

let i = 0;
let allPainted = true;
for (const [st, ed] of reports) {
    if (st > i) {
        console.log(i, st);
        allPainted = false;
    }
    i = Math.max(i, ed);
}
if (i < fenceLength) {
    console.log(i, fenceLength);
    allPainted = false;
}
if (allPainted) {
    console.log('All painted');
}

*/