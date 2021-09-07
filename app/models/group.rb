class Group < ApplicationRecord
    has_many :links

    validates :name, presence: true
    validates :grouptype, presence: true
    validates :municipality, presence: true
    validates :description, presence: false
end
