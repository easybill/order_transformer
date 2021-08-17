module OrderTransformer
  module DSL
    class DefinitionProxy
      attr_reader :order_proxy, :__name, :__version

      def initialize(name:, version:)
        @__name = name
        @__version = version
      end

      def __create_transformation
        order_proxy.__create_transformation
      end

      def definition(&block)
        @order_proxy = OrderProxy.new

        order_proxy.instance_eval(&block) if block
      end

      def inspect
        super
      end

      def pretty_print(pp)
        pp.group(1, "#<DefinitionProxy #{__name} / #{__version}", ">") do
          pp.breakable
          pp.text "@order_proxy="
          @order_proxy.pretty_print(pp)
        end
      end
    end
  end
end
