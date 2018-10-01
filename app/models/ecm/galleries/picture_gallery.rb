module Ecm::Galleries
  class PictureGallery < ApplicationRecord
    include ActsAsPublished::ActiveRecord

    has_many_attached :assets

    acts_as_published

    validates :name, presence: true, uniqueness: true

    module PictureDetails
      extend ActiveSupport::Concern

      included do
        has_many :picture_details, dependent: :destroy
        before_validation :cleanup_orphaned_picture_details
        before_validation :ensure_picture_details
      end

      def picture_details_count
        picture_details.count
      end

      private

      def cleanup_orphaned_picture_details
        picture_details.each do |picture_detail|
          picture_detail.destroy if picture_detail.asset.nil?
        end
      end

      def ensure_picture_details
        (assets - picture_details.all.map(&:asset)).map do |asset|
          build_picture_detail_for_asset(asset)
        end
      end

      def build_picture_detail_for_asset(asset)
        picture_details.build(asset: asset)
      end
    end

    include PictureDetails

    def human
      name
    end

    def assets_count
      assets.count
    end
  end
end
