package ai.versions.deprecated;

	function findClosestOpps( agents:Array<Agent>, oppAgents:Array<Agent> ) {
		final agentsAndOpps = [];
		for( agent in agents ) {
			final oppsAndDistances = [];
			for( oppAgent in oppAgents ) {
				final distance = agent.pos.manhattanDistance( oppAgent.pos );
				oppsAndDistances.push({ agent: oppAgent, distance: distance });
			}
			oppsAndDistances.sort(( a, b ) -> a.distance - b.distance );
			agentsAndOpps.push({ agent: agent, closestOpps: oppsAndDistances });
		}
		
		agentsAndOpps.sort(( a, b ) -> a.closestOpps[0].distance - b.closestOpps[0].distance );

		final agentOppTuples:Array<{ agent:Agent, opp:Agent }> = [];
		for( i in 0...agents.length ) {
			final agent = agentsAndOpps[i].agent;
			final closestOpps = agentsAndOpps[i].closestOpps;
			if( closestOpps.length > 0 ) {
				final closestOpp = agentsAndOpps[i].closestOpps[0];
				agentOppTuples.push({ agent: agent, opp: closestOpp.agent });
				for( o in i + 1...agents.length ) {
					final oppDistances = agentsAndOpps[o].closestOpps;
					for( oppDistance in oppDistances ) {
						if( oppDistance.agent.id == closestOpp.agent.id ) {
							oppDistances.remove( oppDistance );
							break;
						}
					}
				}
			} else {
				oppAgents.sort(( a, b ) -> agent.pos.manhattanDistance( a.pos ) - agent.pos.manhattanDistance( b.pos ));
				final closestOpp = oppAgents[0];
				agentOppTuples.push({ agent: agent, opp: closestOpp });
			}
		}

		return agentOppTuples;
	}

