package ai.data;

enum TrollState {
	Idle;
	Harvest( fruit:TFruit );
	Plant( fruit:TFruit );
	Chop( player:Player );
	Mine;
}