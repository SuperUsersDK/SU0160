# if BUILD_ID is unset, compute metadata that will be used in builds
ifeq ($(strip $(BUILD_ID)),)
	VCS_REF := $(shell git rev-parse --short HEAD)
	BUILD_TIME_EPOCH := $(shell date +"%s")
	BUILD_TIME_RFC_3339 := \
		$(shell date -u -r $(BUILD_TIME_EPOCH) '+%Y-%m-%dT%I:%M:%SZ')
	BUILD_TIME_UTC := \
		$(shell date -u -r $(BUILD_TIME_EPOCH) +'%Y%m%d-%H%M%S')
	BUILD_ID := $(BUILD_TIME_UTC)-$(VCS_REF)
endif

ifeq ($(strip $(TAG)),)
	TAG := unknown
endif 

.PHONY: clean
clean:
	@echo "Cleaning"
	rm -rf target

.PHONY: metadata
metadata:
	@echo "Gathering Metadata"
	@echo BUILD_TIME_EPOCH IS $(BUILD_TIME_EPOCH)
	@echo BUILD_TIME_RFC_3339 IS $(BUILD_TIME_RFC_3339)
	@echo BUILD_TIME_UTC IS $(BUILD_TIME_UTC)
	@echo BUILD_ID IS $(BUILD_ID)

target/ch9-0.1.0.jar:
	@echo "Building App Artifacts"
	docker run -it --rm  -v "$(shell pwd)":/project/ -w /project/ \
    maven:3.6-jdk-11 \
    mvn clean verify

.PHONY: app-artifacts
app-artifacts: target/ch9-0.1.0.jar

.PHONY: lint-dockerfile
lint-dockerfile:
	@set -e
	@echo "Linting Dockerfile"
	docker container run --rm -i hadolint/hadolint:v1.15.0 < \
		multi-stage-runtime.df

.PHONY: app-image
app-image: app-artifacts metadata lint-dockerfile
	@echo "Building App Image"
	docker image build -t su0160/ch9:$(BUILD_ID) \
	-f multi-stage-runtime.df \
	--build-arg BUILD_ID='$(BUILD_ID)' \
	--build-arg BUILD_DATE='$(BUILD_TIME_RFC_3339)' \
	--build-arg VCS_REF='$(VCS_REF)' \
	.
	@echo "Built App Image. BUILD_ID: $(BUILD_ID)"

.PHONY: app-image-debug
app-image-debug: app-image
	@echo "Building Debug App Image"
	docker image build -t su0160/ch9:$(BUILD_ID)-debug \
	-f multi-stage-runtime.df \
	--target=app-image-debug \
	--build-arg BUILD_ID='$(BUILD_ID)' \
	--build-arg BUILD_DATE='$(BUILD_TIME_RFC_3339)' \
	--build-arg VCS_REF='$(VCS_REF)' \
	.
	@echo "Built Debug App Image. BUILD_ID: $(BUILD_ID)"

.PHONY: image-tests
image-tests:
	@echo "Testing image structure"
	docker container run --rm -it \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v $(shell pwd)/structure-tests.yaml:/structure-tests.yaml \
	gcr.io/gcp-runtimes/container-structure-test:v1.6.0 test \
	--image su0160/ch9:$(BUILD_ID) \
	--config /structure-tests.yaml

.PHONY: inspect-image-labels
inspect-image-labels:
	docker image inspect --format '{{ json .Config.Labels }}' \
		su0160/ch9:$(BUILD_ID) | jq

.PHONY: tag
tag:
	@echo "Tagging Image"
	docker image tag su0160/ch9:$(BUILD_ID) \
		su0160/ch9:$(TAG)

.PHONY: all
all: app-artifacts app-image image-tests
