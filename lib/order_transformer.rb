require "order_transformer/version"
require "order_transformer/data_navigation"
require "order_transformer/transformation"
require "order_transformer/dsl"

module OrderTransformer
  class Error < StandardError; end

  class KeyError < StandardError
    attr_reader :keys
    def initialize(*keys)
      super "Missing required key(s) #{keys.join(", ")}"
      @keys = keys
    end
  end
end
