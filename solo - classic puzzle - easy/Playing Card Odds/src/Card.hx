class Card {
	
	public final rank:String;
	public final suit:String;

	public function new( rank:String, suit:String ) {
		this.rank = rank;
		this.suit = suit;
	}

	public function toString() return '$rank$suit';
}