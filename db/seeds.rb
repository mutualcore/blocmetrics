admin = User.new(
  name: 'Admin User', 
  email: 'admin@example.com',
  password: 'helloworld')
admin.skip_confirmation!
admin.save!