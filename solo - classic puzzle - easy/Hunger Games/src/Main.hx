import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.ceil;
import Std.parseInt;
import Std.int;
import Std.string;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final tributes = parseInt( readline() );
		final playerNames = [for( i in 0...tributes ) readline()];
		
		final turns = parseInt( readline() );
		final infos = [for( i in 0...turns ) readline()];		
		
		final result = process( playerNames, infos );
		print( result );
	}

	static function process( playerNames:Array<String>, infos:Array<String> ) {
		
		playerNames.sort( stringSort );

		final kills:Array<Kill> = infos.map( kill -> parseKill( kill ));
		
		final killerOf:Map<String, String> = [];
		final victimsOf:Map<String, Array<String>> = [];
		for( kill in kills ) {
			final killer = kill.name;
			if( victimsOf.exists( killer )) {
				victimsOf[killer] = victimsOf[killer].concat( kill.victims );
			} else {
				victimsOf.set( killer, kill.victims );
			}
			
			for( victim in kill.victims ) {
				killerOf.set( victim, killer );
			}
		}

		for( v in victimsOf ) v.sort( stringSort );

		final results = playerNames.map( playerName -> {
			final victims = victimsOf.exists( playerName ) ? victimsOf[playerName].join( ", " ) : "None";
			final killer = killerOf.exists( playerName ) ? killerOf[playerName] : "Winner";
			return 'Name: $playerName\nKilled: $victims\nKiller: $killer';
		});
		
		// trace( playerNames );

		return results.join( "\n\n" );
	}

	static function parseKill( kill:String ) {
		final parts = kill.split( " killed " );
		final victims = parts[1].split( ", " );
		return { name: parts[0], victims: victims };
	}

	static function stringSort( a:String, b:String ) {
		if( a > b ) return 1;
		if( a < b ) return -1;
		return 0;
	}
}

typedef Kill = {
	final name:String;
	final victims:Array<String>;
}