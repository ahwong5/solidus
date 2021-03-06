ENV['RAILS_ENV'] = 'test'
ENV["LIB_NAME"] = 'solidus_backend'

require 'spree_backend'

require 'teaspoon'
require 'teaspoon-mocha'

unless defined?(DummyApp)
  require 'spree/testing_support/dummy_app'

  DummyApp.setup(
    gem_root: File.expand_path('../../', __FILE__),
    lib_name: 'solidus_backend'
  )
end

Teaspoon.configure do |config|
  config.mount_at = "/teaspoon"
  config.root = Spree::Backend::Engine.root
  config.asset_paths = ["spec/javascripts", "spec/javascripts/stylesheets"]
  config.fixture_paths = ["spec/javascripts/fixtures"]

  config.suite do |suite|
    suite.use_framework :mocha, "2.3.3"
    suite.matcher = "{spec/javascripts,app/assets}/**/*_spec.{js,js.coffee,coffee}"
    suite.helper = "spec_helper"
    suite.boot_partial = "/boot"
    suite.expand_assets = true
  end
end
