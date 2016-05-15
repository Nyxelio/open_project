class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :family
  has_many :activities

  def exceeded?(options = {})
    sum = options.key?(:offset) ? options[:offset].to_d : 0.0
    real_duration + sum > estimated_duration
  end

  after_create :add_duration
  before_destroy :remove_duration
  around_update :update_duration

  def add_duration(duration = nil)
    real_duration = project.real_duration + (duration || self.real_duration)
    difference_hour = real_duration - project.estimated_duration
    project.update!(real_duration: real_duration, difference_hour: difference_hour)
  end

  def update_duration

    duration = self.changes.key?('real_duration') ? self.changes['real_duration'][0] : self.real_duration
    remove_duration(duration)

    yield

    duration = self.changes.key?('real_duration') ? self.changes['real_duration'][1] : self.real_duration
    add_duration(duration)
  end

  def remove_duration(duration = nil)
    real_duration = project.real_duration - (duration || self.real_duration)
    difference_hour = real_duration - project.estimated_duration
    project.update!(real_duration: real_duration, difference_hour: difference_hour)
  end

end
