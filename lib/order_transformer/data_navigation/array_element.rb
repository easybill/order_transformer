module OrderTransformer
  module DataNavigation
    class ArrayElement
      attr_accessor :index

      def initialize(index:)
        super()
        self.index = index
      end

      def get(data:)
        data[index]
      end

      def to_s
        "Grep item #{index}"
      end
    end
  end
end
