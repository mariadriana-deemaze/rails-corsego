class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def owner?
    @user.present? && @record.user == @user 
  end

  def new? 
    self.has_access?
  end

  def show? 
    visible = @record.published && @record.approved
    isAdmin = @user.present? && @user.has_role?(:admin)
    purchased = @user.present? && @record.bought(@user)
    visible || isAdmin || purchased
  end

  def edit? 
    self.has_access?
  end
  
  def update? 
    self.has_access?
  end
  
  def destroy? 
    self.has_access? && @record.enrollments.none?
  end
  
  def create? 
    self.has_access?
  end

  def approve?
    @user.present? && @user.has_role?(:admin)
  end

  def publish?
    @user.present? && self.has_access?
  end

  private

  def has_access?
    @record.user == @user || @user&.has_any_role?(:admin, :teacher)
  end
end
