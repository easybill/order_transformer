module OrderTransformer
  module DSL
    module DefaultTransformers
      require "bigdecimal"
      require "bigdecimal/util"

      def join(chain = nil, with: " ")
        chain ||= __create_method_chain(caller(1, 1))
        chain.add ->(*args) { args&.join(with) }
      end

      def date_time_parse(chain = nil)
        chain ||= __create_method_chain(caller(1, 1))
        chain.add ->(date_str) { begin; DateTime.parse(date_str); rescue; nil; end }
      end

      def compact(chain = nil)
        chain ||= __create_method_chain(caller(1, 1))
        chain.add ->(*args) { args&.compact }
      end

      def strip(chain = nil)
        chain ||= __create_method_chain(caller(1, 1))
        chain.add ->(*args) { args&.map { |v| v&.strip } }
      end

      def to_d(chain = nil)
        chain ||= __create_method_chain(caller(1, 1))
        chain.add ->(*args) { (args&.first || "0").to_d }
      end

      def __create_method_chain(caller_string)
        (file, line, caller_name) = (caller_string || "").first.split(":")

        MethodChain.new(file: file, line: line, caller_name: caller_name)
      end
    end
  end
end
