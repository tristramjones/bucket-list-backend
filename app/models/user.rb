class User < ApplicationRecord
  has_many :trips
  has_many :locations, through: :trips

  validates :name, presence: true
  validates :name, uniqueness: true
end
