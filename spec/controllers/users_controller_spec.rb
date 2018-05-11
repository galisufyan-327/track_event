require 'spec_helper'
require 'support/factory_girl'

RSpec.describe UsersController, type: :controller do
  render_views

  describe "Get #index" do
    let(:user) { create(:user) }
    it "should render index page on request" do
      get :index, params: { format: :json, token: JsonWebToken.encode(id: user.orignal_id) }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new user" do
        expect{post :create, params: {format: :json, orignal_id: "1", guid: "sample_1", email: "usr1@nulodgic.com"}}.to change(User, :count).by(1)
        res = JSON.parse(response.body)
        expect(res['user']['guid']).to eq "sample_1"
      end
    end
  end

  describe "Get #show" do
    let(:user) { create(:user,orignal_id: "23",guid: "sample_2") }
    it "should display user" do
      get :show, params: { format: :json,id: user.orignal_id, token: JsonWebToken.encode(id: user.orignal_id) }
      expect(response).to have_http_status(:ok)
      res = JSON.parse(response.body)
      expect(res['guid']).to eq "sample_2"
    end
  end
end
