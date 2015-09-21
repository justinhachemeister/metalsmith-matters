
#
# Adds --harmony-generators flag when available/necessary
#

node ?= node
node_flags ?= $(shell $(node) --v8-options | grep generators | cut -d ' ' -f 3)

#
# Binaries.
#

mocha = $(node) $(node_flags) ./node_modules/.bin/_mocha

#
# Targets.
#

# Install dependencies with npm.
node_modules: package.json
	@npm install
	@touch node_modules # hack to fix mtime after npm installs

# Run the tests.
test: node_modules
	@$(mocha)

# Run the tests in debugging mode.
test-debug: node_modules
	@$(mocha) debug

# Run jshint against the project
lint-code:
	jshint lib/
lint-tests:
	jshint test/
lint: lint-code lint-tests

#
# Phonies.
#

.PHONY: test
.PHONY: test-debug
.PHONY: lint-code
.PHONY: lint-tests
.PHONY: lint
