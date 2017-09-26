class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :authenticate_user_from_token!, only: :create
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users/1
  def show
    render_json @user, UserSerializer
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render_json @user, SessionSerializer
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(
          :email,
          :login,
          :password,
          :password_confirmation,
          :avatar,
          :country,
          :city,
          :address,
          :birth_date,
          :about
      )
    end
end
