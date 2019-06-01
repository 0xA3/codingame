import haxe.ds.ArraySort;

using Lambda;

class Main {
	
	static function createThrow( a:Array<String> ):Throw return { name: a[0], x: Std.parseInt( a[1] ), y: Std.parseInt( a[2] ) };

	static function main() {
		
		final squareMax = Std.parseInt( CodinGame.readline()) / 2;
		// CodinGame.printErr( squareMax );
		
		final n = Std.parseInt( CodinGame.readline());
		final competitors = [for( i in 0...n ) CodinGame.readline()];
		
		final t = Std.parseInt( CodinGame.readline());
		final throws = [for( i in 0...t ) createThrow( CodinGame.readline().split(' '))];
		// for( t in throws ) CodinGame.printErr( t );

		final throwPoints = throws.map( t -> { name: t.name, points: getPoints( squareMax, t.x, t.y )});
		// for( t in throwPoints ) CodinGame.printErr( t );

		final scores:Array<Score> = competitors.map( name -> { name: name, points: throwPoints.filter( score -> score.name == name ).fold(( score, sum ) -> sum += score.points, 0 )} );
		
		ArraySort.sort( scores, ( a, b ) -> {
			if( a.points < b.points ) return 1;
  			else if( a.points > b.points ) return -1;
  			return 0;
		});
		
		for( score in scores ) CodinGame.print( '${score.name} ${score.points}' );
	}

	static function getPoints( squareMax:Float, x:Int, y:Int ):Int {
		if( hitDiamond( squareMax, x, y )) return 15;
		if( hitCircle( squareMax, x, y )) return 10;
		if( hitSquare( squareMax, x, y )) return 5;
		return 0;
	}

	static function hitSquare( squareMax:Float, x:Int, y:Int ):Bool {
		return Math.abs( x ) <= squareMax && Math.abs( y ) <= squareMax;
	}

	static function hitCircle( radius:Float, x:Int, y:Int ):Bool {
		return Math.sqrt( Math.pow( x, 2 ) + Math.pow( y, 2 )) <= radius;
	}
	
	static function hitDiamond( squareMax:Float, x:Int, y:Int ):Bool {
		return Math.abs( x ) + Math.abs( y ) <= squareMax;
	}

}

typedef Throw = {
	final name:String;
	final x:Int;
	final y:Int;
}

typedef Score = {
	final name:String;
	final points:Int;
}
