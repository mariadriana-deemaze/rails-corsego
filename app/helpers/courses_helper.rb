module CoursesHelper
    def enrollment_button(course)
        if current_user
            if course.user == current_user    
                link_to "Check analytics", course_path(course), class: "link"
            elsif course.enrollments.where(user: current_user).any?
                link_to "Go to course", course_path(course), class: "link"
            elsif course.price > 0
                link_to "Enroll", new_course_enrollment_path(course), class: "primary-button"
            else
                link_to "Free", new_course_enrollment_path(course), class: "primary-button"
            end
        else
            link_to "Check price", course_path(course), class: "primary-button"
         end
    end

end
