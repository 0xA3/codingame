package types;

@:structInit
class FrameData extends FrameDataDto {
	public final previous:FrameData;
	public final units:Array<Array<UnitDto>>;
	public final cells:Array<CellDto>;
	public final recyclers:Array<RecyclerDto>;
	public final recyclerTiles:Array<RecyclerTile>;
}