module OrderTransformer
  module DSL
    class OrderProxy < BasicObject
      attr_reader :traversal_proxies

      def __create_transformation
        res = traversal_proxies.reduce([]) do |result, (name, traversal_proxy)|
          result.push Transformation::StartTransformation.new key_name: name, transformations: traversal_proxy.__create_transformation

          result
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

      def method_missing(name, *args, &block)
        traversal_proxy = TraversalProxy.new

        traversal_proxy.instance_eval(&block) if block

        traversal_proxies[name.to_s] = traversal_proxy
      end
    end
  end
end
