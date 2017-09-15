class Api::V1::CommentsController < Api::V1::ApiController
  before_action :set_question, except: :update
  before_action :set_comments, except: :update
  before_action :set_comment, only: [:update, :destroy]

  # GET /comments
  def index
    render_json(
        @comments,
        CommentSerializer,
        200,
        current_user
    )
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.question = @question

    if @comment.save
      render_json @comments, CommentSerializer, :created
    else
      render_validation_errors @comment.errors, 422
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render_json(
          @comment,
          CommentSerializer,
          200,
          current_user
      )
    else
      render_validation_errors @comment.errors, 422
    end
  end

  # DELETE /comments/1
  def destroy
    render_json(
        @comments,
        CommentSerializer,
        200,
        current_user
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comments
      @comments = @question.comments.paginate(page: params[:page], per_page: params[:per_page])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.permit(:content)
    end
end
