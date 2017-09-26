class User < ApplicationRecord
  ROLES = ['User', 'Moderator', 'Admin'].freeze
  LOGIN_REGEX = /\A[A-Za-z]+[.A-Za-z0-9_-]+[A-Za-z0-9]+\z/
  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/

  after_create :update_access_token!
  before_save :downcase_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :recoverable,
         :validatable, :omniauthable

  has_many :votes, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_attached_file :avatar,
                    :url => "/system/users/avatars/:id/:basename.png",
                    :path => ":rails_root/public:url",
                    :default_url => "/system/no-avatar.png",
                    :default_path => ":rails_root/public:default_url",
                    styles: { original: ["220x220#", :png] }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates :login, :email, uniqueness: { case_sensitive: false }
  validates :login, length: { in: 2..20 }, format: { with: LOGIN_REGEX }
  validates :email, format: { with: EMAIL_REGEX }
  validates :password, length: { in: 6..32 }

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

  def upvotes
    votes.where(rating: 1).count
  end

  def downvotes
    votes.where(rating: -1).count
  end

  def rating
    questions_id = questions.pluck(:id)
    comments_id = comments.pluck(:id)

    questions_rating = Vote.where(votable_id: questions_id, votable_type: 'Question').where.not(user_id: id).sum(:rating)
    comments_rating = Vote.where(votable_id: comments_id, votable_type: 'Comment').where.not(user_id: id).sum(:rating)

    questions_rating + comments_rating
  end

  private

    def downcase_email
      self.email.downcase!
    end

    def update_access_token!
      self.access_token = generate_access_token
      save
    end

    def generate_access_token
      loop do
        token = "#{self.id}:#{Devise.friendly_token}"
        break token unless User.where(access_token: token).first
      end
    end
end
