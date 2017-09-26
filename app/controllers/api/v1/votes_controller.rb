class Api::V1::VotesController < Api::V1::ApiController
  before_action :set_votable

  # POST /votes
  def create
    vote = Vote.find_or_initialize_by(votable: @votable, user: current_user)
    vote.rating = params[:rating]

    if vote.save
      render_json vote, VoteSerializer
    else
      render_validation_errors vote.errors, 422
    end
  end

  private

  def set_votable
    if params[:comment_id] && Comment.exists?(params[:comment_id])
      @votable = Comment.find(params[:comment_id])
    elsif params[:question_id] && Question.exists?(params[:question_id])
      @votable = Question.find(params[:question_id])
    end
  end
end
