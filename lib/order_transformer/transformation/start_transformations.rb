module OrderTransformer
  module Transformation
    class StartTransformations
      attr_reader :start_transformations

      def initialize(start_transformations:)
        @start_transformations = start_transformations
      end

      def execute(source_data:, context:)
        start_transformations.reduce({}) { |result, transformation| result.merge(transformation.execute(source_data: source_data, context: context)) }
      end
    end
  end
end
