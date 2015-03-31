class ContactsController < ApplicationController
  before_action :set_contact, except: [:index, :create]
  def index
    @contacts = Contact.all

    render json: @contacts
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @contact
  end

  def update
    @contact.assign_attributes(contact_params)
    if @contact.save
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
    render json: [], status: :no_content
  end

  private
  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :number)
  end
end
