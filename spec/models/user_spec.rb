require 'rails_helper'

# Para todos os testes é necessário executar o comando:
# rake db:seed RAILS_ENV=test --trace
# para executar o mesmo arquivo seed no banco de testes
describe User do
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :admin? }

  # validations
  it "should validate presence of email"
  it "should validate presence of password"
  it "should confirm password"
  it "should have password between 6 and 16 caracters"
  it "should validate presence of profile"
  it "is not valid without requirements above"
end
