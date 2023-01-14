module ApplicationHelper
    include Pagy::Frontend

    def page_full_title(page_title = '')
        base_title = "Corsego"
        if page_title.empty?
            base_title
        else
            base_title + " | " + page_title
        end
    end

    def format_price(price = 0)
        number_to_currency(price, unit: "€", format: "%n %u")
    end
end
