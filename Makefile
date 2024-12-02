.PHONY: clean
clean:
	swift package clean

.PHONY: format
format:
	swift format -r -p -i .

.PHONY: lint
lint:
	swift format lint -r -p .

.PHONY: build
build:
	swift build

.PHONY: build-tests
build-tests:
	swift build --build-tests

.PHONY: test
test:
	swift build --build-tests
	swift test --skip-build
