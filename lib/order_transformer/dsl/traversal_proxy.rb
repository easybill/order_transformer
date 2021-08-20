module OrderTransformer
  module DSL
    class TraversalProxy
      include DefaultTransformers

      attr_reader :each_traversal_proxies, :within_traversal_proxies, :transformation_definitions

      def __create_transformation
        result = @transformation_definitions.map do |definition|
          definition = definition.clone
          type = definition.delete :type
          target_class = case type
                         when :const
                           Transformation::ConstTransformation
                         when :remove
                           Transformation::RemoveTransformation
                         else
                           Transformation::SimpleTransformation
          end

          target_class.new(**definition)
        end

        within_traversal_proxies.each do |definiton|
          result.push Transformation::WithinTransformation.new key_name: definiton[:key_name],
            optional: definiton[:optional],
            transformations: definiton[:proxy].__create_transformation
        end

        each_traversal_proxies.each do |definiton|
          result.push Transformation::WitheachTransformation.new key_name: definiton[:key_name],
            optional: definiton[:optional],
            transformations: definiton[:proxy].__create_transformation
        end

        result
      end

      def initialize
        super
        @each_traversal_proxies = []
        @within_traversal_proxies = []
        @transformation_definitions = []
      end

      def within(name, optional: true, &block)
        traversal_proxy = TraversalProxy.new
        traversal_proxy.instance_eval(&block) if block

        within_traversal_proxies.push({key_name: name.to_s, proxy: traversal_proxy, optional: optional})
      end

      def with_each(name, optional: true, &block)
        traversal_proxy = TraversalProxy.new
        traversal_proxy.instance_eval(&block) if block

        each_traversal_proxies.push({key_name: name.to_s, proxy: traversal_proxy, optional: optional})
      end

      def transform(*key_names, to:, optional: true, transformer: nil)
        transformer ||= if key_names.size > 1
          ->(*values) { values }
        else
          ->(value) { value }
        end

        @transformation_definitions.push({
          type: :simple,
          key_names: key_names,
          to: to,
          transformer: transformer,
          optional: optional
        })
      end

      def remove_entry(name)
        @transformation_definitions.push({
          type: :remove,
          key_name: name
        })
      end

      def const(to:, value:)
        @transformation_definitions.push({
          type: :const,
          to: to,
          value: value
        })
      end
    end
  end
end
