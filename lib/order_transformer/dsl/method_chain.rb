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
        methods.reduce(args) { |last_result, method| method.call(*last_result) }
      end

      def to_proc
        # local_methods = methods #
        #-> (*args) {  local_methods.reduce(args) { |last_result, method| method.call *last_result } }
        method(:call).to_proc
      end
    end
  end
end
