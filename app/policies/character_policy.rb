# frozen_string_literal: true

class CharacterPolicy < ApplicationPolicy
  def index?
    can_access?('read')
  end

  def show?
    can_access?('read')
  end

  def create?
    can_access?('create')
  end

  def update?
    can_access?('update')
  end

  def destroy?
    can_access?('delete')
  end

  def export?
    can_access?('export')
  end
end
