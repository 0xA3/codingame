using Lambda;

class Garden {
	
	final columns:Array<Int>;

	public function new( columns:Array<Int> ) this.columns = columns;
	public function removeCarrot( column:Int ) columns[column - 1]--;

	public function getPerimeter() {
		
		final totalCarrots = columns.fold(( carrots, sum ) -> sum + carrots, 0 );
		if( totalCarrots == 0 ) return 0;

		final perimeters = columns.mapi(( i, carrots ) -> {
			final left = i == 0 ? carrots : columns[i - 1] < carrots ? carrots - columns[i - 1] : 0;
			final right = i == columns.length - 1 ? carrots : columns[i + 1] < carrots ? carrots - columns[i + 1] : 0;
			final top = carrots > 0 ? 1 : 0;
			final bottom = carrots > 0 ? 1 : 0;
			return left + right + top + bottom;
		});
		
		final sum = perimeters.fold(( p, sum ) -> sum + p, 0 );

		return sum;
	}
}
