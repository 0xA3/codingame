package data;

typedef FrameDataset = {
	final ash:{
		final x:Int;
		final y:Int;
	};
	final humans:Array<HumanDataset>;
	final zombies:Array<ZombieDataset>;
}
