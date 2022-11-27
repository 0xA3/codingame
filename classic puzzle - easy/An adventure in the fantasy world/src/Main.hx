import haxe.macro.Expr.Case;
import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import Std.int;

using Lambda;
using StringTools;

function main() {

	final path = readline();
	final n = parseInt( readline() );
	final events = [for( _ in 0...n ) readline()];
	
	final result = process( path, events );
	print( result );
}

function process( path:String, eventStrings:Array<String> ) {
	final directions = path.split( "" );
	final events = parseEvents( eventStrings );
	
	var x = 0;
	var y = 0;
	var gold = 50;
	
	for( step in directions ) {
		switch step {
			case "U": y--;
			case "L": x--;
			case "D": y++;
			case "R": x++;
		}
		final sPos = '$y $x';
		if( events.exists( sPos )) {
			switch events[sPos] {
				case Enemy( type ):
					switch type {
						case Goblin:
							if( gold >= 50 ) gold -= 50;
							else return'$y $x ${gold}G goblin';
						case Slime:
							return'$y $x ${gold}G slime';
					}
				case Money( amount ):
					gold += amount;
					events.remove( sPos );
			}
		}
	}
	return 'GameClear $y $x ${gold}G';
}

function parseEvents( eventStrings:Array<String> ) {
	final events:Map<String, TEvent> = [];
	for( s in eventStrings ) {
		final parts = s.split(" ");
		final position = '${parts[0]} ${parts[1]}';
		final event = parseEvent( parts[2], parts[3] );
		events.set( position, event );
	}
	return events;
}

function parseEvent( s1:String, s2:String ) {
	final event = switch s1 {
		case "enemy":
			final enemyType = switch s2 {
				case "goblin": Goblin;
				case "slime": Slime;
				default: throw 'Error unknown enemy ${s2}';
			}
			return Enemy( enemyType );
		case "money":
			final amount = parseInt( s2.substr(0, s2.length - 1));
			return Money( amount );
		default: throw 'Error: unknown eventType ${s1}';
	}
	return event;
}

typedef Event = {
	final position:String;
	final type:TEvent;
}

enum TEvent {
	Enemy( type:TEnemy );
	Money( amount:Int );
}

enum TEnemy {
	Goblin;
	Slime;
}
