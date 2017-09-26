class UserSerializer < UsersSerializer
  include ActionView::Helpers::DateHelper

  attributes :birth_date, :country, :city, :address, :about
  attributes :created_at, :comments, :questions, :upvotes, :downvotes, :rating

  def comments
    object.comments.count
  end

  def comments
    object.comments.count
  end

  def questions
    object.questions.count
  end

  def birth_date
    object.birth_date.strftime("Birth day: %B %d") if object.birth_date
  end

  def created_at
    "Member for " + time_ago_in_words(object.created_at)
  end
end
