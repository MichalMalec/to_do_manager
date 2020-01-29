class TaskPolicy < ApplicationPolicy
  def index?
    @user
  end

  def show?
    @user && @record.in?(@user.tasks)
  end

  def create?
    @user
  end

  def update?
    @user && @record.in?(@user.tasks)
  end

  def destroy?
    @user && @record.in?(@user.tasks)
  end
end