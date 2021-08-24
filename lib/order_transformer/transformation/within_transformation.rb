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
        raise OrderTransformer::KeyError.new(key_name) unless optional || source_data.key?(key_name)

        return {} unless source_data.key?(key_name)

        source_data.within(key_name) do
          transformations.each { |transformation| transformation.execute(source_data: source_data, context: context, result_data: result_data) }
        end
      end
    end
  end
end
