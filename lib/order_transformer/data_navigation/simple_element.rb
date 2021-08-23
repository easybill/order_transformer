module OrderTransformer
  module DataNavigation
    class SimpleElement
      def get(data:)
        data
      end

      # :nocov:
      def to_s
        "Grep all "
      end
      # :nocov:
    end
  end
end
