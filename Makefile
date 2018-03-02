VERSION=0.0.1
ARCHIVE=manray-$(VERSION).tgz
CHECKSUM=$(ARCHIVE).md5

all: $(CHECKSUM)

$(CHECKSUM): $(ARCHIVE)
	md5sum $(ARCHIVE) >$(CHECKSUM)

$(ARCHIVE): clean-archive opt/custom/smf/*.xml opt/custom/smf/manray-load opt/custom/smf/manray-persist
	tar cv opt | gzip -n >manray-$(VERSION).tgz

lint: shfmt bashate shlint checkbashisms shellcheck

shfmt:
	stank . | xargs shfmt -w -i 4

bashate:
	stank . | xargs bashate

shlint:
	stank . | xargs shlint

checkbashisms:
	stank . | xargs checkbashisms -n -p

shellcheck:
	stank . | xargs shellcheck

clean: clean-checksum clean-archive

clean-checksum:
	-rm *.md5

clean-archive:
	-rm *.tgz
