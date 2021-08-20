module OrderTransformer
  module Transformation
    class CleanContextContainer
      attr_reader :context, :__source_data, :__result_data

      def initialize(context:, source_data:, result_data:)
        super()
        @context = context
        @__source_data = source_data
        @__result_data = result_data
      end
    end
  end
end
