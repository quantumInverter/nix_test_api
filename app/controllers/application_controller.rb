class ApplicationController < ActionController::API
  include Extensions::Renderer

  def not_found
    render_error(I18n.t(:page_not_found), 404)
  end

  def null_image
    render json: nil
  end
end
