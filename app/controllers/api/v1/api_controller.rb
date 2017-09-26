class Api::V1::ApiController < ApplicationController
  before_action :authenticate_user_from_token!

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

    def authenticate_user_from_token!
      sign_in User.first
      return
      auth_token = request.headers['Authorization']

      if auth_token
        authenticate_with_auth_token auth_token
      else
        render_error(I18n.t(:unauthorized), 401)
      end
    end

    def authenticate_user_from_token
      sign_in User.first
      return
      auth_token = request.headers['Authorization'] || ''

      user_id = auth_token.split(':').first
      user = User.where(id: user_id).first

      if user && Devise.secure_compare(user.access_token, auth_token)
        sign_in user, store: false
      end
    end

    def authenticate_with_auth_token(auth_token)
      unless auth_token.include?(':')
        render_error(I18n.t(:unauthorized), 401)
        return
      end

      user_id = auth_token.split(':').first
      user = User.where(id: user_id).first

      if user && Devise.secure_compare(user.access_token, auth_token)
        # User can access
        sign_in user, store: false
      else
        render_error(I18n.t(:unauthorized), 401)
      end
    end
end
