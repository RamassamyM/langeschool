class Content < ApplicationRecord
  validates :text, :location, presence: true
end
