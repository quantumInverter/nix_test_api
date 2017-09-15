class Api::V1::VotesController < Api::V1::ApiController
  before_action :set_vote, only: :update

  # POST /votes
  def create
    @vote = Vote.new(vote_params)
    @vote.user = current_user

    if params[:comment_id] && Comment.exists?(params[:comment_id])
      @vote.votable = Comment.find(params[:comment_id])
    elsif Question.exists?(params[:question_id])
      @vote.votable = Question.find(params[:question_id])
    end

    render_json @vote.votable if @vote.save
  end

  # PATCH/PUT /votes/1
  def update
    render_json @vote.votable if @vote.update(vote_params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vote_params
      params.permit(:rating)
    end
end
