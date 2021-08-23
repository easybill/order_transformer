module OrderTransformer
  module DataNavigation
    module ResultBuilder
      class AddValueCommand
        attr_reader :value, :parent

        def initialize(value:)
          super()
          @value = value
        end

        def execute(apply_to)
          apply_to
        end

        def parent=(new_parent)
          @parent = new_parent

          new_parent.element_container = SimpleElementContainer.new(value: value)
        end

        def add(cmd)
          parent.add cmd
        end

        def to_s
          "#<AddValueCommand [#{value}] >"
        end
      end
    end
  end
end
