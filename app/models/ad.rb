class Ad < ApplicationRecord
    has_one_attached :image
    has_one_attached :instruction
    has_and_belongs_to_many :tags

 end
 