import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;

typedef Action = {
	final direction:String;
	final attack:String;
}

function main() {
	final championNames = readline().split(' ');
	final n = parseInt( readline() );
	final actions = [for( _ in 0...n ) {
		final inputs = readline().split(" ");
		final direction = inputs[0];
		final attack = inputs[1];
		{ direction: direction, attack:attack };
	}];
	
	final result = process( championNames, actions );
	print( result );
}

function process( championNames:Array<String>, actions:Array<Action> ) {
	final champions = championNames.map( name -> {
		final stats = Constants.championsConstants[name];
		new Champion( name, stats, stats.life );
	});

	for( action in actions ) {
		switch ( action.direction ) {
			case ">": attack( action.attack, champions[0], champions[1] );
			case "<": attack( action.attack, champions[1], champions[0] );
			default: throw "Unknown direction: " + action.direction;
		}
		// final statOutputs = [for( champion in champions ) '${champion.name}\'s life: ${champion.life}, rage: ${champion.rage}' ];
		// printErr( statOutputs.join( ", " ) );
		if( champions[0].life <= 0 || champions[1].life <= 0 ) break;
	}
	
	champions.sort(( c1, c2 ) -> c2.life - c1.life );
	return '${champions[0].name} beats ${champions[1].name} in ${champions[0].numberOfHitsMade} hits';
}

function attack( attack:String, attacker:Champion, opp:Champion ) {
	// printErr( '\n${attacker.name} ${attack.toLowerCase()} ${opp.name}' );

	switch ( attack ) {
		case "PUNCH": attacker.punch( opp );
		case "KICK": attacker.kick( opp );
		case "SPECIAL": attacker.special( opp );
		default: throw "Unknown attack: " + attack;
	}
	opp.rage++;
}
