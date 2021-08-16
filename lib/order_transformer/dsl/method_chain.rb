module OrderTransformer
  module DSL
    class MethodChain
      attr_reader :methods

      def initialize
        super
        @methods = []
      end

      def add(method)
        methods.push method
        self
      end

      def call(*args)
        methods.reduce(args) { |last_result, method| method.call *last_result }
      end
    end
  end
end
