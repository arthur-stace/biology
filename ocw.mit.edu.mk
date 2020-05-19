

.PHONY:
OCW_ZIP_DOMAIN = https://ocw.mit.edu/ans15436/ZipForEndUsers
apts: tmp/${COURSE}.zip
	${MAKE} notes

notes: tmp/notes
	mkdir -p $@
	mv $</* $@

tmp/${COURSE}:
	mkdir -p $@


tmp/${COURSE}.zip: tmp/${COURSE}
	curl --output $@ \
		${OCW_ZIP_DOMAIN}/${COURSE_PREFIX}/${COURSE}/${COURSE}.zip
	tar xf $@ -C $<

tmp/apts: tmp/recitations.txt tmp/labs.txt tmp/lectures.txt tmp/exams.txt
	mkdir -p $@
	sh scripts/apts.sh $?
	mv x* $@/

tmp/notes: tmp/apts
	mkdir -p $@
	sh scripts/notes.sh $^ $@ > apts

tmp/%.txt:
	cat tmp/${COURSE}/contents/$*/index.htm \
	| pup "#course_inner_section" \
	| lynx -list_inline -dump -stdin > $@

clean:
	rm -rf notes apts
	rm -rf tmp/{x*,notes,apts}
