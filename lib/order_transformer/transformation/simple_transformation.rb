module OrderTransformer
  module Transformation
    class SimpleTransformation
      attr_reader :key_names, :to, :optional, :transformer

      def initialize(key_names:, to:, optional:, transformer:)
        @key_names = key_names
        @to = to
        @optional = optional
        @transformer = transformer
      end

      def execute(source_data:, context:, result_data:)
        missing_keys = key_names.filter { |key_name| !source_data.key? key_name }

        raise "Missing keys #{missing_keys}" unless optional || missing_keys.size.zero?

        return {} if key_names.size == missing_keys.size

        args = key_names.map { |key_name| source_data.fetch(key_name, nil) }

        result = begin
          CleanContextContainer.new(context: context, source_data: source_data, result_data: result_data).instance_exec(*args, &transformer)
        rescue => e
          new_backtrace = e.backtrace
          lint_to_be_added = if transformer.respond_to? :backtrace
            transformer.backtrace
          elsif transformer.respond_to? :source_location
            transformer.source_location.join(":")
          end

          new_backtrace.push lint_to_be_added if lint_to_be_added

          e.set_backtrace new_backtrace

          raise e
        end

        if to.respond_to? :each_with_index
          to.each_with_index do |current_to, index|
            result_data.within current_to do
              result_data.value = result[index]
            end
          end
        else
          result_data.within to do
            result_data.value = result
          end
        end
      end
    end
  end
end
