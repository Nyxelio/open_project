class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :create, :index, :new]
  respond_to :json, only: [:search]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.joins(:task).where(tasks: {project_id: @project})
    @activity = Activity.new
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
    end
    respond_with res
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
        format.js { render partial: 'activity' }
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
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
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
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
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
      params.require(:activity).permit(:num_hours, :worker_id, :task_id, :observation, :date_activity)
    end
end
