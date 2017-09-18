module Extensions::Renderer

  def render_responce(status = 'success', data = nil, extras = {}, status_code = 200)
    response = {}
    response[:response] = status
    response[:data] = data if data

    render json: response.merge(extras), status: status_code
  end

  def render_error(message, code)
    data = { message: message }
    extras = { code: code }

    render_responce('error', data, extras, code)
  end

  def render_validation_errors(errors, code)
    data = []

    errors.each do |key, value|
      data << "#{key.capitalize} #{value}"
    end

    extras = { code: code }

    render_responce('error', data, extras, code)
  end

  def render_json(render_data, serializer = nil, status = 200, scope = nil)
    response = 'success'
    pagination = {}

    if render_data.is_a? Enumerable
      data = render_each(render_data, serializer, scope)
      pagination[:pagination] = make_pagination(render_data)
    else
      data = render_model(render_data, serializer, scope)
    end

    render_responce(response, data, pagination, status)
  end

  protected

    def render_each(render_data, serializer, scope = nil)
      ActiveModelSerializers::SerializableResource.new(
          render_data,
          each_serializer: serializer,
          scope: scope
      )
    end

    def render_model(render_data, serializer, scope = nil)
      ActiveModelSerializers::SerializableResource.new(
          render_data,
          serializer: serializer,
          scope: scope
      )
    end

    def make_pagination(render_data)
      {
        current_page: render_data.current_page,
        per_page: render_data.per_page,
        total_entries: render_data.total_entries
      }
    end
end