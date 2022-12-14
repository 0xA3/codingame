package event;

import game.Coord;

class EventData {
	
	public static final BUILD = 0;
    public static final MOVE = 1;
    public static final JUMP = 2;
    public static final SPAWN = 3;
    public static final FIGHT = 4;
    public static final CELL_DAMAGE = 7;
    public static final RECYCLER_FALL = 8;
    public static final CELL_OWNER_SWAP = 9;
    public static final UNIT_FALL = 10;
    public static final MATTER_COLLECT = 11;

    public var type:Int;
    public final animData:Array<AnimationData> = [];
    
    public var playerIndex:Int;
	public var amount:Int;
    public var coord:Coord;
	public var target:Coord;

	public function new() { }
}