module OrderTransformer
  module DataNavigation
    module ResultBuilder
      class HashElementContainer
        attr_accessor :key_value, :apply_value

        def initialize
          super
          self.key_value = {}
          self.apply_value = key_value
        end

        def apply(apply_to, key)
          apply_to[key] ||= key_value
          self.apply_value = apply_to[key]

          apply_to[key]
        end

        def pretty_print(pp)
          pp.group(1, "#<HashElementContainer", ">") do
          end
        end
      end
    end
  end
end
