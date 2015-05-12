#!/bin/sh

VOSCMD=/usr/bin/virtuoso-t
CONFIG=virtuoso.ini

# Change password
${VOSCMD} +configfile ${CONFIG} +foreground +pwdold dba +pwddba ${PWDDBA}

# Start server
${VOSCMD} +configfile ${CONFIG} +foreground
