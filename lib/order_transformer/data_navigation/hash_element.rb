module OrderTransformer
  module DataNavigation
    class HashElement
      attr_accessor :key_name

      def initialize(key_name:)
        super()
        self.key_name = key_name
      end

      def get(data:)
        data.fetch(key_name)
      end

      def to_s
        "Grep Key #{key_name}"
      end
    end
  end
end
