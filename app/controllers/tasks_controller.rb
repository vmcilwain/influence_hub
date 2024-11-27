class TasksController < ApplicationController
  before_action :set_campaign
  before_action :set_task, only: %i[show edit update destroy update_status]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to campaign_task_url(@campaign, @task), success: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to campaign_task_url(@campaign, @task), success: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    if @task.update(task_params)
      respond_to do |format|
        format.json { head :no_content }
        format.html { redirect_to tasks_path, notice: 'Task updated successfully.' }
      end
    else
      respond_to do |format|
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.html { render :edit }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to campaign_tasks_url(@campaign), status: :see_other, success: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_campaign
    @campaign = current_user.campaigns.find(params.expect(:campaign_id))
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = @campaign.tasks.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.expect(task: %i[description status due_on kind rate engagement_rate reach clicks details]).tap do |task|
      task[:user] = current_user
      task[:campaign] = @campaign
    end
  end
end
