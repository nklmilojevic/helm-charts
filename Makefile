.SILENT: package index test
.PHONY: package index test

CHARTS = $(sort $(dir $(wildcard charts/*/.)))
TEST_CHARTS = $(sort $(dir $(subst test/,,$(wildcard charts/*/test/.))))

REPO_URL = "https://raw.githubusercontent.com/nklmilojevic/helm-charts/main/index/"

all: test package index

test:
	for chart in $(TEST_CHARTS) ; do \
	    echo "Testing chart '$$chart'" ; \
		cd $$chart && $(MAKE) test ; \
	done

package:
	for chart in $(CHARTS) ; do \
	    echo "Packaging chart '$$chart'" ; \
		helm package $$chart --destination index ; \
	done

index:
	echo "Recreating Chart Index chart"
	helm repo index index/ --url $(REPO_URL)
