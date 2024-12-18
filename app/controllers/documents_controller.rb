class DocumentsController < ApplicationController
  before_action :set_document, only: %i[show edit update destroy]

  def index
    @documents = current_user.documents
  end

  def show; end

  def new
    @document = current_user.documents.new
  end

  def edit; end

  def create
    @document = current_user.documents.new(document_params)

    if @document.save
      redirect_to document_url(@document), success: success_message(@document)
    else
      flash_error_message
      render :new
    end
  end

  def update
    if @document.update(document_params)
      redirect_to document_url(@document), success: success_message(@document, :updated)
    else
      flash_error_message
      render :edit
    end
  end

  def destroy
    @document.destroy
    redirect_to documents_url, success: success_message(@document, :destroyed)
  end

  private

  def set_document
    @document = current_user.documents.find(params[:id])
  end

  def document_params
    params.require(:app_document).permit(:name, :content, :status).tap do |document|
      document[:user] = current_user
    end
  end
end
