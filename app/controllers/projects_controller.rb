class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :summary]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    redirect_to project_tasks_path(params[:id])
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  def summary
    ########
    @activities_series = []

    @dates = @project.tasks.collect{ |task| task.activities.collect(&:date_activity) }.flatten.uniq

    tasks = @project.tasks
    tasks.each do |task|
      data_task = { name: task.label, data: [] }
      @dates.each do |date|
        sum = Activity.where(task: task, date_activity: date).sum(:num_hours).to_f || 0
        data_task[:data] << sum
      end
      @activities_series << data_task
    end

    @dates.collect!{|date| l date}


    ########
    total_hours = @project.tasks.collect(&:real_duration).flatten.inject(0, :+)
    @tasks_series = []
    @tasks_series = @project.tasks.collect do |task|
      { name: "#{task.label} (#{task.real_duration.to_f}h)", value: task.real_duration.to_f, y: (task.real_duration/total_hours * 100).round(0).to_f }
    end

  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :is_close, :estimated_start_at, :estimated_end_at, :estimated_duration, :real_start_at, :real_end_at, :real_duration, :difference_hour)
    end
end
