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
        source_data.within(key_name, optional) do
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
