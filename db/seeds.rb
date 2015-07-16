# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# profile
adminProfile               = Profile.create name: 'Administrador', key: Profile::ADMIN
userProfile         = Profile.create name: 'Usuário', key: Profile::USER
wardLeaderProfile   = Profile.create name: 'Líder da Ala', key: Profile::WARD_LEADER
stakeLeaderProfile  = Profile.create name: 'Líder da Estaca', key: Profile::STAKE_LEADER
regionLeaderProfile = Profile.create name: 'Líder da Região', key: Profile::REGION_LEADER

user = User.create email: 'admin@gmail.com',
                   password: '123456',
                   password_confirmation: '123456',
                   profile: adminProfile

event = Event.create name: 'Acampamento do MAS 2016',
                     description: 'Acampamento para Jovens Adultos Solteiros',
                     start_datetime: '02/04/2016 09:00'.to_datetime,
                     end_datetime: '05/04/2016 17:00'.to_datetime

centroOeste = Region.create name: 'Centro Oeste'
brasiliaStake = Stake.create name: 'Brasília', region: centroOeste

# Alas
guara1            = Ward.create name: 'Guará I', stake: brasiliaStake
guara2            = Ward.create name: 'Guará II', stake: brasiliaStake
aguasClaras       = Ward.create name: 'Águas Claras', stake: brasiliaStake
agrovila          = Ward.create name: 'Agrovila', stake: brasiliaStake
nucleoBandeirante = Ward.create name: 'Núcleo Bandeirante', stake: brasiliaStake
asaSul            = Ward.create name: 'Asa Sul', stake: brasiliaStake
lagoSul           = Ward.create name: 'Lago Sul', stake: brasiliaStake

# Emergency Contact
contact = EmergencyContact.create name: 'Polyana Souza', phone: '(61) 8130-6496',
                               kinship: Person::SPOUSE

# Person Example
phone = Phone.create number: '(61) 8125-7757'
picture = Picture.create image: File.new("#{Rails.root}/app/assets/images/perfil.jpg")
person = Person.create name: 'Marco Túlio de Ávila',
                       last_name: 'Santos',
                       nickname: 'Marco',
                       birthday: '28/06/1989'.to_date,
                       address: 'Fake address',
                       gender: Person::MALE,
                       ward: guara2,
                       avatar: picture,
                       emergency_contact: contact,
                       phones: [phone],
                       member: true

user.person = person
user.save
