class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new? 
    self.has_access?
  end

  def edit? 
    self.has_access?
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
    @user.has_any_role? :admin || @record.user = @user
  end

end
