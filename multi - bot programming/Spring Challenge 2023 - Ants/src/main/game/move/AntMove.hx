package main.game.move;

class AntMove {

	var from:Int;
	var to:Int;

	public function new( from:Int, to:Int ) {
		this.from = from;
		this.to = to;
	}

    public function getFrom() {
        return from;
    }

    public function setFrom( from:Int ) {
        this.from = from;
    }

    public function getTo() {
        return to;
    }

    public function setTo( to:Int ) {
        this.to = to;
    }

    public function hashCode() {
		final prime = 31;
		var result = 1;
		result = prime * result + from;
        result = prime * result + to;
        return result;
    }

    public function equals( other:AntMove ) {
        if (this == other) return true;
        if (other == null) return false;
        return from == other.from && to == other.to;
    }
}