package test;

import buddy.Buddy;

class Tests implements Buddy<[
	test.montecarlo.TestState,
	test.montecarlo.TestUCT,
	test.TestTransform,
	test.tictactoe.TestBoard,
	test.tictactoe.TestBitBoard,
	test.tictactoe.TestBoardCheckStatus,
	test.tree.TestNode,
	test.tree.TestNodePool
]>{}