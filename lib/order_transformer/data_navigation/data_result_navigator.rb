module OrderTransformer
  module DataNavigation
    class DataResultNavigator
      attr_accessor :result, :navigation_stack
      def initialize
        self.result = {}
        self.navigation_stack = [SimpleElement.new]
      end

      def within(key_name, &block)
        slicer = HashElement.new key_name: key_name
        setvalue_on_subelement({}) if current_subelement.nil?
        current_subelement[key_name] = nil unless current_subelement.key? key_name

        stacked_do slicer do
          block&.call
        end
      end

      def next_item(index, &block)
        slicer = ArrayElement.new index: index
        setvalue_on_subelement([]) if current_subelement.nil?

        stacked_do slicer do
          block&.call
        end
      end

      def current_subelement
        @current_subelement ||= navigation_stack.reduce(result) { |r, slicer| slicer.get(data: r) }
      end

      def previous_subelement
        navigation_stack[0...-1].reduce(result) { |r, slicer| slicer.get(data: r) }
      end

      def current_id
        navigation_stack[-1].respond_to?(:key_name) ? navigation_stack[-1].key_name : navigation_stack[-1].index
      end

      def setvalue_on_subelement(value)
        elem = previous_subelement
        key = current_id
        elem[key] = value
      end

      def value=(val)
        setvalue_on_subelement(val)
      end

      def remove(key_name)
        elem = previous_subelement
        key = current_id

        elem[key].delete key_name
      end

      def to_h
        result
      end

      private

      def stacked_do(slicer, &block)
        @current_subelement = nil
        navigation_stack.push slicer

        block&.call

        navigation_stack.pop
        @current_subelement = nil
      end
    end
  end
end
