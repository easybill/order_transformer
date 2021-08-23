module OrderTransformer
  module DataNavigation
    module ResultBuilder
      class NavigateDownCommand
        attr_reader :key
        attr_accessor :parent, :commands, :element_container

        def initialize(key:)
          super()
          @commands = []
          @key = key
          @element_container = HashElementContainer.new
        end

        def add(cmd)
          commands.push cmd
          cmd.parent = self

          cmd
        end

        def execute(apply_to)
          element_container.apply(apply_to, key)

          commands.each do |command|
            command.execute element_container.apply_value
          end

          apply_to
        end

        # :nocov:
        def to_s
          "#<NavigateDownCommand [#{key}] >"
        end

        def pretty_print(pp)
          pp.group(1, "#<NavigateDownCommand [#{key}]", ">") do
            pp.breakable
            pp.text "@element_container="
            @element_container.pretty_print(pp)

            pp.breakable
            pp.text "@commands="
            @commands.pretty_print(pp)
          end
        end
        # :nocov:
      end
    end
  end
end
