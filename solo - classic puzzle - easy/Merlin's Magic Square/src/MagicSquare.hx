class MagicSquare {
	
	static final solvedState = [
		true, true, true,
		true, false, true,
		true, true, true
	];
	
	public static function isSolution( g:Array<Bool> ) {
		if( g.length != solvedState.length ) throw 'Error: grid must have ${solvedState.length} element. Currently has ${g.length}';
		for( i in 0...solvedState.length ) if( solvedState[i] != g[i] ) return false;
		return true;
	}

	public static function press( g:Array<Bool>, button:Int ) {
		switch button {
			case 1: return [
				!g[0], !g[1],  g[2],
				!g[3], !g[4],  g[5],
				 g[6],  g[7],  g[8]];
			case 2: return [
				!g[0], !g[1], !g[2],
				 g[3],  g[4],  g[5],
				 g[6],  g[7],  g[8]];
			case 3: return [
				 g[0], !g[1], !g[2],
				 g[3], !g[4], !g[5],
				 g[6],  g[7],  g[8]];
			case 4: return [
				!g[0],  g[1],  g[2],
				!g[3],  g[4],  g[5],
				!g[6],  g[7],  g[8]];
			case 5: return [
				 g[0], !g[1],  g[2],
				!g[3], !g[4], !g[5],
				 g[6], !g[7],  g[8]];
			case 6: return [
				 g[0],  g[1], !g[2],
				 g[3],  g[4], !g[5],
				 g[6],  g[7], !g[8]];
			case 7: return [
				 g[0],  g[1],  g[2],
				!g[3], !g[4],  g[5],
				!g[6], !g[7],  g[8]];
			case 8: return [
				 g[0],  g[1],  g[2],
				 g[3],  g[4],  g[5],
				!g[6], !g[7], !g[8]];
			case 9: return [
				 g[0],  g[1],  g[2],
				 g[3], !g[4], !g[5],
				 g[6], !g[7], !g[8]];
			default: throw 'Error: button must be between 1 and 9. Was $button';
		}
	}
}