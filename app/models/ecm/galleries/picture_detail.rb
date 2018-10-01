module Ecm::Galleries
  class PictureDetail < ApplicationRecord
    belongs_to :picture_gallery
    belongs_to :asset, class_name: 'ActiveStorage::Attachment', dependent: :destroy
  end
end
