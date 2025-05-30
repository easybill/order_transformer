module OrderTransformer
  module DataNavigation
    class DataSourceNavigator
      attr_accessor :source, :navigation_stack

      def initialize(source:)
        self.source = source
        self.navigation_stack = [SimpleElement.new]
      end

      def within(key_name, optional, &block)
        raise OrderTransformer::KeyError.new(key_name) unless optional || key?(key_name)
        return unless key?(key_name)

        slicer = HashElement.new key_name: key_name
        stacked_do slicer do
          break if optional && blank?
          raise OrderTransformer::StructureMissMatchError, key_name unless present?

          block&.call
        end
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
        current_subelement&.key? key_name
      end

      def fetch(*args)
        current_subelement.fetch(*args)
      rescue ::KeyError
        raise OrderTransformer::KeyError.new(args.first)
      end

      def get
        current_subelement
      end

      def present?
        !blank?
      end

      def blank?
        current_subelement.nil?
      end

      private

      def current_subelement
        @current_subelement ||= navigation_stack.reduce(source) { |result, slicer| slicer.get(data: result) }
      end

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
