package main.view;

import main.event.EventData;

@:structInit class GraphicsDataset {
	public var events:Array<EventData> = [];
	public var scores:Array<Int> = [];
	public var messages:Array<String> = [];
	public var beacons:Array<Array<Int>> = [];

	public function toString() return 'events: $events, scores: $scores, messages: $messages, beacons: $beacons';
}