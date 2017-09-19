class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate_user_from_token!

  # POST /api/v1/login
  def create
    @user = User.find_for_database_authentication(email: params[:email])
    return invalid_login_attempt unless @user

    if @user.valid_password?(params[:password])
      sign_in :user, @user
      render_json @user, SessionSerializer, :created
    else
      invalid_login_attempt
    end
  end

  private

    def invalid_login_attempt
      warden.custom_failure!
      render_error(I18n.t(:unprocessible_entity), 422)
    end
end