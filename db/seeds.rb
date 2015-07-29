# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# profile
adminProfile        = Profile.create name: 'Administrador', key: Profile::ADMIN
userProfile         = Profile.create name: 'Usuário', key: Profile::USER
wardLeaderProfile   = Profile.create name: 'Líder da Ala', key: Profile::WARD_LEADER
stakeLeaderProfile  = Profile.create name: 'Líder da Estaca', key: Profile::STAKE_LEADER
regionLeaderProfile = Profile.create name: 'Líder da Região', key: Profile::REGION_LEADER




event = Event.find_by(name: 'Acampamento do MAS 2016')
if(event.nil?)
  print "Criando Evento modelo ..."

  event = Event.create(name: 'Acampamento do MAS 2016',
                     description: 'Acampamento para Jovens Adultos Solteiros',
                     start_datetime: '02/04/2016 09:00'.to_datetime,
                     end_datetime: '05/04/2016 17:00'.to_datetime)
  puts "... OK!"
else
  puts "Evento modelo já existente."
end


centroOeste = Region.find_by(name:"Região 1")
if(centroOeste.nil?)
  print "Criando região modelo ..."
  centroOeste = Region.create(name: "Região 1")
  puts "... OK!"
else
  puts "Região modelo já existente."
end

brasiliaStake = Stake.find_by(name: "Estaca 1")
if(brasiliaStake.nil?)
  print "Criando estaca modelo ..."
  brasiliaStake = Stake.create(name: 'Estaca 1', region: centroOeste)
  puts "... OK!"
else
  puts "Estaca modelo já existente."
end

# Alas
puts "Criando alas modelo ..."
for i in 1..8 do
  ala = Ward.find_by(name: "Ala ##{i}")
  if(ala.nil?)
    ala = Ward.create!(name: "Ala ##{i}", stake: brasiliaStake)
  else
    puts "#{ala.name} já existente."
  end
end
puts "... OK!"


puts "Criando modelo de usuário/pessoa..."
# Emergency Contact
contact = EmergencyContact.find_by(name: 'Meu Contato de Emergência')
if(contact.nil?)
  contact = EmergencyContact.create name: 'Meu Contato de Emergência', phone: '(XX) XXXX-XXXX',
                               kinship: Person::SPOUSE
end

# Person Example
phone = Phone.create number: '(12) 1234-5678'
picture = Picture.create image: File.new("#{Rails.root}/app/assets/images/perfil.jpg")

person = Person.find_by(name: 'Meu nome')
if(person.nil?)
  person = Person.create(name: 'Meu nome',
                       last_name: 'Meu sobrenome',
                       nickname: 'Meu Apelido',
                       birthday: '01/01/1901'.to_date,
                       address: 'Meu endereço',
                       gender: Person::MALE,
                       ward: Ward.first,
                       avatar: picture,
                       emergency_contact: contact,
                       phones: [phone],
                       member: true)
else
  puts "Pessoa já existente"
end


user = User.find_by(email: 'admin@gmail.com')
if(user.nil?)
  puts "Criando admin ..."
  user = User.create(email: 'admin@gmail.com',
                   password: '123456',
                   password_confirmation: '123456',
                   profile: adminProfile)
  puts "... OK!"
else
  puts "Admin já existente."
end

user.person = person
user.save

puts "...OK"