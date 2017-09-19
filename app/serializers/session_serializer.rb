class SessionSerializer < UserSerializer
  attributes :token_type, :access_token

  def token_type
    'Bearer'
  end
end