package ai.data;

import xa3.math.Pos;

enum Task {
	Attack( tree:Tree );
	Chop( player:Player );
	Drop;
	Harvest( fruit:TResource );
	Mine;
	Move( pos:Pos );
	Nothing;
	Plant( fruit:TResource );
}