event = Event.find_by(name: 'Acampamento do MAS 2016')
if event.nil?
  print 'Criando Evento modelo ...'

  event = Event.create(name: 'Acampamento do MAS 2016',
                       description: 'Acampamento para Jovens Adultos Solteiros',
                       start_datetime: '02/04/2016 09:00'.to_datetime,
                       end_datetime: '05/04/2016 17:00'.to_datetime)
  puts '... OK!'
else
  puts 'Evento modelo já existente.'
end

centro_oeste = Region.find_by(name: 'Região 1')
if centro_oeste.nil?
  print 'Criando Região modelo ...'
  centro_oeste = Region.create(name: 'Região 1')
  puts '... OK!'
else
  puts 'Região modelo já existente.'
end

brasilia_stake = Stake.find_by(name: 'Estaca 1')
if brasilia_stake.nil?
  print 'Criando Estaca modelo ...'
  brasilia_stake = Stake.create(name: 'Estaca 1', region: centro_oeste)
  puts '... OK!'
else
  puts 'Estaca modelo já existente.'
end

# Alas
print 'Criando Alas modelo ...'
(1..8).each do |i|
  ala = Ward.find_by(name: "Ala ##{i}")
  if ala.nil?
    ala = Ward.create!(name: "Ala ##{i}", stake: brasilia_stake)
  else
    puts "#{ala.name} já existente."
  end
end
puts '... OK!'

puts 'Criando modelo de usuário:'
# Emergency Contact
contact = EmergencyContact.find_by(name: 'Meu Contato de Emergência')
if contact.nil?
  contact = EmergencyContact.create(name: 'Meu Contato de Emergência',
                                    phone: '(61) 9876-5432',
                                    kinship: :other)
end

picture = Picture.create image: File.new("#{Rails.root}/app/assets/images/perfil.jpg")

account = Account.find_by(name: 'Meu nome')
if account.nil?
  print 'Criando Conta ...'
  account = Account.create(name: 'Meu nome',
                           last_name: 'Meu sobrenome',
                           nickname: 'Meu Apelido',
                           birthday: '12/02/1989'.to_date,
                           address: 'Meu endereço',
                           emergency_contact: contact,
                           phone: '(12) 1234-5678',
                           member: true,
                           avatar: picture)
  account.gender = 'male'
  account.save!
  puts '... OK!'
else
  puts '... Conta já existente'
end

user = User.find_by(email: 'admin@gmail.com')
if user.nil?
  print 'Criando usuário Admin ...'
  user = User.create(email: 'admin@gmail.com',
                     password: '123456',
                     password_confirmation: '123456',
                     ward: Ward.first,
                     active: true,
                     profile: :admin)
  puts '... OK!'
else
  puts '... Admin já existente.'
end

user.account = account
user.save!

puts 'Concluído com sucesso.'
