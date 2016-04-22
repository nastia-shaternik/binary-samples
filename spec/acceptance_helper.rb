require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'
require 'support/factory_girl'

RspecApiDocumentation.configure do |config|
  config.format = :json
  config.docs_dir = Rails.root.join("doc", "api")
  config.api_name = "Binary Samples API"
  config.request_headers_to_include = ["Accept", "Content-Type"]
  config.response_headers_to_include = ["Content-Type", "Cache-control"]
end
