module OrderTransformer
  module Transformation
    class StartTransformations
      attr_reader :start_transformations

      def initialize(start_transformations:)
        @start_transformations = start_transformations
      end

      def execute(source_data:)
        start_transformations.reduce({}) { |result, transformation| result.merge(transformation.execute(source_data: source_data)) }
      end
    end
  end
end