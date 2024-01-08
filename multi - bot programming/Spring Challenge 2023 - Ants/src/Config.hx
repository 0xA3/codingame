import gameengine.module.endscreen.EndScreenModule;
import resources.view.ViewModule;

final modules:Array<Dynamic> = [
	ViewModule,
	EndScreenModule
];

final playerColors = [
	'#22a1e4', // curious blue
	'#ff1d5c' // radical red
];

final options:Array<Dynamic> = [{
	title: 'DEBUG MODE',
	values: {
	  'ON': true,
	  'BLUE': 0,
	  'RED': 1,
	  'OFF': false
	}
  },{
	title: 'ANTS',
	values: {
	  'NUMBERS': false,
	  'PARTICLES': true
	}
  }];
  
  
  final gameName = 'UTG2022';
  
  final stepByStepAnimateSpeed = 1;
  