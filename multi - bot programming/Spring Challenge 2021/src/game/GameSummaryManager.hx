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

    public function addCutTree( player:Player, cell:Cell, score:Int ) {
        lines.push( 'player ${player.index} is ending their tree life on cell ${cell.index}, scoring $score points' );
    }

    public function addGrowTree( player:Player, cell:Cell ) {
        lines.push( 'player ${player.index} is growing a tree on cell ${cell.index}' );
    }

    public function addPlantSeed( player:Player, targetCell:Cell, sourceCell:Cell ) {
        lines.push( 'player ${player.index} is planting a seed on cell ${targetCell.index} from cell ${sourceCell.index}' );
    }

    public function addWait( player:Player ) lines.push( 'player ${player.index} is waiting' );

    public function addRound( round:Int ) lines.push( 'Round $round/${Config.MAX_ROUNDS - 1}' );

    public function addError( error:String ) lines.push( error );

    public function addSeedConflict( seed:Seed ) lines.push( 'Seed conflict on cell ${seed.targetCell}' );

	public function toString() return lines.join( "\n" );

    public function addRoundTransition( round:Int ) {
        lines.push( 'Round $round ends' );
        
        if ( round + 1 < Config.MAX_ROUNDS ) {
            lines.push( 'The sun is now pointing towards direction ${( round + 1 ) % 6}' );
            lines.push( 'Round ${round + 1} starts' );
        }
    }

    public function addGather( player:Player, given:Int ) lines.push( 'player ${player.index} has collected $given sun points' );

}