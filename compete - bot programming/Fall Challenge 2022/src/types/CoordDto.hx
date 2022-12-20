package types;

@:structInit
class CoordDto {
	public static final NO_COORD_DTO:CoordDto = { x: -1, y: -1 }
	
	public final x:Int;
	public final y:Int;
}