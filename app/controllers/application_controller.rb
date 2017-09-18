class ApplicationController < ActionController::API
  include Pundit
  include Extensions::Renderer
  rescue_from Pundit::NotAuthorizedError, with: :not_allowed

  def not_found
    render_error(I18n.t(:page_not_found), 404)
  end

  def not_allowed
    render_error(I18n.t(:forbidden), 403)
  end
end
