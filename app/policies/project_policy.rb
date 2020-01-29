class ProjectPolicy < ApplicationPolicy
  def index?
    @user
  end

  def show?
    @user && @record.in?(@user.projects)
  end

  def create?
    @user
  end

  def update?
    @user && @record.in?(@user.projects)
  end

  def destroy?
    @user && @record.in?(@user.projects)
  end
end