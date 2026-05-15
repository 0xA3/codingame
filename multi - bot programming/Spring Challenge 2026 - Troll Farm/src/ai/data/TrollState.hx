package ai.data;

enum TrollState {
	Idle;
	Harvesting( fruit:TFruit );
	Chopping;
	Mining;
}