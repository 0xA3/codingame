package view;

class GlobalViewDataset {
	
	public final width:Int;
	public final height:Int;
	public final units:Array<Array<UnitDto>>;
	public final cells:Array<CellDto>;

	public function new( width:Int, height:Int, units:Array<Array<UnitDto>>, cells:Array<CellDto> ) {
		this.width = width;
		this.height = height;
		this.units = units;
		this.cells = cells;
	}
}