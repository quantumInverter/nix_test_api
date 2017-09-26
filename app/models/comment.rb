class Comment < ApplicationRecord
  include Votable

  validates :content, length: { in: 10..800 }

  belongs_to :user
  belongs_to :question
end
