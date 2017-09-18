class Question < ApplicationRecord
  include Votable

  default_scope { order(created_at: :desc) }

  belongs_to :user
  has_and_belongs_to_many :tags, counter_cache: true
  has_many :comments, dependent: :destroy

  validates :title, :content, length: { minimum: 1 }
  validate :tag_count

  def comments_count
    comments.size
  end

  def all_tags=(names)
    self.tags = names.split(' ').take(5).map do |name|
      Tag.where(name: name.strip.downcase).first_or_create!
    end if names
  end

  def all_tags
    self.tags
  end

  private

    def tag_count
      errors.add(
          :base,
          I18n.t(:more_tags)
      ) if tags.none?
    end
end
