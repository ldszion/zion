require 'rails_helper'

describe Event do
  context '#responsive_methods' do
    it { should respond_to :name }
    it { should respond_to :start_datetime }
    it { should respond_to :end_datetime }
    it { should respond_to :description }
    it { should respond_to :start_date }
    it { should respond_to :start_time }
    it { should respond_to :end_date }
    it { should respond_to :end_time }
    it { should respond_to :free? }
    it { should respond_to :paid? }
    it { should respond_to :public? }
    it { should respond_to :private? }
  end

  context '#relationships' do
    it { should have_and_belong_to_many :users }
  end

  context '#validations' do
    context '#required' do
      it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
      it { should validate_presence_of(:start_datetime).with_message('não pode ficar em branco') }
      it { should validate_presence_of(:end_datetime).with_message('não pode ficar em branco') }
      it { should validate_presence_of(:description).with_message('não pode ficar em branco') }
    end
  end

  context '#valid' do
    subject { Event.first }
    it { should be_valid }
  end
end
