package ai;

import ai.data.CellDataset;
import ai.data.FrameCellDataset;

interface IAi {
	function setGlobalInputs( cellDatasets:Array<CellDataset>, myBaseIndices:Array<Int>, oppBaseIndices:Array<Int> ):Void;
	function setInputs( frameCellDatasets:Array<FrameCellDataset> ):Void;
	function init():Void;
	function process():String;
}