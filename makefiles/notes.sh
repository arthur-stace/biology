#!/usr/bin/env sh

apts=$1

notes=$2


for appt in $(ls $apts/x*); do
  str=`cat $appt`
  touch $notes/`echo $str | shasum`
  file=`basename $(ls -tr $notes | tail -n 1)`
  echo $str > $notes/$file

  START_DATE=`date +%m/%d/%Y`
  END_DATE=$START_DATE
  START_TIME=`date +%H:%M`
  END_TIME=`date -v +2H +%H:%M`

  DESCRIPTION=`echo $str | grep -E 'Lab|Lecture|Exam|Questions' | head -c 45`

  echo "$START_DATE @ $START_TIME -> $END_DATE @ $END_TIME >$file | $DESCRIPTION"
done

