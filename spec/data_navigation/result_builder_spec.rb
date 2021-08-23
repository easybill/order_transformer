module OrderTransformer
  module DataNavigation
    module ResultBuilder
      RSpec.describe "Command usage" do
        it "can add multiple keys" do
          root_command = ElementCommands.new

          root_command.add(NavigateDownCommand.new(key: "key1"))
            .add(AddValueCommand.new(value: "value1"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key2"))
            .add(AddValueCommand.new(value: "value2"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key3"))
            .add(AddValueCommand.new(value: "value3"))
            .add(NavigateUpCommand.new)

          expect(root_command.execute({})).to match({"key1" => "value1", "key2" => "value2", "key3" => "value3"})
        end

        it "can navigate deeper inside" do
          root_command = ElementCommands.new

          root_command.add(NavigateDownCommand.new(key: "key1"))
            .add(AddValueCommand.new(value: "value1"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key2"))
            .add(AddValueCommand.new(value: "value2"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key3"))
            .add(AddValueCommand.new(value: "value3"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key4"))
            .add(NavigateDownCommand.new(key: "key5"))
            .add(AddValueCommand.new(value: "value5"))
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)

          expect(root_command.execute({})).to match({"key1" => "value1", "key2" => "value2", "key3" => "value3", "key4" => {"key5" => "value5"}})
        end

        it "can navigate up inside" do
          root_command = ElementCommands.new

          root_command.add(NavigateDownCommand.new(key: "key1"))
            .add(AddValueCommand.new(value: "value1"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key2"))
            .add(AddValueCommand.new(value: "value2"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key4"))
            .add(NavigateDownCommand.new(key: "key5"))
            .add(AddValueCommand.new(value: "value5"))
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key3"))
            .add(AddValueCommand.new(value: "value3"))
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)

          expect(root_command.execute({})).to match({"key1" => "value1", "key2" => "value2", "key3" => "value3", "key4" => {"key5" => "value5"}})
        end

        it "can add array elements" do
          root_command = ElementCommands.new

          expected_result = {"key1" => "value1",
                             "key2" => "value2",
                             "key3" => "value3",
                             "key4" => {
                               "key5" => "value5",
                               "key6" => [
                                 {
                                   "key5" => "value1",
                                   "key7" => "value2"
                                 },
                                 {
                                   "key5" => "value3",
                                   "key7" => "value4"
                                 }
                               ]
                             }}

          root_command.add(NavigateDownCommand.new(key: "key1"))
            .add(AddValueCommand.new(value: "value1"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key2"))
            .add(AddValueCommand.new(value: "value2"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key4"))
            .add(NavigateDownCommand.new(key: "key5"))
            .add(AddValueCommand.new(value: "value5"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key6"))
            .add(AddItemCommand.new)
            .add(NavigateDownCommand.new(key: "key5"))
            .add(AddValueCommand.new(value: "value1"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key7"))
            .add(AddValueCommand.new(value: "value2"))
            .add(NavigateUpCommand.new)
            .add(AddItemCommand.new)
            .add(NavigateDownCommand.new(key: "key5"))
            .add(AddValueCommand.new(value: "value3"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key7"))
            .add(AddValueCommand.new(value: "value4"))
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key3"))
            .add(AddValueCommand.new(value: "value3"))
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)

          expect(root_command.execute({})).to match(expected_result)
        end

        it "can change array elements" do
          root_command = ElementCommands.new

          expected_result = {"key1" => "value1",
                             "key2" => "value2",
                             "key3" => "value3",
                             "key4" => {
                               "key5" => "value5",
                               "key6" => [
                                 {
                                   "key5" => "value1",
                                   "key7" => "value2"
                                 },
                                 {
                                   "key5" => "value3",
                                   "key7" => "value5"
                                 }
                               ]
                             }}

          root_command.add(NavigateDownCommand.new(key: "key1"))
            .add(AddValueCommand.new(value: "value1"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key2"))
            .add(AddValueCommand.new(value: "value2"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key4"))
            .add(NavigateDownCommand.new(key: "key5"))
            .add(AddValueCommand.new(value: "value5"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key6"))
            .add(AddItemCommand.new)
            .add(NavigateDownCommand.new(key: "key5"))
            .add(AddValueCommand.new(value: "value1"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key7"))
            .add(AddValueCommand.new(value: "value2"))
            .add(NavigateUpCommand.new)
            .add(AddItemCommand.new)
            .add(NavigateDownCommand.new(key: "key5"))
            .add(AddValueCommand.new(value: "value3"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key7"))
            .add(AddValueCommand.new(value: "value4"))
            .add(NavigateUpCommand.new)
            .add(AddItemCommand.new(index: 1))
            .add(NavigateDownCommand.new(key: "key7"))
            .add(AddValueCommand.new(value: "value5"))
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key3"))
            .add(AddValueCommand.new(value: "value3"))
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)

          expect(root_command.execute({})).to match(expected_result)
        end

        it "can remove elements" do
          root_command = ElementCommands.new

          expected_result = {"key1" => "value1",
                             "key2" => "value2",
                             "key3" => "value3",
                             "key4" => {
                               "key6" => [
                                 {
                                   "key5" => "value1",
                                   "key7" => "value2"
                                 },
                                 {
                                   "key5" => "value3",
                                   "key7" => "value4"
                                 }
                               ]
                             }}

          root_command.add(NavigateDownCommand.new(key: "key1"))
            .add(AddValueCommand.new(value: "value1"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key2"))
            .add(AddValueCommand.new(value: "value2"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key4"))
            .add(NavigateDownCommand.new(key: "key5"))
            .add(AddValueCommand.new(value: "value5"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key6"))
            .add(AddItemCommand.new)
            .add(NavigateDownCommand.new(key: "key5"))
            .add(AddValueCommand.new(value: "value1"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key7"))
            .add(AddValueCommand.new(value: "value2"))
            .add(NavigateUpCommand.new)
            .add(AddItemCommand.new)
            .add(NavigateDownCommand.new(key: "key5"))
            .add(AddValueCommand.new(value: "value3"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key7"))
            .add(AddValueCommand.new(value: "value4"))
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)
            .add(RemoveElementCommand.new(key: "key5"))
            .add(NavigateUpCommand.new)
            .add(NavigateDownCommand.new(key: "key3"))
            .add(AddValueCommand.new(value: "value3"))
            .add(NavigateUpCommand.new)
            .add(NavigateUpCommand.new)

          expect(root_command.execute({})).to match(expected_result)
        end
      end
    end
  end
end
