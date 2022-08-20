#!/bin/bash
cd "$(dirname "$0")"

/bin/bash code/scripts/clone.sh
/bin/bash code/scripts/init-base.sh
/bin/bash code/scripts/init-lnd.sh
/bin/bash code/scripts/init-lndhub-tg.sh
/bin/bash code/scripts/init-mongodb.sh