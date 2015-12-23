#! /bin/bash
set -e
COMMAND=$@
CLI_DATA="$TG_HOME/.telegram-cli"
echo "[RUN] Will run command '$COMMAND' after authentification."

# Droits sur volume # Whatever that means.
chown -R "$TG_USER":"$TG_USER" "$TG_HOME"

cd "$TG_HOME/tg"

function checkauth() {
echo "[RUN] Looking for existing authentification at '$CLI_DATA/auth'."
if [ -f $CLI_DATA/auth ];
then
  asize=$(wc -c < $CLI_DATA/auth)
  if (($asize > 0)); then
     echo "[RUN] Authfile is existing, size $asize."
     ok=1
  else
     echo "[RUN] Authfile is empty."
     ok=0
  fi
else
  echo "[RUN] Authfile is not existent."
  ok=0
fi

}

checkauth

while ((ok == 0)); do
  echo "[RUN] Not authenticated. Running telegram-CLI"
  echo ""
  $TG_CLI -k $TG_PUBKEY --exec safe_quit --username="$TG_USER"
  checkauth
done

echo ""
echo "[RUN] Authenticated. Starting command..."


$COMMAND

echo "[RUN] Should stop telegram-cli."
