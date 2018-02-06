HASKELL_SERVICES := proxy cannon cargohold brig galley gundeck
SERVICES         := $(HASKELL_SERVICES) nginz

default: clean install

init:
	mkdir -p dist

.PHONY: install
install: init
	stack install --pedantic --test --local-bin-path=dist

.PHONY: clean
clean:
	stack clean
	-rm -rf dist
	-rm -f .metadata


.PHONY: services
services:
	$(foreach service,$(HASKELL_SERVICES),$(MAKE) -C services/$(service) clean install;)

#################################
## docker targets

.PHONY: docker-services
docker-services:
	$(MAKE) -C build/alpine
	$(foreach service,$(SERVICES),$(MAKE) -C services/$(service) docker;)

.PHONY: docker-deps
docker-deps:
	$(MAKE) -C build/alpine deps

.PHONY: docker-builder
docker-builder:
	$(MAKE) -C build/alpine builder

.PHONY: docker-%
docker-%:
	$(MAKE) -C services/"$*" docker
