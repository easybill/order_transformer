module OrderTransformer
  module DSL
    module DefaultTransformers
      require "bigdecimal"
      require "bigdecimal/util"

      def join(chain = nil, with: " ")
        chain ||= MethodChain.new
        chain.add ->(*args) { args.join(with) }
      end

      def compact(chain = nil)
        chain ||= MethodChain.new
        chain.add ->(*args) { args.compact }
      end

      def strip(chain = nil)
        chain ||= MethodChain.new
        chain.add ->(*args) { args.map(&:strip) }
      end

      def to_d(chain = nil)
        chain ||= MethodChain.new
        chain.add ->(*args) { (args.first || "0").to_d }
      end
    end
  end
end
