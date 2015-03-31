class ContactsController < ApplicationController
  def index
    @contacts = Contact.all

    render json: @contacts
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
