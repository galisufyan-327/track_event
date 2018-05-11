require 'spec_helper'
require 'support/factory_girl'

RSpec.describe EventsController, type: :controller do
  render_views

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

  let(:event_2_attributes) do
    {
      target_type: "contract",
      target_uuid: "4",
      event_type: "updated",
      trigered_at: DateTime.now,
      company_id: "1",
      user_id: "1"
    }
  end

  let(:event_3_attributes) do
    {
      target_type: "telecomservice",
      target_uuid: "4",
      event_type: "updated",
      trigered_at: DateTime.now,
      company_id: "1",
      user_id: "1"
    }
  end

  let(:user) { create(:user) }
  let(:user2) { create(:user, orignal_id: "2", guid: "sample_1") }
  let(:user3) { create(:user, orignal_id: "3", guid: "sample_2") }
  let(:event1) { create(:event, event_1_attributes) }
  let(:event2) { create(:event, event_2_attributes)}
  let(:event3) { create(:event, event_3_attributes)}

  describe "Get #index" do
    it "should render index page on request" do
      user.events << event1
      user.events << event2
      get :index, params: { format: :json, token: JsonWebToken.encode(id: user.orignal_id) }
      expect(response).to have_http_status(:ok)
      res = JSON.parse(response.body)
      expect(res['user']['orignal_id']).to eq 1
      expect( res['events'][0]['target_uuid']).to eq "3"
      expect( res['events'][1]['target_uuid']).to eq "4"
    end
  end


  describe "POST create" do
    context "with valid attributes" do
      it "creates a new event for user" do
        expect{post :create, params: { format: :json, token: JsonWebToken.encode(id: user2.orignal_id), target_type: "contract",target_uuid: "5",event_type: "updated"} }.to change(Event, :count).by(1)
        res = JSON.parse(response.body)
        expect(res['user']['orignal_id']).to eq 2
        expect( res['event']['target_uuid']).to eq "5"
      end
    end
  end

  describe "Get #show" do
    it "should display event of a user" do
      expect{post :create, params: { format: :json, token: JsonWebToken.encode(id: user3.orignal_id), target_type: "contract", target_uuid: "10", event_type: "updated"} }.to change(Event, :count).by(1)
      get :show, params: { format: :json,id: "4", token: JsonWebToken.encode(id: user3.orignal_id) }
      expect(response).to have_http_status(:ok)
      res = JSON.parse(response.body)
      expect(res['id']).to eq 4
    end
  end


end
