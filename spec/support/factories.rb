Factory.sequence :email do |n|
  "fake.#{Time.now.to_i}-#{n}@example.com"
end

Factory.sequence :artist_name do |n|
  "Artist#{Time.now.to_i}-#{n}"
end

Factory.define(:user) do |user|
  user.email       { Factory.next(:email) }
  user.artist_name { Factory.next(:artist_name) }
  user.password "password"
  user.password_confirmation "password"
end

