REM runs winter challenge, which executes 2 bot programs and runs a server for website results
REM first, go back to main dir (must run from main project dir, WinterChallenge2024-Cellularena)
cd..
java -jar ./build/winter-2024.jar -p1 "build/ai.exe" -p2 "build/ai_wait.exe" -s -l "log.txt"
# winter-2024.jar from https://github.com/httpsx/WinterChallenge2024-Cellularena
