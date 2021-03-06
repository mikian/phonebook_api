require 'csv'

class ContactsController < ApplicationController
  before_action :set_contact, except: [:index, :download, :upload, :create]
  def index
    @contacts = Contact.all

    render json: @contacts
  end

  def download
    csv_out = CSV.generate do |csv|
      csv << ['ID', 'First Name', 'Last Name', 'Number']
      Contact.all.each do |contact|
        csv << contact.slice('id', 'first_name', 'last_name', 'number').values
      end
    end

    render text: csv_out
  end

  def upload
    if params[:file]
      ids = []

      csv = CSV.new(params[:file], headers: true)
      while row = csv.shift
        contact = if row['ID']
          Contact.find(row['ID'])
        else
          Contact.new
        end

        contact.first_name = row['First Name']
        contact.last_name  = row['Last Name']
        contact.number     = row['Number']

        contact.save
        ids << contact.id
      end

      # Delete removed contacts
      Contact.where.not(id: ids).destroy_all
    end
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
