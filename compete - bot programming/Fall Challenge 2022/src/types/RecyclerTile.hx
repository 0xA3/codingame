package types;

@:structInit
class RecyclerTile extends RecyclerDto {
	public final spawnAt = -1;
	public final unspawnAt = -1;
	public final events:Array<EventDto>;
}