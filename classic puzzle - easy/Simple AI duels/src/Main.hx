import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import TAction;
import TCommand;

using Lambda;
using StringTools;

function main() {

	final nbturns = parseInt( readline() );
	var inputs = readline().split(' ');
	final n = parseInt( inputs[0] );
	final ai1 = inputs[1];
	final commands1 = [for( i in 0...n ) readline()];
	
	var inputs = readline().split(' ');
	final m = parseInt( inputs[0] );
	final ai2 = inputs[1];
	final commands2 = [for( i in 0...m ) readline()];
			
	final result = process( nbturns, ai1, commands1, ai2, commands2  );
	print( result );
}

function process( turns:Int, name1:String, inputCommands1:Array<String>, name2:String, inputCommands2:Array<String> ) {
	
	final commands1 = inputCommands1.map( c -> parseCommand( c ));
	// trace( commands1 );
	final commands2 = inputCommands2.map( c -> parseCommand( c ));
	// trace( commands2 );
	
	final lgc = new LinearCongruentalGenerator( 12 );
	final ais = [new Ai( name1, commands1, lgc ), new Ai( name2, commands2, lgc )];
	
	for( t in 0...turns ) {
		final actions = [];
		for( i in 0...ais.length ) {
			final me = ais[i];
			final opponent = ais[1 - i];
			actions[i] = me.execute( t, opponent );
		}
		
		switch actions {
			case [Cooperate, Cooperate]:
				ais[0].score += 2;
				ais[1].score += 2;
			case [Defect, Defect]:
				ais[0].score += 1;
				ais[1].score += 1;
			case [Cooperate, Defect]:
				ais[1].score += 3;
			case [Defect, Cooperate]:
				ais[0].score += 3;
			default: throw 'Error: combination of ${actions[0]} - ${actions[1]} not possible';
		}
		
		// trace( '$t: actions $actions  score ${ais[0].name}: ${ais[0].score}  ${ais[1].name}: ${ais[1].score}\n' );

		for( i in 0...ais.length ) ais[i].addAction( actions[i] );
	}

	if( ais[0].score > ais[1].score ) return ais[0].name;
	if( ais[0].score < ais[1].score ) return ais[1].name;
	return "DRAW";
}

function parseCommand( command:String ) {
	// trace( 'command $command' );
	final parts = command.split(" ");

	if( parts[0] == "*" ) return Always( parseAction( parts[1] ));
	if( parts[0] == "ME" && parts[1] == "-1" ) return MyPrevious( parseAction( parts[2] ), parseAction( parts[3] ));
	if( parts[0] == "OPP" && parts[1] == "-1" ) return OpponentPrevious( parseAction( parts[2] ), parseAction( parts[3] ));
	if( parts[0] == "ME" && parts[1] == "MAX" ) return MyMost( parseAction( parts[2] ), parseAction( parts[3] ));
	if( parts[0] == "OPP" && parts[1] == "MAX" ) return OpponentMost( parseAction( parts[2] ), parseAction( parts[3] ));
	if( parts[0] == "OPP" && parts[1] == "LAST" ) return OpponentLast( parseInt( parts[2] ), parseAction( parts[3] ), parseAction( parts[4] ));
	if( parts[0] == "START" ) return Start( parseAction( parts[1] ));
	if( parts[0] == "ME" && parts[1] == "WIN" ) return MyWin( parseAction( parts[2] ));

	return Always( Cooperate );
}

function parseAction( s:String ) {
	switch s {
		case "C": return Cooperate;
		case "D": return Defect;
		case "RAND": return Random;
		default: throw 'Error: no action $s';
	}
}
