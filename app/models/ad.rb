class Ad < ApplicationRecord
#validates :ad, uniqueness: { case_sensitive: true }
    belongs_to :user
    has_one_attached :image
    has_one_attached :instruction
    has_and_belongs_to_many :tags

    validates :title, presence: true
    validates :category, presence: true


 end
