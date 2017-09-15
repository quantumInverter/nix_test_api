class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :login, uniqueness: true
  validates :email, uniqueness: true

  has_secure_password
end
