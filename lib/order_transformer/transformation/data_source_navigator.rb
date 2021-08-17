module OrderTransformer
  module Transformation
    class DataSourceNavigator
      attr_accessor :source, :current_subtree, :navigation_stack

      def initialize(source:)
        self.source = source
        self.current_subtree = source
        self.navigation_stack = []
      end

      def within(key_name, &block)
        stacked_do key_name, current_subtree[key_name] do
          block&.call
        end
      end

      def map(&block)
        result = []
        if block
          current_items = current_subtree

          result = current_items.each_with_index.map do |item, index|
            stacked_do "[#{index}]", item do
              block.call self
            end
          end
        end
        result
      end

      def key?(key_name)
        current_subtree.key? key_name
      end

      def fetch(...)
        current_subtree.fetch(...)
      end

      private

      def stacked_do(key_name, item, &block)
        old_current_subtree = current_subtree
        self.current_subtree = item
        result = nil

        navigation_stack.push key_name

        result = block.call if block

        navigation_stack.pop

        self.current_subtree = old_current_subtree

        result
      end
    end
  end
end
