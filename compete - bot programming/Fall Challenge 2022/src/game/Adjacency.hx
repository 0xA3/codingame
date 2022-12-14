package game;

class Adjacency {
	
	public static final FOUR = [new Coord( -1, 0 ), new Coord( 1, 0 ), new Coord( 0, -1 ), new Coord( 0, 1 )];
	public static final EIGHT = [new Coord( -1, 0 ), new Coord( 1, 0 ), new Coord( 0, -1 ), new Coord( 0, 1 ), new Coord( -1, -1 ),
        new Coord( 1, -1 ), new Coord( -1, 1 ), new Coord( 1, 1 )];
}