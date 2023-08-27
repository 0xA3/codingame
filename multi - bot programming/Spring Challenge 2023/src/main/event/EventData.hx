package main.event;

class EventData {
	
	public var type:Int;
	public var animData:Array<AnimationData> = [];
	public var playerIdx:Int;
	public var cellIdx:Int;
	public var targetIdx:Int;
	public var amount:Int;
	public var path:Array<Int>;

	public var double = false;
	public var crisscross = false;

	public function new() {}

	public function toString() return 'type: $type, animData: $animData, playerIdx: $playerIdx, cellIdx: $cellIdx, targetIdx: $targetIdx, amount: $amount, path: $path';
}