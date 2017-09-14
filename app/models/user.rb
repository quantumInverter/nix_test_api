class User < ActiveRecord::Base
  # Include default devise modules.
  # :confirmable, :trackable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :validatable

  has_many :votes, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  include DeviseTokenAuth::Concerns::User
end
