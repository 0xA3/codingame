package test;

import buddy.Buddy;

class TestMain implements Buddy<[
	test.montecarlo.TestState,
	test.montecarlo.TestUCT,
	test.TestTransform,
	test.tictactoe.TestBoard,
	test.tictactoe.TestBoardCheckStatus,
	test.tree.TestNode
]>{}