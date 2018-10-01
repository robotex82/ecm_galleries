module Ecm
  module Galleries
    class ViewHelper
      def initialize(context)
        @context = context
      end

      def render(options = {})
        options.reverse_merge!(variant_options: {}, show_details: true)
        
        name            = options.delete(:name)
        variant_options = options.delete(:variant_options)
        show_details    = options.delete(:show_details)
        
        resource = Ecm::Galleries::PictureGallery.where(name: name).first
        c.render partial: 'ecm/galleries/view_helper/render', locals: { resource: resource, variant_options: variant_options, show_details: show_details }
      end

      private

      def c
        @context
      end
    end
  end
end
