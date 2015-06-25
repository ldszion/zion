# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# profile
admin               = Profile.create name: "Administrador", key: Profile::ADMIN
userProfile         = Profile.create name: "Usuário", key: Profile::USER
wardLeaderProfile   = Profile.create name: "Líder da Ala", key: Profile::WARD_LEADER
stakeLeaderProfile  = Profile.create name: "Líder da Estaca", key: Profile::STAKE_LEADER
regionLeaderProfile = Profile.create name: "Líder da Região", key: Profile::REGION_LEADER

user = User.create email: "marcotulio.avila@gmail.com",
                   password: "123456",
                   password_confirmation: "123456",
                   profile: admin

event = Event.create name: "Acampamento do MAS 2016",
                     description: "Acampamento para Jovens Adultos Solteiros",
                     start_datetime: "02/04/2016 09:00".to_datetime,
                     end_datetime: "05/04/2016 17:00".to_datetime

centroOeste = Region.create name: "Centro Oeste"
brasiliaStake = Stake.create name: "Brasília", region: centroOeste
guara2 = Ward.create name: "Guará II", stake: brasiliaStake
