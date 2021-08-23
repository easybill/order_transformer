module OrderTransformer
  module DataNavigation
    class DataResultNavigator
      attr_accessor :root_command, :add_command_to

      def initialize
        self.root_command = OrderTransformer::DataNavigation::ResultBuilder::ElementCommands.new
        self.add_command_to = root_command
      end

      def within(key_name, &block)
        add_command OrderTransformer::DataNavigation::ResultBuilder::NavigateDownCommand.new(key: key_name)

        block&.call

        add_command OrderTransformer::DataNavigation::ResultBuilder::NavigateUpCommand.new
      end

      def next_item(index, &block)
        add_command OrderTransformer::DataNavigation::ResultBuilder::AddItemCommand.new(index: index)

        block&.call

        # add_command OrderTransformer::DataNavigation::ResultBuilder::NavigateUpCommand.new()
      end

      def value=(val)
        add_command OrderTransformer::DataNavigation::ResultBuilder::AddValueCommand.new(value: val)
      end

      def remove(key_name)
        add_command OrderTransformer::DataNavigation::ResultBuilder::RemoveElementCommand.new key: key_name
      end

      def to_h
        root_command.execute({})
      end

      private

      def add_command command
        self.add_command_to = add_command_to.add command
      end
    end
  end
end
