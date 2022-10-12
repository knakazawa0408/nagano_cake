class Genre < ApplicationRecord
  has_many :itmes, dependent: :destroy
end
