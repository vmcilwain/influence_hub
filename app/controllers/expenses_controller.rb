class ExpensesController < ApplicationController
  before_action :set_campaign
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = @campaign.expenses
  end

  def show; end

  def new
    @expense = @campaign.expenses.new
  end

  def create
    @expense = @campaign.expenses.new(expense_params)
    
    if @expense.save
      redirect_to campaign_expenses_path(@campaign), success: success_message(@expense, 'created')
    else
      flash_error_message
      render :new
    end
  end

  def edit; end

  def update
    if @expense.update(expense_params)
      redirect_to campaign_expenses_path(@campaign), success: success_message(@expense, 'updated')
    else
      flash_error_message
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to campaign_expenses_path(@campaign), success: success_message(@expense, 'deleted')
  end

  private

  def set_campaign
    @campaign = current_user.campaigns.find(params[:campaign_id])
  end

  def set_expense
    @expense = @campaign.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :category, :purchased_on, :billable).tap do |expense|
      expense[:user] = current_user
      expense[:campaign] = @campaign
    end
  end
end
