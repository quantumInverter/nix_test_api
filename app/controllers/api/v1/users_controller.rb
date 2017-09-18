class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :authenticate_request, only: [:create, :sign_in]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users/1
  def show
    render_json @user, UserSerializer
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      command = AuthenticateUser.call(params[:email], params[:password])
      auth_token = { auth_token: command.result } if command.success?

      render_responce(
          'success',
          render_model(@user, UserSerializer),
          auth_token
      )
    else
      render_validation_errors @user.errors, 422
    end
  end

  # PATCH/PUT /users/1
  def update
    authorize @user
    if @user.update(user_params)
      render_json @user, UserSerializer
    else
      render_validation_errors @user.errors, 422
    end
  end

  # DELETE /users/1
  def destroy
    authorize @user
    render_responce 'success'
  end

  # POST /sign_in
  def sign_in
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      auth_token = { auth_token: command.result }
      user = User.find_by_email(params[:email])
      render_responce(
          'success',
          render_model(user, UserSerializer),
          auth_token
      )
    else
      render_error(I18n.t(:unprocessible_entity), 422)
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:email, :login, :password, :password_confirmation, :avatar)
    end
end
