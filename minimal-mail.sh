#!/bin/bash
##############################################################################
# $Id$
# minimal-mail.sh crée avec cs par fab@antaya.fr le '2017-12-20 17:20:12'
VERSION=0.0.1
# Objectif :
#  Contourner le problème d'envoi de mail sur certaines machines
#
# Usage :
#  command | $ME $from $to $subject
#
#  PHP : http://php.net/manual/fr/function.mail.php
#  bool mail (string $to, string $subject, string $message [, string $additional_headers [, string $additional_parameters ]])
#
#  
# Author: Fabrice Mendes
#
######################################################(FAb)###################

ME=$(basename $0)

function help()
{
    echo "$ME <from> <to> '<subject>' < body_via_stdin" 2>&1
    echo " $*"
    exit 1
}

sTo=""
sFrom=""
sSubject=""

if [ "x$1" = "x" ]; then
   help "Missing parameters"
fi
sFrom="$1"

if [ "x$2" = "x" ]; then
   help "Missing TO and SUBJECT"
fi
sTo="$2"

if [ "x$3" = "x" ]; then
   help "Missing parameters SUBJECT"
fi
sSubject="$3"

sBody="Ok"
hFrom="From: $sFrom$_NL"
_NL="$(echo -e "\r\n")"

echo "[from=$sFrom][to=$sTo][subject=$sSubject]"
php_code="
\$buffer=file_get_contents('php://stdin');
return mail('"$sTo"', '"$sSubject"', \$buffer, '"$hFrom"' );
"
#date | echo "php -r \"$php_code\""
#date | php -r "$php_code"


php -r "$php_code"
rc-$?
rc=$?

exit $rc

