package ai.data;

class RegisterDataset {
	public final gpu:String;
	public final reg0:Int;
	public final reg1:Int;
	public final reg2:Int;
	public final reg3:Int;
	public final reg4:Int;
	public final reg5:Int;
	public final reg6:Int;

	public function new(
		gpu:String,
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