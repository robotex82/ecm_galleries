module Ecm::Galleries
  class ApplicationResourcesController < Ecm::Blog::Configuration.base_controller.constantize
    include ::ResourcesController::RestActions
    include ::ResourcesController::Resources
    include ::ResourcesController::RestResourceUrls
    include ::ResourcesController::ResourceInflections
    include ::ResourcesController::LocationHistory
    include ::Controller::QueryConditions

    helper Twitter::Bootstrap::Components::Rails::V4::ComponentsHelper

    private

    def load_collection_scope
      add_conditions_from_query(resource_class)
    end
  end
end
