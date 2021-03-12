include variables.mk

include Makefile.docker

.PHONY: version test build

# print version
version:
	@printf $(TAG)

dependency:
	${GO_ENV_VARS} go mod download

all: build base-images images push

### Build binaries
build: build-extender \
build-scheduler

build-extender:
	CGO_ENABLED=0 GOOS=linux go build -o ./build/${SCHEDULING_PKG}/${EXTENDER}/${EXTENDER} ./cmd/${SCHEDULING_PKG}/${EXTENDER}/main.go

build-scheduler:
	CGO_ENABLED=0 GOOS=linux go build -o ./build/${SCHEDULING_PKG}/${SCHEDULER}/${SCHEDULER} ./cmd/${SCHEDULING_PKG}/${SCHEDULER}/main.go

### Clean artifacts
clean-all: clean clean-images

clean: clean-extender \
clean-scheduler

clean-extender:
	rm -rf ./build/${SCHEDULING_PKG}/${EXTENDER}/*

clean-scheduler:
	rm -rf ./build/${SCHEDULING_PKG}/${SCHEDULER}/*