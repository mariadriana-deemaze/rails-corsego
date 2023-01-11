class CoursePolicy < ApplicationPolicy
  class Scope < Scope
  end
  
  def new? 
    self.can_edit?
  end

  def edit? 
    self.can_edit?
  end
  
  def update? 
    self.can_edit?
  end
  
  def destroy? 
    self.can_edit?
  end
  
  def create? 
    self.can_edit?
  end
  
  private

  def can_edit?
    @user.has_any_role? :admin, :teacher || @record.user = @user
  end
end
