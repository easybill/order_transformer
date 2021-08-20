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
        if @result
          warn "Method was already called, use a new object for a second run"
          @result
        end

        args[:source_data] = ::OrderTransformer::DataNavigation::DataSourceNavigator.new(source: args[:source_data])

        args[:result_data].within key_name do
          if as == :array
            array_result(**args)
          else
            hash_result(**args)
          end
        end

        @result = args[:result_data].to_h
      end

      def array_result(source_data:, context:, result_data:)
        transformations.each do |transformation|
          transformation.execute(source_data: source_data, context: context, result_data: result_data)
        end
      end

      def hash_result(source_data:, context:, result_data:)
        transformations.each do |transformation|
          transformation.execute(source_data: source_data, context: context, result_data: result_data)
        end
      end
    end
  end
end
