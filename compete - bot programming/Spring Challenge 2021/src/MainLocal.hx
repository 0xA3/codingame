package;

import haxe.Timer;
import CodinGame.print;
import CodinGame.printErr;

using Lambda;

class MainLocal {
	
	static var start = 0;

	static function main() {
		
	}

	public static function delta( v:Float ) {
		return ( v - start ) * 1000;
	}

}
