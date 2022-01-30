class CriticPolicy < ApplicationPolicy
  def new?
    true
  end

  def create?
    !user.nil?
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
