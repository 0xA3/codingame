package ai.data;

class RegisterDataset {
	public var gpu:Array<String>;
	public var reg0:Int;
	public var reg1:Int;
	public var reg2:Int;
	public var reg3:Int;
	public var reg4:Int;
	public var reg5:Int;
	public var reg6:Int;

	public function new() {}

	public function set(
		gpu:Array<String>,
		reg0:Int,
		reg1:Int,
		reg2:Int,
		reg3:Int,
		reg4:Int,
		reg5:Int,
		reg6:Int
	) {
		this.gpu = gpu;
		this.reg0 = reg0;
		this.reg1 = reg1;
		this.reg2 = reg2;
		this.reg3 = reg3;
		this.reg4 = reg4;
		this.reg5 = reg5;
		this.reg6 = reg6;
	}
}