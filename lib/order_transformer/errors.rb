module OrderTransformer
  class Error < StandardError
  end

  class KeyError < Error
    attr_reader :keys
    def initialize(*keys)
      super "Missing required key(s) #{keys.join(", ")}"
      @keys = keys
    end
  end

  class TransformerNotFound < Error
    attr_reader :name, :version

    def initialize(name, version)
      super "Transformer not found #{name}##{version}"
      @name = name
      @version = version
    end
  end

  class TransformerVersionNotFound < TransformerNotFound
  end
end
