package types;

@:structInit
class GlobalDataDto {
	public final width:Int;
	public final height:Int;
	public final units:Array<Array<UnitDto>>;
	public final cells:Array<CellDto>;
}