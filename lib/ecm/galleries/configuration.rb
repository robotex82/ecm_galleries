module Ecm::Galleries
  module Configuration
    def configure
      yield self
    end

    mattr_accessor(:base_controller) { '::FrontendController' }
    mattr_accessor(:galleries_helper_render_default_options) { { variant_options: {}, show_details: false } }
  end
end