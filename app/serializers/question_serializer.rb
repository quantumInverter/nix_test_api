class QuestionSerializer < QuestionsSerializer
  attributes :id, :vote

  def content
    object.content
  end

  def vote
    object.voted_by(scope) if scope
  end
end
