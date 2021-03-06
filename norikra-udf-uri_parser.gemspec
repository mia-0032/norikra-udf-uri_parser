# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "norikra-udf-uri_parser"
  spec.version       = "0.1.2"
  spec.authors       = ["Yoshihiro MIYAI"]
  spec.email         = ["msparrow17@gmail.com"]
  spec.summary       = %q{Norikra UDF splituri() and splitquery().}
  spec.description   = %q{Parse URI and query and return value specified key.}
  spec.homepage      = "https://github.com/mia-0032/norikra-udf-uri_parser"
  spec.license       = "GPL v2"

  spec.platform      = "java"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib","jar"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency     "norikra"
end
