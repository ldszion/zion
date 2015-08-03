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


puts "Criando modelo de usuário:"
# Emergency Contact
contact = EmergencyContact.find_by(name: 'Meu Contato de Emergência')
if(contact.nil?)
  contact = EmergencyContact.create(name: 'Meu Contato de Emergência', phone: '(XX) XXXX-XXXX',
                               kinship: :other)
end

picture = Picture.create image: File.new("#{Rails.root}/app/assets/images/perfil.jpg")

account = Account.find_by(name: 'Meu nome')
if(account.nil?)
  account = Account.create(name: 'Meu nome',
                       last_name: 'Meu sobrenome',
                       nickname: 'Meu Apelido',
                       birthday: '01/01/1901'.to_date,
                       address: 'Meu endereço',
                       gender: :male,
                       emergency_contact: contact,
                       phone: '(12) 1234-5678',
                       member: true,
                       avatar: picture)
  puts "Conta criada"
else
  puts "Conta já existente"
end


user = User.find_by(email: 'admin@gmail.com')
if(user.nil?)
  puts "Criando admin ..."
  user = User.create(email: 'admin@gmail.com',
                   password: '123456',
                   password_confirmation: '123456',
                   ward: Ward.first,
                   profile: :admin)
  puts "... OK!"
else
  puts "Admin já existente."
end

user.account = account
user.save!

puts "...OK"