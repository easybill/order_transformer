module OrderTransformer
  module DataNavigation
    module ResultBuilder
      class ElementCommands
        attr_accessor :commands

        def initialize
          super()
          @commands = []
        end

        def execute(apply_to)
          commands.each do |command|
            command.execute apply_to
          end

          apply_to
        end

        def add(cmd)
          commands.push cmd
          cmd.parent = self

          cmd
        end

        # :nocov:
        def to_s
          "#<ElementCommands [] >"
        end

        def pretty_print(pp)
          pp.group(1, "#<ElementCommands", ">") do
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
