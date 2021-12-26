package data;

import data.HumanDataset;
import data.ZombieDataset;

typedef FrameDataset = {
	final ashX:Int;
	final ashY:Int;
	final humans:Array<HumanDataset>;
	final zombies:Array<ZombieDataset>;
}

typedef MutFrameDataset = {
	var ashX:Int;
	var ashY:Int;
	final humans:Array<MutHumanDataset>;
	final zombies:Array<MutZombieDataset>;
}
