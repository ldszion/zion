require 'rails_helper'

# Para todos os testes é necessário executar o comando:
# rake db:seed RAILS_ENV=test --trace
# para executar o mesmo arquivo seed no banco de testes
describe User do
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :profile }
  it { should respond_to :admin? }
  it { should respond_to :user? }
  it { should respond_to :ward_leader? }
  it { should respond_to :stake_leader? }
  it { should respond_to :region_leader? }

  context '#validations' do
    it { should have_secure_password }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of(:password).on(:create) }
    it 'should confirm password' do
      expect(subject.password_confirmation).to eq subject.password
    end
    it { should validate_length_of(:password).is_at_least(6).is_at_most(16) }
    it { should belong_to(:profile) }
    it { should_not be_valid }
  end

  context '#valid_user' do
    subject { User.first }
    it { should be_valid }
  end
end
