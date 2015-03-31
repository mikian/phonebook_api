require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      create_list(:contact, 5)
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("contacts")
      expect(response_body.count).to be 5
    end
  end

  describe "GET #create" do
    xit "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    xit "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    xit "returns http success" do
      put :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    xit "returns http success" do
      delete :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
