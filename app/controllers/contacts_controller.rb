class ContactsController < ApplicationController
  before_action :set_organization
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = @organization.contacts
  end

  def show; end

  def new
    @contact = @organization.contacts.new
  end

  def create
    @contact = @organization.contacts.new(contact_params)

    if @contact.save
      redirect_to organization_contact_path(@organization, @contact), success: success_message(@contact, :created)
    else
      flash_error_message
      render :new
    end
  end

  def edit; end

  def update
    if @contact.update(contact_params)
      redirect_to organization_contact_path(@organization, @contact), success: success_message(@contact, :updated)
    else
      flash_error_message
      render :edit
    end
  end

  def destroy
    @contact.destroy

    redirect_to organization_contacts_path(@organization), success: success_message(@contact, :destroyed)
  end

  private

  def set_organization
    @organization = current_user.organizations.find(params[:organization_id])
  end

  def set_contact
    @contact = @organization.contacts.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :organization_id, :suffix)
  end
end
