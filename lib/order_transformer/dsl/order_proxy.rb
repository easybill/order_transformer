module OrderTransformer
  module DSL
    class OrderProxy < BasicObject
      attr_reader :traversal_proxies, :__modules

      def __create_transformation(parent:)
        parent_transformations = []
        if parent
          parent_transformations = ::OrderTransformer::DSL.get(name: parent[:name], version: parent[:version])
        end

        res = traversal_proxies.each_with_object([]) do |(name, config), result|
          result.push Transformation::StartTransformation.new key_name: name,
            transformations: config[:proxy].__create_transformation,
            as: config[:as]
        end

        Transformation::StartTransformations.new start_transformations: [*parent_transformations, *res]
      end

      def initialize
        super
        @traversal_proxies = {}
        @__modules = []
      end

      def include_transformers(*modules)
        @__modules.concat modules
      end

      # :nocov:
      def respond_to_missing?
        true
      end
      # :nocov:

      def method_missing(name, *args, **keyword_args, &block)
        traversal_proxy = TraversalProxy.new(*__modules)

        traversal_proxy.instance_eval(&block) if block

        traversal_proxies[name.to_s] = {proxy: traversal_proxy, as: keyword_args[:as]}
      end

      # :nocov:
      def pretty_print(pp)
        pp.group(1, "#<OrderProxy", ">") do
          pp.breakable
          pp.text "@traversal_proxies="
          @traversal_proxies.pretty_print(pp)
        end
      end
      # :nocov:
    end
  end
end
