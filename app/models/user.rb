class User < ApplicationRecord
  ROLES = ['User', 'Moderator', 'Admin'].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :recoverable, :omniauthable

  has_many :votes, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :login, uniqueness: true
  validates :email, uniqueness: true

  def admin?
    role == 'Admin'
  end

  def moderator?
    admin? || role == 'Moderator'
  end

  def role
    ROLES[role_id] || 'User'
  end

  def owner_of?(something)
    id == something.user_id
  end

  has_secure_password
end
