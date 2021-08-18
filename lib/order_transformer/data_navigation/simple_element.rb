module OrderTransformer
  module DataNavigation
    class SimpleElement
      def get(data:)
        data
      end

      def to_s
        "Grep all "
      end
    end
  end
end
