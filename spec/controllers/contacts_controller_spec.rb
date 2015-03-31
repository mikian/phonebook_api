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

  describe "GET #download" do
    it "bulk downloads all contacts" do
      create_list(:contact, 5)
      get :download
      expect(response).to have_http_status(:success)
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
    it "returns requested contact" do
      contact = create(:contact)
      get :show, id: contact
      expect(response).to have_http_status(:success)
      expect(response).to match_response_schema("contact")
      expect(response_body['first_name']).to eq contact[:first_name]
    end
  end

  describe "PUT #update" do
    before :each do
      @contact = create(:contact, first_name: "Lawrence", last_name: "Smith")
    end

    context "valid attributes" do
      it "changes contact's attributes" do
        put :update, id: @contact, contact: attributes_for(:contact, first_name: 'Larry', last_name: 'Smith')
        expect(response).to have_http_status(:success)
        expect(response).to match_response_schema("contact")
        @contact.reload
        expect(@contact.first_name).to eq("Larry")
        expect(@contact.last_name).to eq("Smith")
      end

    context "with invalid attributes" do
      it "doesn't change contact's attributes" do
        put :update, id: @contact, contact: attributes_for(:contact, first_name: nil, last_name: 'Smith')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['first_name']).to eq ["can't be blank"]
        @contact.reload
        expect(@contact.first_name).to eq("Lawrence")
        expect(@contact.last_name).to eq("Smith")
      end
    end

    end
  end

  describe "DELETE #destroy" do
    before :each do
      @contact = create(:contact)
    end

    it "deletes contact" do
      expect {
        delete :destroy, id: @contact
      }.to change(Contact, :count).by(-1)
    end
  end

end
