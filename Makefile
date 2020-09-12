VERSION=0.0.2
ARCHIVE=manray-$(VERSION).tgz
CHECKSUM=$(ARCHIVE).md5

all: $(CHECKSUM)

$(CHECKSUM): $(ARCHIVE)
	md5sum $(ARCHIVE) >$(CHECKSUM)

$(ARCHIVE): clean-archive opt/custom/smf/*.xml opt/custom/smf/manray-load opt/custom/smf/manray-persist
	tar cv opt | gzip -n >manray-$(VERSION).tgz

lint: shfmt bashate checkbashisms shellcheck funk

shfmt:
	stank . | xargs shfmt -w -i 4

bashate:
	stank . | xargs bashate

checkbashisms:
	stank . | xargs checkbashisms -n -p

shellcheck:
	stank -exInterp zsh . | grep -v node_modules | xargs shellcheck

funk:
	funk .

clean: clean-checksum clean-archive

clean-checksum:
	-rm *.md5

clean-archive:
	-rm *.tgz
