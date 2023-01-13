class CoursesController < ApplicationController
  before_action :set_course,           only: %i[ show edit update destroy ]
  before_action :authorization_policy, only: %i[ edit ]

  def index
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
    @courses = @ransack_courses.result.includes(:user)
  end

  def show
    @lessons = @course.lesson
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    @course.user = current_user

    if @course.save
      flash.now[:success] = "Course was successfully created."
      render :show
    else
      flash.now[:danger] = @course.errors
      @course.errors
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to course_url(@course)
      flash[:success] = "Course was successfully updated."
      render :show
    else
      flash[:danger] = @course.errors
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_url
    flash[:success] = "Course was successfully destroyed."
  end

  private
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    def authorization_policy
      authorize @course
    end

    def course_params
      params.require(:course).permit(:title, :description, :short_description, :language, :level, :price)
    end
end
