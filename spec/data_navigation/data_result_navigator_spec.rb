require "spec_helper"
require "json"

module OrderTransformer
  module DataNavigation
    RSpec.describe DataResultNavigator do
      let(:navigator) { DataResultNavigator.new }

      it "can create a result" do
        navigator.within "test" do
          navigator.value = "hello world"
        end

        expect(navigator.to_h).to match({"test" => "hello world"})
      end

      it "can add an array to the result" do
        navigator.within "test" do
          (0...2).each do |index|
            navigator.next_item(index) do
              navigator.value = "hello world #{index + 1}"
            end
          end
        end

        expect(navigator.to_h).to match({"test" => ["hello world 1", "hello world 2"]})
      end

      it "can add remove a hash element" do
        navigator.within "test" do
          (0...2).each do |index|
            navigator.next_item(index) do
              navigator.within "test2" do
                navigator.value = "hello world #{index + 1}"
              end

              navigator.within "test3" do
                navigator.value = "hello world #{index + 1}"
              end
            end
          end

          (0...2).each do |index|
            navigator.next_item(index) do
              navigator.remove "test2"
            end
          end
        end

        expect(navigator.to_h).to match({"test" => [{"test3" => "hello world 1"}, {"test3" => "hello world 2"}]})
      end
    end
  end
end
