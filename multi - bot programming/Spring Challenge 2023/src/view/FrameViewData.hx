package view;

import event.EventData;

class FrameViewData {
	
	public var events:Array<EventData> = [];
	public var scores:Array<Int> = [];
	public var messages:Array<String> = [];
	
	public var beacons:Array<Array<Int>> = [];

	public var titleRankingsSprite = "";
	public var displayedText:Array<String> = [];

	public function new() {}
}