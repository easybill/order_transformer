module OrderTransformer
  module Transformation
    class ConstTransformation
      attr_reader :to, :value

      def initialize(to:, value:)
        @to = to
        @value = value
      end

      def execute(result_data:, **_args)
        result_data.within to do
          result_data.value = value
        end
      end
    end
  end
end
