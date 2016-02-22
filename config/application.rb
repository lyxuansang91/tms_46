require File.expand_path("../boot", __FILE__)

require "rails/all"

Bundler.require(*Rails.groups)

module BaseApp
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: true
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
