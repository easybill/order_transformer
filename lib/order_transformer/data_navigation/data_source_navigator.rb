module OrderTransformer
  module DataNavigation

    class DataSourceNavigator
      attr_accessor :source, :navigation_stack

      def initialize(source:)
        self.source = source
        self.navigation_stack = [SimpleElement.new]
      end

      def within(key_name, &block)
        slicer = HashElement.new key_name: key_name
        stacked_do slicer do
          block&.call
        end
      end

      def current_subelement
        @current_subelement ||= navigation_stack.reduce(source) { |result, slicer| slicer.get(data: result) }
      end

      def map(&block)
        result = []
        if block
          cnt_items = current_subelement.size

          result = (0...cnt_items).map do |index|
            slicer = ArrayElement.new index: index
            stacked_do slicer do
              block.call self
            end
          end
        end
        result
      end

      def each_with_index(&block)
        if block
          cnt_items = current_subelement.size

          (0...cnt_items).each do |index|
            slicer = ArrayElement.new index: index
            stacked_do slicer do
              block.call self, index
            end
          end
        end
      end

      def key?(key_name)
        current_subelement.key? key_name
      end

      def fetch(...)
        current_subelement.fetch(...)
      end

      private

      def stacked_do(slicer, &block)
        @current_subelement = nil
        navigation_stack.push slicer

        result = block&.call

        navigation_stack.pop
        @current_subelement = nil

        result
      end
    end
  end
end
