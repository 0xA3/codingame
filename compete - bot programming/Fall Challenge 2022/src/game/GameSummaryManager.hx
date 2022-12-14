package game;

import gameengine.core.GameManager;

class GameSummaryManager {
	
	final lines:Array<String> = [];

	public function new() {}

	public function getSummary() return toString();

	public function clear() lines.splice( 0, lines.length );

    public function addPlayerBadCommand( player:Player, invalidInputException:InvalidInputException ) {
        lines.push( GameManager.formatErrorMessage( 
			'player ${player.index} provided invalid input. Expected "${invalidInputException.expected}"\nGot "${invalidInputException.got}"' ));
    }

    public function addPlayerTimeout( player:Player ) {
        lines.push( GameManager.formatErrorMessage( 'player ${player.index} has not provided an action in time.' ));
    }

    public function addPlayerDisqualified( player:Player ) {
        lines.push( 'player ${player.index} was disqualified.' );
    }

    public function addWait( player:Player ) lines.push( 'player ${player.index} is waiting' );

    public function addRound( round:Int ) lines.push( 'Round $round/${Config.MAX_ROUNDS - 1}' );

    public function addError( error:String ) lines.push( error );

	public function toString() return lines.join( "\n" );

}