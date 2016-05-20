class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :create, :index, :new, :filter]
  respond_to :json, only: [:search]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.joins(:task).where(tasks: {project_id: @project}).order(date_activity: :asc)
    @activity = Activity.new
    @workers = Worker.all
    @tasks = Task.where(project_id: @project)
    @start_at_year = @project.estimated_start_at.year
    
    if @project.real_end_at.nil?
      @stop_at_year = @project.estimated_end_at.year
    else
      @stop_at_year = @project.real_end_at.year
    end
  end

  def search(*args)
    options = params || args.extract_options!
    res = []
    if options[:date_activity] and options[:input]
      if options[:worker_name]
        q = Activity.find_exceeded_workers(Date.parse(options[:date_activity]), options[:worker_name], offset: options[:input])
        if q.length > 0
          res = q.collect(&:id)
        end
      end
    elsif !options[:date_activity] and options[:input] and options[:task_id]
      q = Task.find(options[:task_id]).exceeded?(offset: options[:input])
      if q
        res = Activity.where(task_id: options[:task_id]).collect(&:id)
      end
    end
    respond_with res
  end

  def filter
    string = []
    unless activity_params[:worker].empty?
      string << "worker_id = #{activity_params[:worker]}"
    end

    unless activity_params[:year].empty?
      string << "date_activity >= '#{Date.new(activity_params[:year].to_i, 1,1)}' and date_activity <= '#{Date.new(activity_params[:year].to_i, 12,31)}'"
    end

    unless activity_params[:month].empty? || activity_params[:month].to_i == 0
      curr_year =  activity_params[:year].empty? ? Date.today.year: activity_params[:year].to_i
      string << "date_activity >= '#{Date.new(curr_year, activity_params[:month].to_i,1)}' and date_activity <= '#{Date.new(curr_year, activity_params[:month].to_i,Date.new(curr_year, activity_params[:month].to_i,1).end_of_month.day)}'"
    end

    p activity_params[:task]
    unless activity_params[:task].empty?
      string << "task_id = #{activity_params[:task]}"
    end

    if string.empty?
      @activities = Activity.joins(:task).where(tasks: {project_id: @project}).order(date_activity: :asc)
    else
      string << "project_id = #{@project.id}"
      string = string.join(' and ')
      @activities = Activity.joins(:task).where(string).order(date_activity: :asc)
    end

    if params[:exceeded]
      @activities = @activities.select{|activity| activity.has_exceeded_task? or activity.has_exceeded_worker? }
    end

    respond_to do |format|
      if @activities.nil?
        format.js { render partial: 'activity', notice: @activity.errors }
        format.html { render :show }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      else
        format.js { render partial: 'activity', locals: {activities: @activities, is_filted: true} }
        format.html { redirect_to @activities, notice: 'Activities was successfully filted.' }
        format.json { render :show, status: :filted, location: @activity }
      end
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.js { render partial: 'activity', locals: {activities: [@activity], is_filted: false} }
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.js { render partial: 'activity', notice: @activity.errors }
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to project_activity_url(@project, @activity), notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to project_activities_url(@project), notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id]) if params[:id]
      @project = Project.find(params[:project_id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:num_hours, :worker_id, :task_id, :observation, :date_activity, :month, :year, :worker, :task)
    end
end
