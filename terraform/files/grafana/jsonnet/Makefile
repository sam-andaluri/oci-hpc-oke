JSONNET ?= jsonnet
JSONNETFMT ?= jsonnetfmt
JB ?= jb

PACKAGE_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
OUTPUT_DIR ?= $(abspath $(PACKAGE_DIR)/../dashboards)
VENDOR_DIR := $(PACKAGE_DIR)/vendor
JSONNET_FILES := $(shell find $(PACKAGE_DIR)/dashboards $(PACKAGE_DIR)/lib -type f \( -name '*.jsonnet' -o -name '*.libsonnet' \) | sort)

.PHONY: all bootstrap compile fmt fmt-check verify package-test clean

all: verify

bootstrap:
	$(JB) install

compile:
	JSONNET=$(JSONNET) OUTPUT_DIR=$(OUTPUT_DIR) bash $(PACKAGE_DIR)/tools/compile.sh

fmt:
	$(JSONNETFMT) -i $(JSONNET_FILES)

fmt-check:
	$(JSONNETFMT) --test $(JSONNET_FILES)

verify: fmt-check
	JSONNET=$(JSONNET) bash $(PACKAGE_DIR)/tools/verify.sh

package-test:
	JSONNET=$(JSONNET) bash $(PACKAGE_DIR)/tools/package-test.sh

clean:
	rm -rf $(PACKAGE_DIR)/build
