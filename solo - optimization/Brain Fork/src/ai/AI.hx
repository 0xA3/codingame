package ai;
import Std.int;

class AI {

	final numZones:Int;
	final halfZones:Int;
	final alphabet:String;
	final charMap:Map<String, Int>;
	final charCodeMap:Map<Int, String>;
	final zoneValues:Array<Int>;

	final commands = [];
	
	var position = 0;

	public function new( numZones:Int, alphabet:String ) {
		this.numZones = numZones;
		halfZones = int( numZones / 2 );
		this.alphabet = alphabet;
		charMap = [for( i in 0...alphabet.length ) alphabet.charAt( i ) => i ];
		charCodeMap = [for( i in 0...alphabet.length ) i => alphabet.charAt( i )];
		zoneValues = [for( _ in 0...numZones ) 0];
	}
}