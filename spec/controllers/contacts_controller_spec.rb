require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  describe "GET #index" do
    it "populates an array of contacts" do
      create_list(:contact, 5)
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("contacts")
      expect(response_body.count).to be 5
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new contact in the database" do
        contact_attributes = attributes_for(:contact)
        expect {
          post :create, contact: contact_attributes
        }.to change(Contact, :count).by(1)

        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema("contact")
        expect(response_body['first_name']).to eq contact_attributes[:first_name]
      end
    end

    context "with invalid attributes" do
      it "does not save the new contact in the database" do
        contact_attributes = attributes_for(:contact).merge(first_name: nil)
        expect {
          post :create, contact: contact_attributes
        }.to_not change(Contact,:count)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['first_name']).to eq ["can't be blank"]
      end
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
