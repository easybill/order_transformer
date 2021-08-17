module OrderTransformer
  module DSL
    class OrderProxy < BasicObject
      attr_reader :traversal_proxies

      def __create_transformation
        res = traversal_proxies.each_with_object([]) do |(name, config), result|
          result.push Transformation::StartTransformation.new key_name: name,
            transformations: config[:proxy].__create_transformation,
            as: config[:as]
        end

        Transformation::StartTransformations.new start_transformations: res
      end

      def initialize
        super
        @traversal_proxies = {}
      end

      def respond_to_missing?
        true
      end

      def method_missing(name, *args, **keyword_args, &block)
        traversal_proxy = TraversalProxy.new

        traversal_proxy.instance_eval(&block) if block

        traversal_proxies[name.to_s] = {proxy: traversal_proxy, as: keyword_args[:as]}
      end

      def pretty_print(pp)
        pp.group(1, "#<OrderProxy", ">") do
          pp.breakable
          pp.text "@traversal_proxies="
          @traversal_proxies.pretty_print(pp)
        end
      end
    end
  end
end
