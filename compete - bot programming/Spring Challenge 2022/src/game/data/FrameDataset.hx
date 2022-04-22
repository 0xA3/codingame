package game.data;

typedef FrameDataset = {
	final players:Array<PlayerFrameDataset>;
	final monsters:Array<CharacterFrameDataset>;
}

typedef PlayerFrameDataset = {
	final health:Int;
	final mana:Int;
	final heros:Array<CharacterFrameDataset>;
}

typedef CharacterFrameDataset = {
	final id:Int;
	final x:Int;
	final y:Int;
	final rotation:Float;
}
