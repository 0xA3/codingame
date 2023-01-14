import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import xa3.MathUtils.abs;

using Converter;
using Distance;
using Lambda;


inline var NUM_ZONES = 30;
final ALPHABET = " ABCDEFGHIJKLMNOPQRSTUVWXYZ";

var charMap:Map<String, Int>;
var charCodeMap:Map<Int, String>;

function main() {

	final magicPhrase = readline();
	
	final program = process( magicPhrase );
	print( program );
}

function process( magicPhrase:String ) {
	
	final ai = new ai.AI6( NUM_ZONES, ALPHABET );
	return ai.process( magicPhrase );

}
