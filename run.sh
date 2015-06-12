#!/bin/bash
VOSCMD=/usr/bin/virtuoso-t
CONFIG=virtuoso.ini

if [ -f ${CONFIG} ]
then
    echo "Reuse existing virtuoso.ini in database directory"
else
    echo -n "Copy default virtuoso.ini to database directory (because none exists) …"
    cp /virtuoso.ini.dist ${CONFIG}
    echo " (done)"
fi

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
