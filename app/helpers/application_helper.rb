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

    def format_date(date)
        date.strftime("%Y/%m/%d at %H:%M")
    end
end
