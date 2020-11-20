package game.contexts;

import game.data.Action;
import Std.parseInt;

class ParseAction {
	
	public static inline function parse( inputs:Array<String> ) {
		return new Action(
			parseInt( inputs[0] ), // the unique ID of this spell or recipe
			Action.createType( inputs[1] ), // in the first league: BREW, later: CAST, OPPONENT_CAST, LEARN, BREW
			parseInt( inputs[2] ), // tier-0 ingredient change
			parseInt( inputs[3] ), // tier-1 ingredient change
			parseInt( inputs[4] ), // tier-2 ingredient change
			parseInt( inputs[5] ), // tier-3 ingredient change
			parseInt( inputs[6] ), // the price in rupees if this is a potion
			parseInt( inputs[7] ), // the index in the tome if this is a tome spell, equal to the read-ahead tax
			parseInt( inputs[8] ), // the amount of taxed tier-0 ingredients you gain from learning this spell
			inputs[9] != '0', // in the first league: always 0, later: 1 if this is a castable player spell
			inputs[10] != '0' // for the first two leagues: always 0; later: 1 if this is a repeatable player spell
		);
	}
}