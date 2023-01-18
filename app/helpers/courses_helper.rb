module CoursesHelper
    def enrollment_button(course)
        if current_user
            if course.user == current_user    
                link_to "Check analytics", course_path(course), class: "link"
            elsif course.enrollments.where(user: current_user).any?
                link_to course_path(course), class: "link" do
                    "Progress #{number_to_percentage(course.progress(current_user), precision: 0)}"
                end
            elsif course.price > 0
                link_to "Enroll", new_course_enrollment_path(course), class: "primary-button"
            else
                link_to "Free", new_course_enrollment_path(course), class: "primary-button"
            end
        else
            link_to "Check price", course_path(course), class: "primary-button"
         end
    end

    def review_button(course)

        user_course = course.enrollments.where(user: current_user)

        if current_user 
            if user_course.any?
                if user_course.pending_review.any?
                    link_to "Add a review", edit_enrollment_path(user_course.first), class: "primary-button"
                else
                    link_to "You have already reviewed.Thanks!", enrollment_path(user_course.first), class: "link"
                end
            end
        end
    end

end
