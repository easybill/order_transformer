module OrderTransformer
  module DataNavigation
    module ResultBuilder
      class ArrayElementContainer
        attr_accessor :key_value, :apply_value

        def initialize
          super
          self.key_value = []
          self.apply_value = nil
        end

        def add_item(index: nil)
          if index
            key_value[index] ||= {}
            self.apply_value = key_value[index]
          else
            self.apply_value = {}.tap do |res|
              key_value.push res
            end
          end
        end

        def apply(apply_to, key)
          if apply_to.key? key
            self.key_value = apply_to[key]
          else
            apply_to[key] = key_value
          end
        end

        def pretty_print(pp)
          pp.group(1, "#<ArrayElementContainer", ">") do
          end
        end
      end
    end
  end
end
