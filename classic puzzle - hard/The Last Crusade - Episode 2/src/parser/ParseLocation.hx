package parser;

import Std.parseInt;
import data.Location;
import data.Transformations;

function parseLocation( s:String, width:Int ) {
	final inputs = s.split(' ');
	final x = parseInt( inputs[0] );
	final y = parseInt( inputs[1] );
	final pos = posMap[inputs[2]];
	final l:Location = { index: y * width + x, pos: pos };
	return l;
}
