class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def show? 
    self.has_access? || @record.course.bought(@user) == true
  end

  def new? 
    self.has_access?
  end

  def edit? 
    @user.present? && self.has_access?
  end
  
  def update? 
    self.has_access?
  end
  
  def destroy? 
    self.has_access?
  end
  
  def create? 
    self.has_access?
  end
  
  private

  def has_access?
    @record.course.user_id == @user.id || @user&.has_role?(:admin)
  end
end
