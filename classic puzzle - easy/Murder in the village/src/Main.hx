import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.min;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

class Main {
	
	static function main() {
		
		final n = parseInt( readline() );
		final statements = [for( i in 0...n ) readline()];
		
		final result = process( statements );
		print( result );
	}

	static function process( lines:Array<String> ) {
		
		// trace( "\n" + a.join( "\n" ));
		final statements = parseStatements( lines );
		
		final persons = statements.map( statement -> statement.person );
		final places = [];
		for( statment in statements ) {
			final place = statment.place;
			if( !places.contains( place )) places.push( place );
		}

		final seens = checkSeen( statements );
		final notSeenPersons = [];
		for( i in 0...seens.length ) if( !seens[i] ) notSeenPersons.push( statements[i].person );
		if( notSeenPersons.length == 1 ) return '${notSeenPersons[0]} did it!';

		final alones = statements.map( statement -> statement.otherPersons.length == 0 ? true : false );
		
		final notAlonesNotSeens = [for( i in 0...alones.length ) !alones[i] && !seens[i]];
		final notAloneNotSeenPersons = [];
		for( i in 0...notAlonesNotSeens.length ) if( notAlonesNotSeens[i] ) notAloneNotSeenPersons.push( statements[i].person );
		if( notAloneNotSeenPersons.length == 1 ) return '${notAloneNotSeenPersons[0]} did it!';

		final peopleInPlaces = getPeopleInPlaces( places, statements );
		for( i in 0...alones.length ) {
			if( alones[i] ) {
				final placeOfPerson = statements[i].place;
				final personsAtPlace = peopleInPlaces[placeOfPerson].length;
				if( personsAtPlace > 1 ) return return '${statements[i].person} did it!';
			}
		}

		return "It was me!";

	}

	static function parseStatements( lines:Array<String> ) {

		final eregWith = ~/(\w+): I was in the (\w+) with (\w+)( and )?(\w+)?( and )?(\w+)?( and )?(\w+)?( and )?(\w+)?( and )?(\w+)?( and )?(\w+)?/;
		final eregAlone = ~/(\w+): I was in the (\w+), alone/;

		final statements:Array<Statement> = [];
		for( sentence in lines ) {
			// trace( sentence + eregAlone.match( sentence ) +  "\n" );
			
			if( eregAlone.match( sentence )) {
				statements.push({ person: eregAlone.matched( 1 ), place: eregAlone.matched( 2 ), otherPersons: [] });
			} else if( eregWith.match( sentence )) {
				
				final otherPersons:Array<String> = [eregWith.matched( 3 )];
				var i = 4;
				while( true ) {
					try {
						final otherPerson = eregWith.matched( i );
						// trace( '$i $otherPerson' );
						if( otherPerson != null && i % 2 != 0 ) otherPersons.push( otherPerson );
						i++;
					} catch( e ) {
						// trace( '$i $e' );
						break;
					}
				}
				
				statements.push({
					person: eregWith.matched( 1 ),
					place: eregWith.matched( 2 ),
					otherPersons: otherPersons
				});
			}
		}
		return statements;
	}

	static function checkSeen( statements:Array<Statement> ) {
		final seen = [];
		for( statement in statements ) {
			var isSeen = false;
			for( otherStatement in statements ) {
				if( otherStatement.otherPersons.contains( statement.person )) {
					isSeen = true;
					break;
				}
			}
			seen.push( isSeen );
		}
		return seen;
	}

	static function getPeopleInPlaces( places:Array<String>, statements:Array<Statement> ) {
		final peopleInPlaces:Map<String, Array<String>> = [];
		for( place in places ) {
			peopleInPlaces.set( place, getPeopleInPlace( place, statements ));
		}
		return peopleInPlaces;
	}

	static function getPeopleInPlace( place:String, statements:Array<Statement> ) {
		final peopleInPlace = [];
		for( statement in statements) {
			if( statement.place == place ) peopleInPlace.push( statement.person );
		}
		return peopleInPlace;
	}

}

typedef Statement = {
	final person:String;
	final place:String;
	final otherPersons:Array<String>;
}
