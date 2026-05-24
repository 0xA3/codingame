package ai.data;

import xa3.math.Pos;

enum Task {
	Attack();
	Chop( player:Player );
	CoChop( tree:Tree );
	Drop;
	Harvest( fruit:TResource );
	Mine;
	Move( pos:Pos );
	Nothing;
	Plant( fruit:TResource );
}