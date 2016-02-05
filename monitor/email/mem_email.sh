#!/bin/bash
#set -x
LANG=en_US

# ARG
HOSTNAME=$(hostname)
CURRENT_DATE=$(date)
FROM="analysisReport@analysis.com"
TO="nazmulhassan2@gmail.com"
SUBJECT="Memory Usage Report FROM:$HOSTNAME"
MSG="This is memory usage report from $HOSTNAME instance created on $CURRENT_DATE"
FILES="output/mem-graph.png"

# http://fr.wikipedia.org/wiki/Multipurpose_Internet_Mail_Extensions
SUB_CHARSET=$(echo ${SUBJECT} | file -bi - | cut -d"=" -f2)
SUB_B64=$(echo ${SUBJECT} | uuencode --base64 - | tail -n+2 | head -n+1)

NB_FILES=$(echo ${FILES} | wc -w)
NB=0
cat <<EOF | /usr/sbin/sendmail -t
From: ${FROM}
To: ${TO}
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=frontier
Subject: =?${SUB_CHARSET}?B?${SUB_B64}?=

--frontier
Content-Type: $(echo ${MSG} | file -bi -)
Content-Transfer-Encoding: 7bit


${MSG}
$(test $NB_FILES -eq 0 && echo "--frontier--" || echo "--frontier")
$(for file in ${FILES} ; do
        let NB=${NB}+1
        FILE_NAME="$(basename $file)"
        echo "Content-Type: $(file -bi $file); name=\"${FILE_NAME}\""
        echo "Content-Transfer-Encoding: base64"
        echo "Content-Disposition: attachment; filename=\"${FILE_NAME}\""
        #echo ""
        uuencode --base64 ${file} ${FILE_NAME}
        test ${NB} -eq ${NB_FILES} && echo "--frontier--" || echo 
"--frontier"
done)
EOF
