-- SQL request(s)​​​​​​‌​‌​​‌​​​​​‌‌‌​‌​​​‌​​​​​ below
SELECT Top 10 agent.name,
         count(mutant.recruiterId) AS SCORE
FROM mutant, agent
WHERE mutant.recruiterId = agent.agentId
GROUP BY  mutant.recruiterId
ORDER BY  count(mutant.RECRUITERID) DESC