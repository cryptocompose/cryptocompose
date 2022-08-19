#!/bin/bash
cd "$(dirname "$0")"

/bin/bash code/scripts/clone.sh
/bin/bash code/scripts/init-generic.sh
/bin/bash code/scripts/init-lnd.sh