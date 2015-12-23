#! /bin/bash

set -e

# Droits sur volume
chown -R "$C_USER":"$C_USER" "$C_HOME"

# Démarrage de cuberite
cd "$C_HOME/Server"
exec gosu "$C_USER" $C_HOME/Server/$@
