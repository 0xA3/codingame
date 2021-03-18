package parser;

import Std.parseInt;
import data.RockLocation;
import parser.ParseLocation.parseLocation;

function parseRockLocation( s:String, width:Int ) {
	final location = parseLocation( s, width );
	final inputs = s.split(' ');
	final start = inputs.length > 3 ? parseInt( inputs[3] ) : 0;
	final rl:RockLocation = { index: location.index, pos: location.pos, start: start };
	return rl;
}
