REPO ?= local/goreleaser
TAG ?= dev

TARGET_PLATFORMS ?= linux/amd64,linux/arm64
ATTESTATION ?= --attest type=sbom --attest type=provenance,mode=max

.DEFAULT_GOAL := build

.PHONY: test
test: buildx-machine  ## test building container image to all target platforms
	docker buildx build -f Dockerfile \
		--platform=$(TARGET_PLATFORMS) \
		-t $(REPO):$(TAG) .

.PHONY: build
build: buildx-machine ## build container image to current platform
	docker buildx build -f Dockerfile \
		-t $(REPO):$(TAG) --load .

.PHONY: push
push: buildx-machine  ## build container image to all target platforms and push to registry
	docker buildx build -f Dockerfile \
		--platform=$(TARGET_PLATFORMS) \
		$(ATTESTATION) -t $(REPO):$(TAG) --push .

buildx-machine: ## create buildx machine if not exists
	@docker buildx ls | grep docker-container || \
		docker buildx create --platform=$(TARGET_PLATFORMS) --use
