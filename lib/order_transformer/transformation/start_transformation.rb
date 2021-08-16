module OrderTransformer
  module Transformation
    class StartTransformation
      attr_reader :key_name, :transformations

      def initialize(key_name:, transformations:)
        @key_name = key_name
        @transformations = transformations
      end

      require 'byebug'

      def execute(source_data:)
        { key_name => transformations.map { |transformation| transformation.execute(source_data: source_data) } }
      end
    end
  end
end