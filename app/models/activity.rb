class Activity < ActiveRecord::Base
  belongs_to :worker
  belongs_to :task

  def has_exceeded_worker?
    self.class.find_exceeded_workers(date_activity, worker.name).length > 0
  end

  def has_exceeded_task?
    task.exceeded?
  end

  after_create :add_duration
  before_destroy :remove_duration
  around_update :update_duration

  def add_duration(duration = nil)
    real_duration = task.real_duration + (duration || num_hours)
    ratio = real_duration / task.estimated_duration
    task.update!(real_duration: real_duration, ratio: ratio)
  end

  def update_duration
    remove_duration changes['num_hours'][0]

    yield

    add_duration changes['num_hours'][1]
  end

  def remove_duration(duration = nil)
    real_duration = task.real_duration - (duration || num_hours)
    ratio = real_duration / task.estimated_duration
    task.update!(real_duration: real_duration, ratio: ratio)
  end

  class << self
    def find_exceeded_workers(date, worker_name, options = {})
      activities = joins(:worker).where(date_activity: date, workers: {name: worker_name })
      sum = activities.sum(:num_hours).to_d
      sum += options[:offset].to_d if options.key?(:offset)
      sum > Setting.hours_per_day ? activities : []
    end
  end
end
