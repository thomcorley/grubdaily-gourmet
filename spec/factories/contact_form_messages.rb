FactoryBot.define do
  factory :contact_form_message do
    name { "John Doe" }
    email { "john.doe@example.com" }
    message { "Hello, I love your recipes! Could you please share more vegetarian options?" }
    subscribe { "1" }

    # Initialize the object since it's not an ActiveRecord model
    initialize_with { ContactFormMessage.new(name: name, email: email, message: message, subscribe: subscribe) }
  end

  factory :contact_form_message_no_subscribe, class: ContactFormMessage do
    name { "Jane Smith" }
    email { "jane.smith@example.com" }
    message { "Great blog! Keep up the excellent work." }
    subscribe { "0" }

    initialize_with { ContactFormMessage.new(name: name, email: email, message: message, subscribe: subscribe) }
  end

  factory :invalid_contact_form_message, class: ContactFormMessage do
    name { "" }
    email { "invalid-email" }
    message { "" }
    subscribe { nil }

    initialize_with { ContactFormMessage.new(name: name, email: email, message: message, subscribe: subscribe) }
  end
end 