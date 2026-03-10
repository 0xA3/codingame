import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

// Cookie: 1 egg + 100 g flour + 150 g sugar + 50 g butter
// Cake: 3 eggs + 180 g flour + 100 g sugar + 100 g butter
// Muffin: 2 eggs + 150 g flour + 100 g sugar + 150 g butter

final recipeNames = ["Cake", "Cookie", "Muffin"];

final recipeAmounts = [
	[3, 180, 100, 100],
	[1, 100, 150, 50],
	[2, 150, 100, 150]
];

function main() {

	final inputs = readline().split(' ');
	final e = parseInt( inputs[0] );
	final f = parseInt( inputs[1] );
	final s = parseInt( inputs[2] );
	final b = parseInt( inputs[3] );

	final result = process( e, f, s, b );
	print( result );
}

function process( eggs:Int, flour:Int, sugar:Int, butter:Int ) {

	var mostId = 0;
	var mostNumber = 0;
	for( i in 0...recipeNames.length ) {
		var numEggs = int( eggs / recipeAmounts[i][0] );
		var numFlour = int( flour / recipeAmounts[i][1] );
		var numSugar = int( sugar / recipeAmounts[i][2] );
		var numButter = int( butter / recipeAmounts[i][3] );

		var num = min( numEggs, min( numFlour, min( numSugar, numButter )));
		if( num > mostNumber ) {
			mostId = i;
			mostNumber = num;
		}
	}
	
	return '$mostNumber ${recipeNames[mostId]}';
}

function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;
