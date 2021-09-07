class Link < ApplicationRecord
  belongs_to :group

  validates :linkname, presence: true
  validates :url, presence: true
end
