require 'rails_helper'

describe Person do
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
    it { should respond_to :ward }
    it { should respond_to :ward }
    it { should respond_to :stake }
    it { should respond_to :avatar }
    it { should respond_to :phones }
    it { should respond_to :emergency_contact }
  end

  context '#relationships' do
    it { should have_many :phones }
    it { should have_one :avatar }
    it { should have_one :emergency_contact }
    it { should belong_to :ward }
    it { should accept_nested_attributes_for :phones }
    it { should accept_nested_attributes_for :avatar }
    it { should accept_nested_attributes_for :emergency_contact }
  end

  context '#validations' do
    context '#required' do
      it { should validate_presence_of(:name).with_message('obrigatório') }
      it { should validate_presence_of(:last_name).with_message('obrigatório') }
      it { should validate_presence_of(:birthday).with_message('obrigatório') }
      it { should validate_presence_of(:gender).with_message('obrigatório') }
      it { should validate_presence_of(:address).with_message('obrigatório') }
      it { should validate_presence_of(:ward).with_message('obrigatória') }
      it { should validate_presence_of(:phones).with_message('obrigatório') }
      it { should validate_presence_of(:avatar).with_message('obrigatório') }
      it { should validate_presence_of(:emergency_contact).with_message('obrigatório') }
    end

    context '#not_required' do
      it { should_not validate_presence_of :member }
      it { should_not validate_presence_of :nickname }
    end
  end

  context '#valid' do
    subject { Person.first }
    it { should be_valid }
  end
end
