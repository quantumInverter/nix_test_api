class Api::V1::QuestionsController < Api::V1::ApiController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_question, except: [:index, :create]
  before_action :set_tag, only: :index

  # GET /questions
  def index
    if @tag
      @questions = @tag.questions.paginate(page: params[:page], per_page: params[:per_page])
    else
      @questions = Question.paginate(page: params[:page], per_page: params[:per_page])
    end

    render_json @questions, QuestionsSerializer
  end

  # GET /questions/1
  def show
    render_json(
        @question,
        QuestionSerializer,
        200,
        current_user
    )
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.all_tags = params[:tags]

    if @question.save
      render_json @question
    else
      render_validation_errors @question.errors, 422
    end
  end

  # PATCH/PUT /questions/1
  def update
    authorize @question
    if @question.update(question_params)
      render_json(
          @question,
          QuestionSerializer,
          200,
          current_user
      )
    else
      render_validation_errors @question.errors, 422
    end
  end

  # DELETE /questions/1
  def destroy
    authorize @question
    render_responce
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.permit(:title, :content)
    end
end
