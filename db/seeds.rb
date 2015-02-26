# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  user =  User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number,
    status: "user",

    )
  user.password ="aloma123"
  user.password_confirmation = "aloma123"

  user.save!

  user.flats.create(
    name: Faker::Lorem.sentence(word_count = 4) ,
    description: Faker::Lorem.paragraph,
    price: rand(10..200),
    street: 'Place Sainte-Gudule',
    city: "Bruxelles",
    country: "Belgique",
    zipcode: '1000'

    )

  user.flats.create(
    name: Faker::Lorem.sentence(word_count = 4) ,
    description: Faker::Lorem.paragraph,
    price: rand(10..200),
    street: 'Church Rd',
    city: 'Tullamore',
    country: 'Ireland',
    zipcode: 'Co. Offaly'



    )

  end

end