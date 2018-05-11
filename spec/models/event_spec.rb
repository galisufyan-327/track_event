require 'spec_helper'
require 'support/factory_girl'
require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { create(:user) }
  let(:user2) { create(:user, guid: "sample") }
  let(:event_1_attributes) do
    {
      target_type: "contract",
      target_uuid: "3",
      event_type: "created",
      trigered_at: DateTime.now,
      company_id: "1",
      user_id: "1"
    }
  end

  context "for model functions" do
    it "should check for reward on event creation" do
    user.events.create(target_type: "contract", target_uuid: "3", event_type: "created", user_id: user.id)
    expect(user.total_reward_points).to eq 700
    end
  end

  context "for target_type and target_uuid validation" do
    it "should validate presence of target_type, event_type, target_uuid and user_id" do
      user2.events.create(event_1_attributes)
      user2.events[0]['target_type'] = nil
      user2.events[0]['event_type'] = nil
      user2.events[0]['target_uuid'] = nil
      user2.events[0]['user_id'] = nil
      user2.events[0].valid?
      expect(user2.events[0].errors[:target_type][0]).to eq "can't be blank"
      expect(user2.events[0].errors[:target_uuid][0]).to eq "can't be blank"
      expect(user2.events[0].errors[:event_type][0]).to eq "can't be blank"
      expect(user2.events[0].errors[:user_id][0]).to eq "can't be blank"
    end
  end

  context "associations" do
    it "belongs to user" do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
