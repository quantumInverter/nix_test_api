class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email    = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email) if email
    return user if user && user.authenticate(password)

    errors.add :auth, 'invalid_credentials'
    nil
  end
end