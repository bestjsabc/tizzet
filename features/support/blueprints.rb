require 'machinist/active_record'
require 'sham'
require 'faker'

User.blueprint do
  name {Faker::Name.name}
  login {name.gsub(' ', '_')}
  password {User.random_password}
  password_confirmation {password}
  email {Faker::Internet.email}
end

Sham.artist {Faker::Name.name}
Sham.event( :unique => false ) { %w{ Australian World Massive Awesome }.rand + ' ' + %w{ tour concert gig festival workshop }.rand }
Sham.date do
  Date.civil((2009...2012).to_a.rand,
             (1..12).to_a.rand,
             (1..28).to_a.rand)
end
Sham.place( :unique => false ) { ["St Kilda", "The Myer Music Bowl", "The Metro", "Jells Park"].rand }
Sham.seating( :unique => false ) { Ticket.seating_types.rand }
Sham.event_type( :unique => false ) {Ticket.event_types.rand }

Ticket.blueprint do
  event_type { Sham.event_type }
  date {Sham.date}
  location {Sham.place}
  host { Sham.artist }
  visitor {Sham.artist}
  quantity {rand(10) + 1}
  event {Sham.event}
  seating_type { Sham.seating }
  individual_sales { [true, false].rand }
  seller {User.make}
  price_in_cents {(100..10000).to_a.rand}
end


