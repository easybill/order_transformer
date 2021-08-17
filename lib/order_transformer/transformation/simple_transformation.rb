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

      def execute(source_data:, context:)
        missing_keys = key_names.filter { |key_name| !source_data.key? key_name }

        raise "Missing keys #{missing_keys}" unless optional || missing_keys.size.zero?

        return {} if key_names.size == missing_keys.size

        args = key_names.map { |key_name| source_data.fetch(key_name, nil) }

        result = CleanContextContainer.new(context: context).instance_exec(*args, &transformer)

        {to => result}
      end
    end
  end
end
