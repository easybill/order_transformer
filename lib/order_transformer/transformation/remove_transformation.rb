module OrderTransformer
  module Transformation
    class RemoveTransformation
      attr_reader :key_name

      def initialize(key_name:)
        @key_name = key_name
      end

      def execute(result_data:, **_args)
        result_data.remove key_name
      end
    end
  end
end
