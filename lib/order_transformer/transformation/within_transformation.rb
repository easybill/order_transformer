module OrderTransformer
  module Transformation
    class WithinTransformation
      attr_reader :key_name, :transformations, :optional

      def initialize(key_name:, optional:, transformations:)
        @key_name = key_name
        @transformations = transformations
        @optional = optional
      end

      def execute(source_data:, context:)
        raise "Missing key #{key_name}" unless optional || source_data.key?(key_name)

        return {} unless source_data.key?(key_name)

        next_source_data = source_data.fetch(key_name, nil)

        transformations.reduce({}) { |result, transformation| result.merge(transformation.execute(source_data: next_source_data, context: context)) }
      end
    end
  end
end
