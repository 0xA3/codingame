package types;

@:structInit
class Mutations {
	public final recycler:() -> Null<RecyclerDto>;
	public final cell:( cell:CellDto ) -> Null<CellDto>;
	public final unit:( Null<UnitDto> ) -> { strength:Int, p:Int, ?angle:Int }
}