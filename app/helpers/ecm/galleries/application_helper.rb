module Ecm::Galleries
  module ApplicationHelper
    def ecm_galleries_helper(context)
      @ecm_galleries_helper ||= Ecm::Galleries::ViewHelper.new(context)
    end
  end
end
