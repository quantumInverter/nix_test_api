RailsAdmin.config do |config|
  config.main_app_name { ['NixTest', 'Admin'] }

  ### Popular gems integration
  config.authorize_with do
    authenticate_or_request_with_http_basic('Authorization required') do |email, password|
      user = User.find_by_email(email) if email
      if user && user.authenticate(password) && user.moderator?
        config.included_models = %w(Question Comment Tag)
        config.included_models << 'User' if user.admin?
        user
      else
        nil
      end
    end
  end

  config.model "User" do
    list do
      include_fields :id, :login, :email, :birth_date
      field :avatar, :paperclip
      field :role_id do
        label "Role"
        pretty_value do
          User::ROLES[value]
        end
      end
      field :questions do
        pretty_value do
          value.count
        end
      end
      field :comments do
        pretty_value do
          value.count
        end
      end
      include_fields :country, :city, :address, :created_at, :updated_at
    end

    show do
      fields :id, :login, :email
      field :avatar, :paperclip
      field :role_id do
        label "Role"
        pretty_value do
          User::ROLES[value]
        end
      end
      fields :birth_date, :country, :city, :address, :created_at, :updated_at
      exclude_fields :password_digest
    end

    create do
      include_fields :login, :email, :role_id
      field :avatar, :paperclip
      field :password
      include_fields :birth_date, :country, :city, :address
    end

    edit do
      include_fields :login, :email, :role_id
      field :avatar, :paperclip
      field :password
      include_fields :birth_date, :country, :city, :address, :created_at, :updated_at
    end
  end

  config.model "Question" do
    list do
      include_fields  :id, :title, :content
      field   :rating
      field   :user do
        pretty_value do
          value.login
        end
      end
      field   :comments do
        pretty_value do
          value.size
        end
      end
      field   :tags
      include_fields :created_at, :updated_at
    end

    show do
      include_fields :id, :title, :content
      field   :rating
      field   :tags
      include_fields :user, :comments, :created_at, :updated_at
    end

    create do
      include_fields  :title, :content
      field   :user do
        required true
      end
      field   :tags do
        required true
      end
    end

    edit do
      include_fields :content, :title
      field :user do
        required true
      end
      field   :tags do
        required true
      end
      include_fields :created_at, :updated_at
    end
  end

  config.model "Comment" do
    list do
      include_fields  :id, :content
      field   :rating
      field   :user do
        pretty_value do
          value.login
        end
      end
      field   :question
      include_fields :created_at, :updated_at
    end

    show do
      include_fields :id, :content
      field   :rating
      field   :user
      field   :question
      include_fields :user, :created_at, :updated_at
    end

    create do
      include_fields :content
      field   :question do
        required true
      end
      field   :user do
        required true
      end
    end

    edit do
      include_fields :content
      field   :question do
        required true
      end
      field :user do
        required true
      end
      include_fields :created_at, :updated_at
    end
  end

  config.model "Tag" do
    list do
      include_fields  :id, :name, :questions_count, :created_at, :updated_at
    end

    show do
      include_fields :id, :name, :questions_count
      field   :questions
      include_fields :created_at, :updated_at
    end

    create do
      include_fields  :name, :questions_count
      field   :questions
    end

    edit do
      include_fields :name, :questions_count
      field   :questions
      include_fields :created_at, :updated_at
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    show
    edit
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
