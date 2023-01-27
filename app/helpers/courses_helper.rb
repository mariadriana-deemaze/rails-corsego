module CoursesHelper
    def enrollment_button(course)
        if current_user
            if current_user.has_role?("admin")
                link_to "Evaluate", course_path(course), class: "primary-button"
            elsif course.user == current_user    
                link_to "Check analytics", statistics_path, class: "link"
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
            link_to "Check price", new_course_enrollment_path(course), class: "primary-button"
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


    def certificate_button(course)
        user_course = course.enrollments.where(user: current_user)
        if current_user
            if user_course.any?
                if course.progress(current_user) == 100
                    link_to certificate_enrollment_path(user_course.first, format: :pdf), class:"secondary-button flex flex-row gap-4" do
                        "<svg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke-width='1.5' stroke='currentColor' class='w-6 h-6'>
                        <path stroke-linecap='round' stroke-linejoin='round' d='M19.5 14.25v-2.625a3.375 3.375 0 00-3.375-3.375h-1.5A1.125 1.125 0 0113.5 7.125v-1.5a3.375 3.375 0 00-3.375-3.375H8.25m2.25 0H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 00-9-9z' />
                      </svg>".html_safe + " " +
                        "Certificate of Completion"
                    end
                else
                    "Certificate available after completion"
                end
            end
        end
    end

end
