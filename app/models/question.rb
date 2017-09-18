class Question < ApplicationRecord
  include Votable

  default_scope { order(created_at: :desc) }

  after_create  :add_count
  after_destroy :remove_count

  belongs_to :user
  has_and_belongs_to_many :tags
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

    def add_count
      tags.each do |tag|
        Tag.increment_counter(:questions_count, tag.id)
      end
    end

    def remove_count
      tags.each do |tag|
        Tag.decrement_counter(:questions_count, tag.id)
      end
    end
end
