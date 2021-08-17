module OrderTransformer
  module Transformation
    class ConstTransformation
      attr_reader :to, :value

      def initialize(to:, value:)
        @to = to
        @value = value
      end

      def execute(**_args)
        {to => value}
      end
    end
  end
end
