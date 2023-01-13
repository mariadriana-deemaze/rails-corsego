class LessonsController < ApplicationController
  before_action :set_course, only: %i[ show new create edit update destroy ]
  before_action :set_lesson, only: %i[ show edit update destroy ]

  def index
    @lessons = Lesson.all
  end

  def show
  end

  def new
    @lesson = Lesson.new
  end

  def edit
    authorize @lesson
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.course_id = @course.id

    if @lesson.save
      redirect_to course_lesson_path(@course, @lesson)
      flash[:success] = "Lesson was successfully created."
    else
      render :new
      flash[:danger] = @lesson.errors
    end
  end

  def update
    authorize @lesson
    if @lesson.update(lesson_params)
      redirect_to course_lesson_path(@course, @lesson)
      flash.now[:success] = "Lesson was successfully updated."
    else
      render :edit
      flash.now[:danger] = @lesson.errors
    end
  end

  def destroy
    authorize @lesson
    @lesson.destroy
    redirect_to lessons_url
    flash.now[:success] = "Lesson was successfully destroyed."
  end

  private
    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    def set_lesson
      @lesson = Lesson.friendly.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:title, :content, :course_id)
    end
end
