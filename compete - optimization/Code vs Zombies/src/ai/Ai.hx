package ai;

import data.FrameDataset;

interface Ai {
	
	function reset():Void;
	function process( frame:FrameDataset ):String;
}