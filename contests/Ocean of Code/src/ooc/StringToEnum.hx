package ooc;

class StringToEnum {
	
	public static function direction( s:String ):Direction {
		return switch s {
			case "N": North;
			case "E": East;
			case "S": South;
			default: West;
		}
	}
}