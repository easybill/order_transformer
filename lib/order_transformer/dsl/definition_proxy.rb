module OrderTransformer
  module DSL
    class DefinitionProxy
      attr_reader :order_proxy
      def __create_transformation
        order_proxy.__create_transformation
      end

      def definition(&block)
        @order_proxy = OrderProxy.new

        order_proxy.instance_eval(&block) if block
      end
    end
  end
end
