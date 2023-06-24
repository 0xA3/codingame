package event;

class EventData {
	
	public static final BUILD = 0;
	public static final MOVE = 1;
	public static final FOOD = 2;
	public static final BEACON = 3;

	public var type:Int;
	public var animData:Array<AnimationData> = [];
	public var playerIdx:Int;
	public var cellIdx:Int;
	public var targetIdx:Int;
	public var amount:Int;
	public var path:Array<Int>;

	public function new() {}
}