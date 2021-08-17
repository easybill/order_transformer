module OrderTransformer
  module Transformation
    class StartTransformation
      attr_reader :key_name, :transformations, :as

      def initialize(key_name:, transformations:, as:)
        @key_name = key_name
        @transformations = transformations
        @as = as
      end

      def execute(**args)
        {key_name => if as == :array
                       array_result(**args)
                     else
                       hash_result(**args)
                     end}
      end

      def array_result(source_data:, context:)
        transformations.map { |transformation| transformation.execute(source_data: source_data, context: context) }.flatten
      end

      def hash_result(source_data:, context:)
        transformations.reduce({}) { |result, transformation| result.merge(transformation.execute(source_data: source_data, context: context)) }
      end
    end
  end
end
