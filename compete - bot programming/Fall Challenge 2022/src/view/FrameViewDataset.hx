package view;

import event.EventData;
import view.PlayerDto;

using xa3.ArrayUtils;

class FrameViewDataset {
	
	public static final NO_FRAME_VIEW_DATASET = new FrameViewDataset( [], [] );

	public final players:Array<PlayerDto>;
    public final events:Array<EventData>;
	public var duration = 0;

	public function new( players:Array<PlayerDto>, events:Array<EventData> ) {
		this.players = players;
		this.events = events;
	}

	public function clear() {
		players.clear();
		events.clear();
		duration = 0;
	}
}