class User < ActiveRecord::Base
  # Include default devise modules.
  # :confirmable, :trackable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
end
