module OrderTransformer
  module DataNavigation
    module ResultBuilder
      class RemoveElementCommand
        attr_reader :key
        attr_accessor :parent

        def initialize(key:)
          super()
          @key = key
        end

        def execute(apply_to)
          apply_to.delete key

          apply_to
        end

        def add(cmd)
          parent.add cmd
        end

        def pretty_print(pp)
          pp.group(1, "#<RemoveElementCommand [#{key}]", ">") do
          end
        end
      end
    end
  end
end
