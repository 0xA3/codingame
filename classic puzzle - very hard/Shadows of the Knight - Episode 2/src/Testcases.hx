typedef Input = {
	final w:Int;
	final h:Int;
	final n:Int;
	final x:Int;
	final y:Int;
	final bx:Int;
	final by:Int;
}

final x10_0:Input = { w: 10, h: 1, n: 10, x: 5,	y: 0, bx: 3, by: 0 }
final x100_0:Input = { w: 100, h: 1, n: 10, x: 0, y: 0, bx: 1, by: 0 }
final smallTower:Input = { w: 1, h: 10, n: 12, x: 0, y: 9, bx: 0, by: 7 }
final towerHorizontal:Input = { w: 100, h: 1, n: 12, x: 98, y: 0, bx: 66, by: 0 }

final aLotOfJumps:Input = { w: 5, h: 16, n: 80, x: 1, y: 5, bx: 4, by: 10 }
final lessJumps:Input = { w: 18, h: 32, n: 45, x: 17, y: 31, bx: 2, by: 1 }
final tower:Input = { w: 1, h: 100, n: 12, x: 0, y: 98, bx: 0, by: 66 }
final lesserJumps:Input = { w: 15, h: 15, n: 12, x: 3, y: 6, bx: 0, by: 0 }
final exactNbOfJumps:Input = { w: 24, h: 24, n: 15, x: 22, y: 13, bx: 0, by: 0 }
final moreWindows:Input = { w: 50, h: 50, n: 16, x: 17, y: 29, bx: 0, by: 0 }
final aLotOfWindows:Input = { w: 1000, h: 1000, n: 27, x: 501, y: 501, bx: 0, by: 0 }
final soManyWindows:Input = { w: 8000, h: 8000, n: 31, x: 3200, y: 2100, bx: 0, by: 0 }
