# project name
PROJECT          := csi-baremetal-scheduling

### version
MAJOR            := 0
MINOR            := 0
PATCH            := 13
PRODUCT_VERSION  ?= ${MAJOR}.${MINOR}.${PATCH}
BUILD_REL_A      := $(shell git rev-list HEAD |wc -l)
BUILD_REL_B      := $(shell git rev-parse --short HEAD)
BLD_CNT          := $(shell echo ${BUILD_REL_A})
BLD_SHA          := $(shell echo ${BUILD_REL_B})
RELEASE_STR      := ${BLD_CNT}.${BLD_SHA}
FULL_VERSION     := ${PRODUCT_VERSION}-${RELEASE_STR}
TAG              := ${FULL_VERSION}
BRANCH           := $(shell git rev-parse --abbrev-ref HEAD)

### PATH
SCHEDULING_PKG := scheduling
SCHEDULER_EXTENDER_PKG := extender
SCHEDULER_EXTENDER_PATCHER_PKG := scheduler/patcher

### components
SCHEDULER        := scheduler
EXTENDER         := extender
EXTENDER_PATCHER := scheduler-patcher
PLUGIN           := plugin

### go env vars
GO_ENV_VARS     := GO111MODULE=on ${GOPRIVATE_PART} ${GOPROXY_PART}

### custom variables that could be ommited
GOPRIVATE_PART  :=
GOPROXY_PART    := GOPROXY=https://proxy.golang.org,direct

### Ingest information to the binary at the compile time
METRICS_PACKAGE := github.com/dell/csi-baremetal/pkg/metrics
LDFLAGS := -ldflags "-X ${METRICS_PACKAGE}.Revision=${RELEASE_STR} -X ${METRICS_PACKAGE}.Branch=${BRANCH}"

# override some of variables, optional file
-include variables.override.mk
