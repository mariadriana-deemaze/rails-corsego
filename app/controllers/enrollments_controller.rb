class EnrollmentsController < ApplicationController
  before_action :set_course,                       only: %i[ new create ]
  before_action :set_enrollment,                   only: %i[ show edit update destroy ]

  def index
    @enrollments = Enrollment.all
    authorize @enrollments
  end

  def show
  end

  def new
    @enrollment = Enrollment.new
  end

  def edit
    authorize @enrollment
  end

  def create
    if @course.price > 0
      flash[:alert] = "You cannot access paid courses yet."
      redirect_to new_course_enrollment_path(@course)
    else
      @enrollment = current_user.enroll_to_course(@course)
      flash[:success] = "Success! Enjoy your new course."
      redirect_to course_path(@course)
    end
  end

  def update
    authorize @enrollment
    if @enrollment.update(enrollment_params)
      redirect_to @enrollment, notice: "Enrollment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @enrollment.destroy
    redirect_to enrollments_url, notice: "Enrollment was successfully destroyed."
  end

  private
    def set_course
      @course = Course.friendly.find(params[:course_id])
    end
    
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end
    
    def enrollment_params
      params.require(:enrollment).permit(:rating, :review)
    end
end
