FactoryBot.define do
  factory :ip_address do
    sequence(:name) { |n| "User #{n}" }
    sequence(:ip_address) { |n| "192.168.1.#{n}" }
    admin_access { false }
    admin_access_expires { nil }
  end

  factory :admin_ip_address, class: IpAddress do
    sequence(:name) { |n| "Admin User #{n}" }
    sequence(:ip_address) { |n| "10.0.0.#{n}" }
    admin_access { true }
    admin_access_expires { 1.week.from_now }
  end

  factory :expired_admin_ip_address, class: IpAddress do
    sequence(:name) { |n| "Expired Admin #{n}" }
    sequence(:ip_address) { |n| "172.16.0.#{n}" }
    admin_access { true }
    admin_access_expires { 1.week.ago }
  end
end 