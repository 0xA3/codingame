package types;

@:structInit
class GlobalData extends GlobalDataDto {
	public final players:Array<PlayerInfo>;
	public final playerCount:Int;
}