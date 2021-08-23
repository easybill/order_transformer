module OrderTransformer
  module DataNavigation
    module ResultBuilder
      class NavigateUpCommand
        attr_accessor :parent

        def initialize
          super()
        end

        def execute(apply_to)
          apply_to
        end

        def add(cmd)
          parent.parent.add cmd
        end

        def to_s
          "#<NavigateUpCommand []>"
        end

        def pretty_print(pp)
          pp.group(1, "#<NavigateUpCommand ", ">") do
          end
        end
      end
    end
  end
end
