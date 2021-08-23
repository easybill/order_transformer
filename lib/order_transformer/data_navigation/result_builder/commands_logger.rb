module OrderTransformer
  module DataNavigation
    module ResultBuilder
      class CommandsLogger
        def print(root, level = 0)
          print_msg root.to_s, level

          if root.respond_to? :commands
            (root.commands || []).each do |cmd|
              print cmd, (level + 1)
            end
          end
        end

        private

        def print_msg(msg, level)
          puts "#{"*" * level} #{msg}"
        end
      end
    end
  end
end
