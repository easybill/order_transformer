module OrderTransformer
  module DataNavigation
    module ResultBuilder
      class AddItemCommand
        attr_accessor :commands, :index
        attr_reader :parent

        def initialize(index: nil)
          super()
          @index = index
        end

        def parent=(new_parent)
          @parent = new_parent

          new_parent.element_container = ArrayElementContainer.new
        end

        def add(cmd)
          parent.add cmd
        end

        def execute(apply_to)
          parent.element_container.add_item(index: index)

          apply_to
        end

        def to_s
          "#<AddItemCommand [#{index}] >"
        end
      end
    end
  end
end
