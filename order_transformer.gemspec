require_relative 'lib/order_transformer/version'

Gem::Specification.new do |spec|
  spec.name          = "order_transformer"
  spec.version       = OrderTransformer::VERSION
  spec.licenses       = ["Nonstandard"]
  spec.authors       = ["Dieter Späth"]
  spec.email         = ["dieter.spaeth@easybill.de"]

  spec.summary       = %q{Transform orders}
  spec.description   = %q{Transform hash input of order to internal orders}
  spec.homepage      = "https://www.easybill.de"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://www.easybill.de"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.easybill.de"
  spec.metadata["changelog_uri"] = "https://www.easybill.de"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.19"
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "standard", "1.1.7"
  spec.add_development_dependency "pry-byebug", "~> 3.9"
  spec.add_development_dependency "super_diff", "~> 0.8"
  spec.add_development_dependency "gem-release", "~> 2.2"
  spec.add_development_dependency "license_finder", "~> 6.0"
end
