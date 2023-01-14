package data;

@:structInit class State {
	
	public static final NO_STATE:State = { speed: 0, x: 0, alive: 0, motorbikes: []}

	public final speed:Int;
	public final x:Int;
	public final alive:Int;
	public final motorbikes:Array<Motorbike>;
}
