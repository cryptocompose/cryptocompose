#!/bin/bash
cd "$(dirname "$0")"

/bin/bash code/dynamic_config/setup.sh
/bin/bash code/src/clone.sh
/bin/bash code/init/all.sh