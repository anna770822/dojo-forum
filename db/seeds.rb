# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#create admin user
  User.destroy_all
  User.create!(
    email: "admin@example.com", password: "12345678", role: "Admin"
    )
  puts "Default admin created!"

# create fake user

  url = "https://uinames.com/api/?ext&region=england"

  20.times do 
    response = RestClient.get(url)
    data = JSON.parse(response.body)
    user = User.create!(
      name: data["name"],
      email: data["email"],
      password: data["password"],
      avatar: data["photo"],
      role: "Normal"
      )
  end
  puts "fake user created!"