package types;

@:structInit
class EventDto {
	
	public static final NO_EVENT:EventDto = { type: -1, animData: AnimData.NO_ANIM_DATA }
	
	public final type:Int;
	public final animData:AnimData;
  
	public final coord = CoordDto.NO_COORD_DTO;
	public final playerIndex = -1;
	public final amount = 0;
	public final target = CoordDto.NO_COORD_DTO;
}