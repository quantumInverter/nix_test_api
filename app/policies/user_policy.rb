class UserPolicy < ApplicationPolicy
  private

    def can?
      user.admin? || user.id == something.id
    end
end
