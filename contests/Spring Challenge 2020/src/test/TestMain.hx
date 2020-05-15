package test;

import buddy.Buddy;

class TestMain implements Buddy<[
	test.navigator.TestCreatePelletTargets,
	test.navigator.TestSetDestinationPriorities,
	test.TestGetPath,
	test.TestGrid,
	test.TestGridFactory,
	TestGetPossibleDestinations
]>{}