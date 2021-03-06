module Ecm::Galleries
  class PictureGallery < ApplicationRecord
    include ActsAsPublished::ActiveRecord

    has_many_attached :assets

    acts_as_published

    validates :name, presence: true, uniqueness: true

    module PictureDetails
      extend ActiveSupport::Concern

      included do
        has_many :picture_details, -> { order(position: :asc) }, inverse_of: :picture_gallery, dependent: :destroy, autosave: true
        before_validation :cleanup_orphaned_picture_details
        before_validation :ensure_picture_details
      end

      def append_assets
        assets
      end

      def append_assets=(assets)
        self.assets = assets
      end

      def overwrite_assets
        assets
      end

      def overwrite_assets=(assets)
        return if assets.nil? || assets.empty?
        self.picture_details.map { |pd| pd.mark_for_destruction }
        self.assets = assets
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
        picture_details.build(asset: asset, published: published)
      end
    end

    include PictureDetails


    def human
      name
    end

    def assets_count
      assets.count
    end

    module DisplayCodesConcern
      extend ActiveSupport::Concern

      def display_code_for_erb
        "<%= galleries_helper(self).render(name: '#{name}') %>"
      end
    end

    include DisplayCodesConcern
  end
end
