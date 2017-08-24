ci: clean Gemfile.lock generated
	bundle exec rake

generated: manifests/application_properties.pp

Gemfile.lock: Gemfile
	bundle install

manifests/%.pp: generate/%.yaml
	gen_java_properties_class $<

clean:
	rm -rf pkg test/integration/modules log junit

test-integration:
	echo "TODO"

build:
	bundle exec puppet module build .

.PHONY: ci clean test-integration build generated
