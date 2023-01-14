import CodinGame.printErr;
import Std.int;

class Denvash implements IKnight {
	
	static final COLDER = "COLDER";
	static final WARMER = "WARMER";
	static final SAME = "SAME";
	static final UNKNOWN = "UNKNOWN";
	
	final warm:Zone;
	final cold:Zone;
	final current:Zone;

	final width:Int;
	final height:Int;
	var x:Int;
	var y:Int;
	var lastX:Int;
	var lastY:Int;
	var foundX = false;
	var firstChance = true;
	var outside = false;
	var bombDir = UNKNOWN;

	public function new( w:Int, h:Int, n:Int, x0:Int, y0:Int ) {
		width = w;
		height = h;
		lastX = x = x0;
		lastY = y = y0;
        current = new Zone( 0, width - 1 );
        cold = new Zone( 0, width - 1 );
        warm = new Zone( 0, width - 1 );
	}

	public function move( bombDir:String ) {
		#if sim	printErr( bombDir ); #end
		
		final tmpX = x;
		final tmpY = y;
		
		// final currentOutput = [for( gx in 0...width ) gx >= current.low && gx <= current.high ? "x" : "."];
		final coldOutput = [for( gx in 0...width ) gx >= cold.low && gx <= cold.high ? "x" : "."].join( "" );
		final warmOutput = [for( gx in 0...width ) gx >= warm.low && gx <= warm.high ? "x" : "."].join( "" );
		final xOutput = [for( gx in 0...width ) gx == x ? "O" : "-"].join( "" );
		printErr( '$coldOutput colder\n$warmOutput warmer\n$xOutput $x' );

		switch bombDir {
			case WARMER: current.updateZone( warm );
			case COLDER: current.updateZone( cold );
			case SAME: if( !firstChance ) if( !found()) throw 'Error with $SAME. Position not found.';
		}
		if( current.low >= current.high ) if( !found()) throw 'Error ${current.low} >= ${current.high}. Position not found.';
		
		firstChance = false;
		if( foundX ) y = get( y, height - 1 );
		else x = get( x, width - 1 );
		lastX = tmpX;
		lastY = tmpY;

		return '$x $y';
	}

	function found() {
		final tmpX = x;
		final tmpY = y;
		if( foundX ) {
			y = int(( current.low + current.high ) / 2 );
			printErr( 'found y $y' );
		} else {
			x = int(( current.low + current.high ) / 2 );
			foundX = true;
            current.updateLowHigh( 0, height - 1 );
            warm.updateZone( current );
            cold.updateZone( current );
			printErr( 'found x $x' );
		}
		firstChance = true;
		return ( x == tmpX && y== tmpY );
	}

	function get( value:Int, limit:Int ) {
		var low = current.low;
		var high = current.high;
		var give = low + high - value;
		printErr( 'get value $value, limit $limit' );
		printErr( 'low: $low, high: $high, give: $give, outside: $outside' );
		if( outside ) {
			if( value == 0 ) give = int(( give - 0 ) / 2 );
			else if( value == limit ) give = int(( limit + give ) / 2 );
		}
		outside = false;
		if( give == value ) give = value + 1;
		if( give < 0 ) {
			give = 0;
			outside = true;
		} else if( give > limit ) {
			give = limit;
			outside = true;
		}
		
		final lower = int(( give + value - 1 ) / 2 );
		final higher = int(( give + value + 1 ) / 2 );
		if( give > value ) {
			warm.updateLowHigh( higher, high );
			cold.updateLowHigh( low, lower );
		
		} else if( give < value ) {
			warm.updateLowHigh( low, lower );
			cold.updateLowHigh( higher, high );
		}
		return give;
	}
}

class Zone {
	public var low:Int;
	public var high:Int;

	public function new( low:Int, high:Int ) {
		this.low = low;
		this.high = high;
	}

	public function updateZone( z:Zone ) {
		this.low = z.low;
		this.high = z.high;
	}

	public function updateLowHigh( low:Int, high:Int ) {
		this.low = low;
		this.high = high;
	}

	public function toString() return '$low-$high';
}