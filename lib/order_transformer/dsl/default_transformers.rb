module OrderTransformer
  module DSL
    module DefaultTransformers
      def join(chain=nil, with: " ")
        chain ||= MethodChain.new
        chain.add ->(*args) { args.join(with) }
      end

      def compact(chain=nil)
        chain ||= MethodChain.new
        chain.add ->(*args) { args.compact }
      end
    end
  end
end
