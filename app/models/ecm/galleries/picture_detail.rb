module Ecm::Galleries
  class PictureDetail < ApplicationRecord
    include ActsAsPublished::ActiveRecord

    belongs_to :picture_gallery
    belongs_to :asset, class_name: 'ActiveStorage::Attachment', dependent: :destroy

    acts_as_list scope: :picture_gallery
  end
end
