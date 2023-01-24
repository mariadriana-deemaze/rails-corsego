class CheckoutsController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[ create success error ]
    before_action :set_course, only: %i[ create ]

    def create
        if @course.price > 0
            session_params = {
                mode: 'payment',
                line_items: [
                {
                    price: @course.stripe_price_id, 
                    quantity: 1
                    },
                ],
                success_url: root_url + checkout_success_path + "?session_id={CHECKOUT_SESSION_ID}",
                cancel_url: root_url + checkout_cancel_path + "?session_id={CHECKOUT_SESSION_ID}",
            }
            
            if !current_user.stripe_customer_id.nil?
                session_params[:customer] = current_user.stripe_customer_id.present
            else 
                session_params[:customer_email] = current_user.email
            end
            
            @checkout_session = Stripe::Checkout::Session.create(session_params)
    
            redirect_to @checkout_session.url, allow_other_host: true
        else 
            enroll(@course)
            redirect_to course_path(@course)
        end
    end
    
    def success
        if params[:session_id].present? 
            @course = product_from_session(params[:session_id])
            enroll(@course)
        else
            flash.now[:error] = "An internal error has ocurred! Please contact support at info@idk.com to check your enrollment status."
            redirect_to root_path
        end
    end
    
    def cancel
        if params[:session_id].present? 
            @course = product_from_session(params[:session_id])
            Stripe::Checkout::Session.expire(params[:session_id])
        else
            flash.now[:error] = "An error with the operation has ocurred"
            redirect_to root_path
        end
    end

    private
    
    def product_from_session(session_id) 
        @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ["line_items"]})
        session_product = @session_with_expand.line_items.data[0]
        product_id = session_product.price.product
        @course = Course.find_by(stripe_product_id: product_id)
        return @course
    end

    def enroll(course)
        @enrollment = current_user.enroll_to_course(course)
        flash.now[:success] = "Success! Enjoy your new course."
        EnrollmentMailer.student_enrollment(@enrollment).deliver_later
        EnrollmentMailer.teacher_enrollment(@enrollment).deliver_later
    end

    private
    
    def set_course 
        @course = Course.friendly.find(params[:course])
    end

end
