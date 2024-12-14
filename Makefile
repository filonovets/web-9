PROJECT_DIR := $(shell pwd)
PROJECT_BIN := $(PROJECT_DIR)/bin
$(shell test -d bin || mkdir -p $(PROJECT_BIN))
PATH := $(PROJECT_BIN):$(PATH)

GOLANGCI_LINT := $(PROJECT_BIN)/golangci-lint
GOLANGCI_LINT_VERSION := "latest"

.PHONY: .install-linter
.install-linter:
	### INSTALL GOLANGCI_LINT ###
	if test ! -f "$(GOLANGCI_LINT)"; then \
	  curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(PROJECT_BIN) $(GOLANGCI_LINT_VERSION); \
    fi


.PHONY: lint
lint: .install-linter
	### RUN GOALNGCI-LINT ###
	$(GOLANGCI_LINT) run ./... --config=./.golangci.yaml