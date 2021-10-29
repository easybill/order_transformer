module OrderTransformer
  module Transformation
    class WithinTransformation
      attr_reader :key_name, :transformations, :optional

      def initialize(key_name:, optional:, transformations:)
        @key_name = key_name
        @transformations = transformations
        @optional = optional
      end

      def execute(source_data:, context:, result_data:)
        source_data.within(key_name, optional) do
          transformations.each { |transformation| transformation.execute(source_data: source_data, context: context, result_data: result_data) }
        end
      end
    end
  end
end
