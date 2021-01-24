#!/usr/bin/env bash

NOTIFY_EMAIL=$1
TIMEOUT_SEC=$2

if [ -z ${NOTIFY_EMAIL} ]
then
	echo "I need an email address as first argument"
	exit 1
fi

CURRENT_IP=$(curl -m${TIMEOUT_SEC} -sq icanhazip.com)
if [ $? -eq 28 ]
then
	echo "Timeout of ${TIMEOUT_SEC}s recieved. Aborting!"
	exit 1
fi

if [ -f ~/.externalip ]
then
	STORED_IP=$(cat ~/.externalip)
else
	STORED_IP="empty"
fi

if [ "${CURRENT_IP}" != "${STORED_IP}" ]
then
	echo Updating IP from ${STORED_IP} to ${CURRENT_IP}
	echo ${CURRENT_IP} > ~/.externalip
	echo "The more things change..."
	echo "Sending mail to: ${NOTIFY_EMAIL}"
	echo "${CURRENT_IP}" | mailx -s "Your new ip for $HOSTNAME is: ${CURRENT_IP}" $NOTIFY_EMAIL
else
	echo "The more things change... the more they stay the same."
        echo "Your stored IP is: ${STORED_IP} for $HOSTNAME and current IP is: ${CURRENT_IP}"
fi

