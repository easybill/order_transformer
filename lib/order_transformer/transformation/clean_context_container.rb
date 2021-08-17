module OrderTransformer
  module Transformation
    class CleanContextContainer
      attr_reader :context

      def initialize(context:)
        super()
        @context = context
      end
    end
  end
end
