class QuestionSerializer < QuestionsSerializer
  attributes :id, :content, :vote

  def vote
    object.voted_by(scope) if scope
  end
end
