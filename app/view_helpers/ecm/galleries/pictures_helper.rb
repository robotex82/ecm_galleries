module Ecm
  module Galleries
    # Usage:
    #
    #     # app/controllers/application_vontroller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Ecm::Galleries::PicturesHelper, as: :pictures_helper
    #       # ...
    #     end
    #
    #     # app/views/home/index.html.haml
    #     = pictures_helper(self).render(name: 'main', variant_options: { combine_options: { resize: "255x255^", extent: "255x255", gravity: "center"} }, show_details: true)
    #
    # Default options are taken from Ecm::Galleries::Configuration.pictures_helper_render_default_options.
    # You can set this option in the initializer.
    #
    # You can pass the image_tag_only option to render just the <img>-tag without a bootstrap card.
    #
    class PicturesHelper < ViewHelper::Base
      def initialize(context)
        @context = context
      end

      def render(options = {})
        options.reverse_merge!(Ecm::Galleries::Configuration.pictures_helper_render_default_options)
        
        id              = options.delete(:id)
        variant_options = options.delete(:variant_options) || {}
        show_details    = options.delete(:show_details)
        image_tag_only  = options.delete(:image_tag_only)
        
        resource = Ecm::Galleries::PictureDetail.where(id: id).first
        c.render partial: 'ecm/galleries/pictures_helper/render', locals: { resource: resource, variant_options: variant_options, show_details: show_details, image_tag_only: image_tag_only }
      end
    end
  end
end
