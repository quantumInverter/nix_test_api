class Comment < ApplicationRecord
  include Votable

  validates :content, length: { in: 50..300 }

  belongs_to :user
  belongs_to :question
end
