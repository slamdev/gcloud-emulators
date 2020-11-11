REGISTRY := "ghcr.io/slamdev/gcloud-emulators"
#REGISTRY := "registry.hub.docker.com/library/slamdev/gcloud-emulators"
GCLOUD_VERSION := "308.0.0"

EMULATORS := $(shell find . -name Dockerfile -mindepth 2 -maxdepth 2 | xargs -n1 dirname | xargs -n1 basename)

BUILD_TARGETS := $(foreach m,$(EMULATORS),build/$(m))
build: $(BUILD_TARGETS)

build/%:
	@echo "building $*"
	docker pull -q "$(REGISTRY)-$*:$(GCLOUD_VERSION)" || true
	cd $* && docker build --cache-from "$(REGISTRY)-$*:$(GCLOUD_VERSION)" --build-arg GCLOUD_VERSION=$(GCLOUD_VERSION) -t "$(REGISTRY)-$*:$(GCLOUD_VERSION)" .

PUSH_TARGETS := $(foreach m,$(EMULATORS),push/$(m))
push: $(PUSH_TARGETS)

push/%:
	@echo "pushing $*"
	docker push "$(REGISTRY)-$*:$(GCLOUD_VERSION)"
