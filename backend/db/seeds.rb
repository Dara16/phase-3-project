Tenement.destroy_all

5.times do
    Tenement.create(name: "#{Faker::Space.constellation} Block", address: Faker::Address.city)
end

puts 'Tenement Seeded'

Apartment.destroy_all

tenements = Tenement.all

apartment_types = ['one bedroom', 'two bedroom', 'three bedroom']
apartment_rent_prices = [150000, 200000, 250000]

50.times do
    Apartment.create(
        number: Faker::Number.within(range:101..150), 
        style: apartment_types.sample, 
        rent: apartment_rent_prices.sample, 
        tenement: tenements.sample
        )
end

puts 'Apartments Seeded'

Occupant.destroy_all

apartments = Apartment.all

100.times do
    Occupant.create(
        name: Faker::Name.name, 
        lease_end:Faker::Date.forward(days: 100), 
        apartment: apartments.sample, 
        tenement: tenements.sample
        )
end

puts 'Occupants seeded'

puts 'Seeding complete'