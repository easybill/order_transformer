module OrderTransformer
  module Transformation
    class WitheachTransformation
      attr_reader :key_name, :transformations, :optional

      def initialize(key_name:, optional:, transformations:)
        @key_name = key_name
        @transformations = transformations
        @optional = optional
      end

      def execute(source_data:, context:, result_data:)
        raise OrderTransformer::KeyError.new(key_name) unless optional || source_data.key?(key_name)

        return [] unless source_data.key?(key_name)

        source_data.within(key_name) do
          source_data.each_with_index do |next_source_data_item, index|
            result_data.next_item(index) do
              transformations.each { |transformation| transformation.execute(source_data: next_source_data_item, context: context, result_data: result_data) }
            end
          end
        end
      end
    end
  end
end
