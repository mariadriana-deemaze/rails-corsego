class EnrollmentsController < ApplicationController
  skip_before_action :authenticate_user!,          only: %i[ certificate ]
  before_action :set_course,                       only: %i[ new create ]
  before_action :set_enrollment,                   only: %i[ show edit update destroy certificate ]

  def index
    # gem 'pagy': paginate collection
    @pagy, @enrollments = pagy(Enrollment.all)

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
      EnrollmentMailer.student_enrollment(@enrollment).deliver_later
      EnrollmentMailer.teacher_enrollment(@enrollment).deliver_later
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

  # teacher
  def my_students 
    @enrollments = Enrollment.joins(:course).where(courses: {user:current_user})
    render 'index'
  end

  def certificate
    authorize @enrollment, :certificate?
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@enrollment.course.title}, #{@enrollment.user.email}",
        page_size: 'A4',
        template: "enrollments/certificate.pdf.haml"
      end
    end
  end


  private
  def set_course
    @course = Course.friendly.find(params[:course_id])
  end
  
  def set_enrollment
    @enrollment = Enrollment.friendly.find(params[:id])
  end
  
  def enrollment_params
    params.require(:enrollment).permit(:rating, :review)
  end
end
