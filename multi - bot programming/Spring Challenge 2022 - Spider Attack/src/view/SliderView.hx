package view;

import h2d.Slider;

class SliderView {
	public final slider:Slider;
	public final setFrame:Float -> Void;
	
	public var width( never, set ):Float;
	function set_width( v:Float ) {
		slider.width = v - 120;
		return v;
	}
	public var maxValue( get, set ):Float;
	function get_maxValue() return slider.maxValue;
	function set_maxValue( v:Float ) return slider.maxValue = v;

	public function new( slider:Slider, setFrame:Float -> Void) {
		this.slider = slider;
		this.setFrame = setFrame;
	}
}