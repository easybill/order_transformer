require_relative "dsl/method_chain"
require_relative "dsl/default_transformers"
require_relative "dsl/definition_proxy"
require_relative "dsl/order_proxy"
require_relative "dsl/traversal_proxy"

module OrderTransformer
  module DSL
    @registry = {}

    def self.registry
      @registry
    end

    def self.add(importer:, name:, version:)
      registry[name] ||= {}
      registry[name][version] = importer
    end

    def self.get_raw(name:, version:)
      registry[name][version]
    end

    def self.get(name:, version:)
      registry[name][version].__create_transformation
    end

    def self.remove(name:, version:)
      registry[name].delete version
    end

    def self.define(name, version, &block)
      definition_proxy = DefinitionProxy.new(name: name, version: version)

      definition_proxy.instance_eval(&block) if block

      add importer: definition_proxy, name: name, version: version
    end
  end
end
