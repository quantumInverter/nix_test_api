class Api::V1::ApiController < ApplicationController
  attr_reader   :current_user
  before_action :authenticate_user!

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      if Question.exists?(params[:question_id])
        @question = Question.find(params[:question_id])
      else
        render_error(I18n.t(:not_found), 404)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.where(id: params[:tag]).first
    end

  protected

    def authenticate_user!
      if user_signed_in?
        super
      else
        render_error(I18n.t(:forbidden), 404)
      end
    end
end
