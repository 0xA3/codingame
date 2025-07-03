REM produces a nodejs executable with ai.js injected in
node --experimental-sea-config sea-config.json
node -e "require('fs').copyFileSync(process.execPath, 'ai.exe')"
npx postject ai.exe NODE_SEA_BLOB sea-prep.blob --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2
REM https://nodejs.org/api/single-executable-applications.html
