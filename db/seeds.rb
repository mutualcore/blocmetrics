require 'faker'

admin = User.new(
  name: 'Admin User', 
  email: 'admin@example.com',
  password: 'helloworld')
admin.skip_confirmation!
admin.save!

5.times do
	RegisteredApplication.create!(
		name: Faker::App.name,
		url: Faker::Internet.url
		)
end
registered_applications = RegisteredApplication.all

15.times do
	Event.create!(
		name: Faker::Lorem.sentence(3),
		registered_application: registered_applications.sample
		)
end

puts "Seed finished"
puts "#{Event.count} events created."
puts "#{RegisteredApplication.count} registered applications created."