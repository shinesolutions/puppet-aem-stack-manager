ci: tools clean lint

clean:
	rm -rf pkg
	rm -rf test/integration/modules/

lint:
	puppet-lint \
		--fail-on-warnings \
		--no-140chars-check \
		--no-autoloader_layout-check \
		--no-documentation-check \
		--no-only_variable_string-check \
		--no-selector_inside_resource-check \
		test/integration/*

test-integration:
	echo "TODO"

build:
	puppet module build .

tools:
	gem install puppet puppet-lint

.PHONY: ci clean lint test-integration build tools
