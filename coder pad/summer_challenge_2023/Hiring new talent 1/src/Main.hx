import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

@:keep function bestRemainingMutant( mutantScores:Dynamic, threshold:Int ) {
	final names = Reflect.fields( mutantScores );
	var maxScore = 0;
	var maxName = "";
	for( name in names ) {
		final score = Reflect.field( mutantScores, name );
		if( score > maxScore && score < threshold ) {
			maxName = name;
			maxScore = score;
		}
	}

	return maxName;
}
