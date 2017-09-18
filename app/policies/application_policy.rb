class ApplicationPolicy
  attr_reader :user, :something

  def initialize(user, something)
    @user = user
    @something = something
  end

  def update?
    can?
  end

  def destroy?
    can?
  end

  private

    def can?
      user.moderator? || user.owner_of?(something)
    end
end
