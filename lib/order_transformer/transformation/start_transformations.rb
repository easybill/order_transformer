module OrderTransformer
  module Transformation
    class StartTransformations
      attr_reader :start_transformations

      def initialize(start_transformations:)
        @start_transformations = start_transformations
      end

      def execute(source_data:, context:, result_data: ::OrderTransformer::DataNavigation::DataResultNavigator.new)
        start_transformations.each { |transformation| transformation.execute(source_data: source_data, context: context, result_data: result_data) }

        result_data.to_h
      end
    end
  end
end
