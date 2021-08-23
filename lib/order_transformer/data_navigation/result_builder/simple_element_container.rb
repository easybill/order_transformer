module OrderTransformer
  module DataNavigation
    module ResultBuilder
      class SimpleElementContainer
        attr_accessor :key_value, :apply_value

        def initialize(value:)
          super()
          self.key_value = value
          self.apply_value = value
        end

        def apply(apply_to, key)
          apply_to[key] = key_value
        end

        # :nocov:
        def pretty_print(pp)
          pp.group(1, "#<SimpleElementContainer", ">") do
            pp.breakable
            pp.text "@key_value="
            @key_value.pretty_print(pp)
          end
        end
        # :nocov:
      end
    end
  end
end
