namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    Person.delete_all

    Person.populate 3000 do |person|
      person.name    = Faker::Name.name
      person.company = Faker::Company.name
      person.email   = Faker::Internet.email
      person.phone   = Faker::PhoneNumber.phone_number
      person.street  = Faker::Address.street_address
      person.city    = Faker::Address.city
      person.state   = Faker::Address.state_abbr
      person.zip     = Faker::Address.zip_code
    end
  end
end
