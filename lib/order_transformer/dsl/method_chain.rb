module OrderTransformer
  module DSL
    class MethodChain
      attr_reader :methods, :__file, :__lineno, :__caller_name

      def initialize(file:, line:, caller_name:)
        super()
        @methods = []
        @__file = file || "-"
        @__lineno = line || "-"
        @__caller_name = caller_name || "-"
      end

      def add(method)
        methods.push method
        self
      end

      def call(*args)
        methods.reduce(args) { |last_result, method| method.call(*last_result) }
      end

      def source_location
        [__file, __lineno]
      end

      def backtrace
        [__file, __lineno, __caller_name].join(":")
      end

      def to_proc
        # local_methods = methods #
        #-> (*args) {  local_methods.reduce(args) { |last_result, method| method.call *last_result } }
        method(:call).to_proc
      end
    end
  end
end
