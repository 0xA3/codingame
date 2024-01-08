package game;

class Recycler {
	
	public static final NO_RECYCLER = new Recycler( new Coord( -1, -1 ), Player.NO_PLAYER );

	public final coord:Coord;
	public final owner:Player;

	public function new( coord:Coord, owner:Player ) {
		this.coord = coord;
		this.owner = owner;
	}

	public function getOwnerIdx() return owner.index;
}