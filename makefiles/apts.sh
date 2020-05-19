#!/usr/bin/env sh

cat $@ \
| grep -E -A 2 'Lab|Lecture|Exam|Questions' \
| split -p '--'

