class Api::V1::TagsController < ApplicationController

  def index
    render_responce(
        'success',
        render_each(Tag.limit(params[:count]),TagSerializer)
    )
  end
end
