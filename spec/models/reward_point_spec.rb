require 'rails_helper'
require 'spec_helper'
require 'support/factory_girl'

RSpec.describe RewardPoint, type: :model do
  let(:user) { create(:user) }

  context "associations" do
    it "belongs to user" do
      assoc = described_class.reflect_on_association(:user)
      expect(assoc.macro).to eq :belongs_to
    end
  end
end
