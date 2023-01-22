class LessonsController < ApplicationController
  before_action :set_lesson,           only: %i[ show edit update destroy delete_video]
  before_action :authorization_policy, only: %i[ show edit update destroy delete_video]

  def index
    @lessons = Lesson.all
  end

  def show
    current_user.mark_as_viewed(@lesson)
    @lessons = @course.lessons.rank(:row_order)
    @comment = Comment.new
    @comments = @lesson.comments.order(created_at: :desc)
  end

  def new
    @course = Course.friendly.find(params[:course_id])
    @lesson = Lesson.new
  end

  def edit
  end

  def create
    @course = Course.friendly.find(params[:course_id])
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
    if @lesson.update(lesson_params)
      redirect_to course_lesson_path(@course, @lesson)
      flash.now[:success] = "Lesson was successfully updated."
    else
      render :edit
      flash.now[:danger] = @lesson.errors
    end
  end

  def destroy
    @lesson.destroy
    redirect_to course_path(@course)
    flash.now[:success] = "Lesson was successfully destroyed."
  end

  def sort
    @course = Course.friendly.find(params[:course_id])
    lesson = Lesson.friendly.find(params[:lesson_id])
    authorize lesson, :edit?
    lesson.update(lesson_params)
    render body: nil
  end

  def delete_video
    authorize @lesson, :edit?
    @lesson.video.purge
    @lesson.video_thumbnail.purge
    redirect_to edit_course_lesson_path(@course, @lesson), notice: 'Video successfully deleted!'
  end

  private
    def set_lesson
      @course = Course.friendly.find(params[:course_id])
      @lesson = Lesson.friendly.find(params[:id])
    end

    def authorization_policy
      authorize @lesson
    end

    def lesson_params
      params.require(:lesson).permit(:title, :content, :course_id, :row_order_position, :video, :video_thumbnail)
    end
end
