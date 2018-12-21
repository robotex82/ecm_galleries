Ecm::Galleries.configure do |config|
  # Set the base controller for the page controller
  #
  # Default: config.base_controller = '<%= base_controller_class_name %>'
  #
  config.base_controller = '<%= base_controller_class_name %>'

  # These options are the defaults that will be applied to when rendering
  # galleries through the galleries helper.
  #
  #  Default: config.galleries_helper_render_default_options = { variant_options: {}, show_details: false }
  #
  config.galleries_helper_render_default_options = { variant_options: {}, show_details: false }
end
