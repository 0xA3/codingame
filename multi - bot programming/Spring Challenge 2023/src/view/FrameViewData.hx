package view;

import event.EventData;

class FrameViewData {
	
	public var type = "";
	public var frame = 0;

	public var duration = 0;
	
	public var events:Array<EventData> = [];
	public var scores:Array<Int> = [];
	public var messages:Array<String> = [];
	
	public var beacons:Array<Array<Int>> = [];

	public var titleRankingsSprite = "";
	public var displayedText:Array<String> = [];

	public function new() {}

	public function toString() return 'type: $type, frame: $frame, duration: $duration, events: $events, scores: $scores, messages: $messages, beacons: $beacons, titleRankingsSprite: $titleRankingsSprite, displayedText: $displayedText';
}