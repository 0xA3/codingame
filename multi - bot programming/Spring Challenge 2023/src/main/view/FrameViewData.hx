package main.view;

class FrameViewData {
	
	public var type = "";
	public var frame = 0;

	public var duration = 0;
	
	public var graphics:GraphicsDataset;
	public var endScreen:EndScreenDataset;

	public var titleRankingsSprite = "";
	public var displayedText:Array<String> = [];

	public function new() {}

	public function addGraphicsData( graphics:GraphicsDataset ) this.graphics = graphics;
	public function addEndScreenData( endScreen:EndScreenDataset ) this.endScreen = endScreen;

	public function toString() return 'type: $type, frame: $frame, duration: $duration, graphics: $graphics, titleRankingsSprite: $titleRankingsSprite, displayedText: $displayedText';
}