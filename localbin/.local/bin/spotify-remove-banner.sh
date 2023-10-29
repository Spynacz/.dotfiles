#!/bin/bash
cd /opt/spotify/Apps/xpui
sed -r -i 's/(\.ads\.leaderboard\.isEnabled)(}|\))/\1\&\&false\2/' xpui.js 
sed -r -i 's/.createElement\([^.,{]+,\{spec:[^.,]+,onClick:[^.,]+,className:[^.]+\.[^.]+\.UpgradeButton\}\),[^.(]+\(\)//' xpui.js
