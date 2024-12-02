class CharacterPolicy < ApplicationPolicy
  def index?
    true if can_access?('read')
  end

  def show?
    true if can_access?('read')
  end

  def create?
    true if can_access?('create')
  end

  def update?
    true if can_access?('update')
  end

  def destroy?
    true if can_access?('delete')
  end

  def export?
    true if can_access?('export')
  end
end
