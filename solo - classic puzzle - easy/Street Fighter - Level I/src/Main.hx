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

typedef ChampionStats = {
	final life:Int;
	final punch:Int;
	final kick:Int;
	final special:( Champion, Champion )->Void;
}

final championsStatsMap:Map<String, ChampionStats> = [
	"KEN" => { life: 25, punch: 6, kick: 5, special: ( attacker, opp ) -> {
		opp.getHit( attacker.state.rage * 3 );
	}},
	"RYU" => { life: 25, punch: 4, kick: 5 , special: ( attacker, opp ) -> {
		opp.getHit( attacker.state.rage * 4 );
	}},
	"TANK" => { life: 50, punch: 2, kick: 2 , special: ( attacker, opp ) -> {
		opp.getHit( attacker.state.rage * 2 );
	}},
	"VLAD" => { life: 30, punch: 3, kick: 3 , special: ( attacker, opp ) -> {
		opp.getHit( 2 * ( attacker.state.rage + opp.state.rage ));
		opp.state.rage = 0;
	}},
	"JADE" => { life: 20, punch: 2, kick: 7 , special: ( attacker, opp ) -> {
		opp.getHit( attacker.numberOfHitsMade * attacker.state.rage );
	}},
	"ANNA" => { life: 18, punch: 9, kick: 1 , special: ( attacker, opp ) -> {
		opp.getHit( attacker.damageReceived * attacker.state.rage );
	}},
	"JUN" => { life: 60, punch: 2, kick: 1 , special: ( attacker, opp ) -> {
		opp.getHit( attacker.state.rage );
		attacker.state.life += attacker.state.rage;
	}}
];

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
		final stats = championsStatsMap[name];
		final state = new State( stats.life, 0 );
		new Champion( name, stats, state );
	});

	for( action in actions ) {
		switch ( action.direction ) {
			case ">": act( action.attack, champions[0], champions[1] );
			case "<": act( action.attack, champions[1], champions[0] );
			default: throw "Unknown direction: " + action.direction;
		}
		final statOutputs = [for( champion in champions ) '${champion.name}\'s life: ${champion.state.life}, rage: ${champion.state.rage}' ];
		printErr( statOutputs.join( ", " ) );
		if( champions[0].state.life <= 0 ) break;
		if( champions[1].state.life <= 0 ) break;
	}
	
	champions.sort(( c1, c2 ) -> c2.state.life - c1.state.life );
	return '${champions[0].name} beats ${champions[1].name} in ${champions[0].numberOfHitsMade} hits';
}

function act( attack:String, attacker:Champion, opp:Champion ) {
	printErr( '\n${attacker.name} ${attack.toLowerCase()} ${opp.name}' );

	switch ( attack ) {
		case "PUNCH": attacker.punch( opp );
		case "KICK": attacker.kick( opp );
		case "SPECIAL": attacker.special( opp );
		default: throw "Unknown attack: " + attack;
	}
	opp.state.rage++;
}
