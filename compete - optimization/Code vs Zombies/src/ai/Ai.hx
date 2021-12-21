package ai;

import data.FrameDataset;

interface Ai {
	
	function process( frame:FrameDataset ):String;
}