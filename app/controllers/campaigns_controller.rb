class CampaignsController < ApplicationController
  before_action :set_campaign, only: %i[show edit update destroy]

  # GET /campaigns or /campaigns.json
  def index
    @campaigns = current_user.campaigns
  end

  # GET /campaigns/1 or /campaigns/1.json
  def show
    authorize @campaign
    @tasks = @campaign.tasks.order('kind, created_at')#.group_by(&:kind)
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
    authorize @campaign
  end

  # POST /campaigns or /campaigns.json
  def create
    @campaign = current_user.campaigns.build(campaign_params)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, success: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1 or /campaigns/1.json
  def update
    authorize @campaign

    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, success: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1 or /campaigns/1.json
  def destroy
    authorize @campaign
    
    @campaign.destroy!

    respond_to do |format|
      format.html { redirect_to campaigns_path, status: :see_other, success: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_campaign
    @campaign = current_user.campaigns.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def campaign_params
    params.expect(campaign: %i[user_id name description status rate engagement_rate reach clicks]).tap do |campaign|
      campaign[:user] = current_user
    end
  end
end
