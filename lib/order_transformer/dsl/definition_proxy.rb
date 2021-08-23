module OrderTransformer
  module DSL
    class DefinitionProxy
      attr_reader :__order_proxy, :__name, :__version, :__parent

      def initialize(name:, version:)
        @__name = name
        @__version = version
        @__order_proxy = OrderProxy.new
      end

      def __create_transformation
        __order_proxy.__create_transformation parent: __parent
      end

      def definition(&block)
        __order_proxy.instance_eval(&block) if block
      end

      def parent(name:, version:)
        @__parent = {name: name, version: version}
      end

      def inspect
        super
      end

      # :nocov:
      def pretty_print(pp)
        pp.group(1, "#<DefinitionProxy #{__name} / #{__version}", ">") do
          pp.breakable
          pp.text "@order_proxy="
          @order_proxy.pretty_print(pp)
        end
      end
      # :nocov:
    end
  end
end
