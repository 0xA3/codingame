package ai.data;

enum TrollState {
	Idle;
	Harvesting( fruit:TFruit );
	Planting( fruit:TFruit );
	Chopping;
	Mining;
}