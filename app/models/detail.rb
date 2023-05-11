class Detail < ApplicationRecord
    validates :first_name, :last_name, :age, :gender, presence: true
    belongs_to :user
    has_one_attached :image
end
