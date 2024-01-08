package view;

import event.EventData;
import view.PlayerDto;
import viewer.CellDataset;

using xa3.ArrayUtils;

class FrameViewDataset {
	
	public static final NO_FRAME_VIEW_DATASET = new FrameViewDataset( [], [], [] );

	public final players:Array<PlayerDto>;
    public final events:Array<EventData>;
	public final cellDatasets:Array<CellDataset>;
	public var duration = 0;

	public function new( players:Array<PlayerDto>, events:Array<EventData>, cellDatasets:Array<CellDataset> ) {
		this.players = players;
		this.events = events;
		this.cellDatasets = cellDatasets;
	}
}