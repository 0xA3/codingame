package game.action.actions;

import game.action.ActionType;

class LineAction extends Action {
	
	var from:Int;
	var to:Int;
	var ants:Int;

	public function new( from:Int, to:Int, ants:Int ) {
		super( LINE );
		this.from = from;
		this.to = to;
		this.ants = ants;
	}

    public function getFrom() return from;
    public function setFrom( from:Int ) this.from = from;

    public function getTo() return to;
    public function setTo( to:Int ) this.to = to;

    public function getAnts() return ants;
    public function setAnts( ants:Int ) this.ants = ants;
}