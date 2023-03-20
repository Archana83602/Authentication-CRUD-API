class Detail < ApplicationRecord
    attr_accessor :image
    validates :first_name, :last_name, :age, :gender, presence: true
    belongs_to :user
    has_one_attached :image_url
end
