class Asset < ApplicationRecord
  belongs_to :post
  validates :post, :url, :asset_type, presence: true

end
