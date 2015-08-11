require 'rails_helper'

describe Account do
  context '#responsive_methods' do
    it { should respond_to :name }
    it { should respond_to :full_name }
    it { should respond_to :last_name }
    it { should respond_to :nickname }
    it { should respond_to :birthday }
    it { should respond_to :age }
    it { should respond_to :gender }
    it { should respond_to :address }
    it { should respond_to :member }
    it { should respond_to :phone }
    it { should respond_to :avatar }
    it { should respond_to :emergency_contact }
  end

  context '#relationships' do
    it { should have_one :emergency_contact }
    it { should have_one :avatar }
    it { should belong_to :user }
    it { should accept_nested_attributes_for :emergency_contact }
    it { should accept_nested_attributes_for :avatar }
  end

  context '#validations' do
    context '#required' do
      it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
      it { should validate_uniqueness_of(:name).case_insensitive.with_message('já está em uso') }
      it { should validate_presence_of(:last_name).with_message('não pode ficar em branco') }
      it { should validate_presence_of(:birthday).with_message('não pode ficar em branco') }
      it { should validate_presence_of(:gender).with_message('não pode ficar em branco') }
      it { should validate_presence_of(:phone).with_message('não pode ficar em branco') }
      it { should validate_presence_of(:avatar).with_message('não pode ficar em branco') }
      it { should validate_presence_of(:emergency_contact).with_message('não pode ficar em branco') }
    end

    context '#not_required' do
      it { should_not validate_presence_of :member }
      it { should_not validate_presence_of :nickname }
      it { should_not validate_presence_of :address }
    end
  end

  context '#valid' do
    subject { Account.first }
    it { should be_valid }
  end
end
