class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[show edit update destroy]

  def index
    @organizations = current_user.organizations
  end

  def show; end

  def new
    @organization = Organization.new
  end

  def edit; end

  def create
    @organization = Organization.new(organization_params)
    
    if @organization.save
      redirect_to @organization, success: success_message(@organization, :created)
    else
      flash_error_message
      render :new
    end
  end

  def update
    if @organization.update(organization_params)
      redirect_to @organization, success: success_message(@organization, :updated)
    else
      flash_error_message
      render :edit
    end
  end

  def destroy
    @organization.destroy

    redirect_to organizations_url, success: success_message(@organization, :destroyed)
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization)
          .permit(:name, :address, :address2, :city, :state, :zipcode, :phone, :status, campaign_ids: []).tap do |organization|
      organization[:user] = current_user
      organization[:campaigns] = Campaign.where(id: organization[:campaign_ids])
    end
  end
end
