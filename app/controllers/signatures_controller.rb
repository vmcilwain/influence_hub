class SignaturesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:review, :sign]
  before_action :set_signature_for_signing, only: [:review, :sign]
  before_action :set_document, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :set_signature, only: [:show, :edit, :update, :destroy]

  # GET /signature
  def index
    @signatures = @document.signatures
  end

  # GET /signature/1
  def show
  end

  # GET /signature/new
  def new
    @signature = @document.signatures.new
  end

  # POST /signature
  def create
    @signature = @document.signatures.new(signature_params)

    if @signature.save
      redirect_to document_signature_url(@document, @signature), success: success_message(@signature)
    else
      flash_error_message
      render :new
    end
  end

  # GET /signature/1/edit
  def edit
  end

  # PATCH/PUT /signature/1
  def update
    if @signature.update(signature_params)
      redirect_to document_signature_url(@document, @signature), success: success_message(@signature, :updated)
    else
      flash_error_message
      render :edit
    end
  end

  # DELETE /signature/1
  def destroy
    @signature.destroy
    redirect_to document_signatures_url(@document), success: success_message(@signature, :destroyed)
  end

  def review; end

  def sign
    if @signature.signature_verified(signed_signature_params)
      redirect_to document_signature_url(@signature.document, @signature), success: success_message(@signature, :signed)
    else
      flash_error_message
      render :review
    end
  end

  private

  def set_document
    @document = current_user.documents.find(params[:document_id])
  end

  def set_signature
    @signature = @document.signatures.find(params[:id])
  end

  def set_signature_for_signing
    @signature = Signature.find_by!(external_id: params[:external_id])
  end

  def signature_params
    params.require(:signature).permit(:signee_email, :status, :campaign_id, :document_id, :signature)
  end

  def signed_signature_params
    params.require(:signature).permit(:signee_signature, :security_code)
  end
end