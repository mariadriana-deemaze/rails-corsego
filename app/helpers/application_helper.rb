module ApplicationHelper
    def page_full_title(page_title = '')
        base_title = "Corsego"
        if page_title.empty?
            base_title
        else
            base_title + " | " + page_title
        end
    end
    # Include it in the helpers (e.g. application_helper.rb)
    include Pagy::Frontend
end
