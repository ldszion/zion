require 'rails_helper'

describe EmergencyContact, type: :model do
  context '#responsive_methods' do
    it { should respond_to :name }
    it { should respond_to :phone }
    it { should respond_to :kinship }
    it { should respond_to :account }
    it { should respond_to :father? }
    it { should respond_to :mother? }
    it { should respond_to :sibling? }
    it { should respond_to :other? }
  end

  context '#relationships' do
    it { should belong_to :account }
  end

  context '#validations' do
    it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:phone).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:kinship).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:account).with_message('não pode ficar em branco').on(:save) }
  end
end
