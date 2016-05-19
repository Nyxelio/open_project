class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :index, :new, :create, :provisional_schedule]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.where(project: @project)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  def provisional_schedule
    @pgantt = []
    Task.order(estimated_start_at: :asc).find_each do |task|
      end_date = task.real_end_at.nil? ? Date.today : task.real_end_at
      start_date = task.real_start_at.nil? ? Date.today : task.real_start_at

      values = [{ from: "/Date(#{task.estimated_start_at.to_time.to_i*1E3.round(0)})/", to: "/Date(#{task.estimated_end_at.to_time.to_i*1E3.round(0)})/", label: task.label, desc: task.label, customClass: 'bg-primary' },{ from: "/Date(#{start_date.to_time.to_i*1E3.round(0)})/", to: "/Date(#{end_date.to_time.to_i*1E3.round(0)})/", label: "#{task.label} (#{task.percent_progress}%)", desc: "#{task.label} (#{task.percent_progress}%)", customClass: 'bg-warning'}]

      if !task.real_end_at.nil? and !task.estimated_end_at.nil? and task.real_end_at > task.estimated_end_at
        exceed = { from: "/Date(#{task.estimated_end_at.next_day.to_time.to_i*1E3.round(0)})/", to: "/Date(#{task.real_end_at.to_time.to_i*1E3.round(0)})/", label: "#{(task.real_end_at - task.estimated_end_at).to_i}j", desc: '', customClass: 'bg-alert'  }
        values.push exceed
      end

      @pgantt << { name: task.family.nil? ? '' : task.family.label, desc: task.label, values: values }
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    @task.project = @project

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        p @task.errors
        format.html { redirect_to project_tasks_path(@project), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_url(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @project = Project.find(params[:project_id])
      @task = Task.find(params[:id]) if params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:code, :label, :estimated_start_at, :estimated_end_at, :estimated_duration, :real_start_at, :real_end_at, :real_duration, :percent_progress, :ratio, :family_id)
    end
end
