package types;

@:structInit
class UnitDto {
	public final strength:Int; // Amount at end of turn
	public final coord:CoordDto;

	/* Computed client side */
	public var stayed:Array<UnitHistory> = [];
	public var foe:UnitDto;
}