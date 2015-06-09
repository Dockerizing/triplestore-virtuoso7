#!/bin/bash
VOSCMD=/usr/bin/virtuoso-t
CONFIG=virtuoso.ini

# allowing for clean shutdown of background jobs
cleanup () {
  echo "stopping virtuoso..."
  [[ -n $vospid ]] && kill -TERM "$vospid"

  exit 0
}

trap 'cleanup' INT TERM

# Change password
echo "setting virtuoso dba password..."
${VOSCMD} +configfile ${CONFIG} +foreground +pwdold dba +pwddba ${PWDDBA}

# Start server
echo "starting virtuoso..."
${VOSCMD} +configfile ${CONFIG} +foreground &
vospid=$!

wait $vospid
