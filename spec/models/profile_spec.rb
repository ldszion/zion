require 'rails_helper'

describe Profile do
  context '#profiles' do
    subject { Profile.pluck(:key) }

    it { should include(Profile::USER) }
    it { should include(Profile::ADMIN) }
    it { should include(Profile::WARD_LEADER) }
    it { should include(Profile::STAKE_LEADER) }
    it { should include(Profile::REGION_LEADER) }
  end
end
