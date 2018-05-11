require 'spec_helper'
require 'support/factory_girl'
require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }


  context "for model functions" do
    it "should return level of user" do
      expect(user.award_points(type: "contract#created", points: 500)).to eq true
    end
  end

  context "associations" do
    it "has many events" do
      assoc = described_class.reflect_on_association(:events)
      expect(assoc.macro).to eq :has_many
    end

    it "has many reward_points" do
      assoc = described_class.reflect_on_association(:reward_points)
      expect(assoc.macro).to eq :has_many
    end
  end
end
