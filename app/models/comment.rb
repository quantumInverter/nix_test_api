class Comment < ApplicationRecord
  include Votable

  belongs_to :user
  belongs_to :question
end
