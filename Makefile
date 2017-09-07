# Name of the image
name := mage/mage

# Latest Node version supported
latest := 8.4.0

# Default set of version for `make all`
versions := \
	$(latest) \
	7.10.1 \
	6.11.3 \
	5.12.0 \
	4.8.4

# Default version for `make build`
version := $(latest)

build-version:
	docker build -t $(name):$(version) --build-arg=node_version=$(version) .
	[[ "$(version)" == "$(latest)" ]] && docker tag $(name):$(version) $(name):latest || true

build:
	for version in $(versions); do \
		echo ">> Building version $${version}"; \
		$(MAKE) build-version version=$${version} || exit $${?}; \
	done

release-version:
	docker push $(name):$(version)

git-push:
	git push git@github.com:mage/mage-docker.git master

release: git-push
	for version in $(versions); do \
		echo ">> Release version $${version}"; \
		$(MAKE) release-version version=$${version}; \
	done
	$(MAKE) release-version version=latest
