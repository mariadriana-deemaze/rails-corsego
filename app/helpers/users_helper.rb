module UsersHelper 
    def gravatar_for(email, size: 80, classes:"")
        gravatar_id = Digest::MD5::hexdigest(email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        gravatar_classes = "gravatar #{classes}"
        
        image_tag(gravatar_url, alt:"Gravatar image for #{email}", class: gravatar_classes)
    end
end
